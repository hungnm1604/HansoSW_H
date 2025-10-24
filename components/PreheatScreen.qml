// PreheatScreen.qml
import QtQuick 2.15
import QtQuick.Controls 2.15

Item {
    id: root
    width: 800
    height: 480

    // ==== API ====
    property alias logoSource: logo.source
    property string productName: ""
    property int preheat1Sec: 1800        // 예열 1 단계 (초)
    property int preheat2Sec: 1800        // 예열 2 단계 (초)
    property int holdMs: holdMs         //
    signal finished()                  // Finish
    signal skipped()                   // skip riêng nếu cần

    // ==== Internal state ====
    property int totalSec: Math.max(0, preheat1Sec + preheat2Sec)
    property int remainingSec: totalSec
    property bool running: false
    property bool isRunFinish: false
    property bool skipRequested: false
    property int currentStage: 0       // 1=예열1, 2=예열2


    // Background
    Rectangle {
        anchors.fill: parent
        color: "#f1f3f5"
        border.color: "#3a6ea5"
        border.width: 1
        radius: 8
    }

    // ===== TOP BAR + bottom line =====
    Rectangle {
        id: topBar
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        height: 56
        color: "transparent"

        // Title
        Text {
            id: title
            text: productName
            anchors.left: parent.left
            anchors.leftMargin: 24
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: 24
            font.bold: true
            color: "#3b3b3b"
            elide: Text.ElideRight
            width: parent.width - logo.width - 80
        }

        // Logo right and hold to go admin
        Image {
            id: logo
            source: ""
            anchors.right: parent.right
            anchors.rightMargin: 24
            anchors.verticalCenter: parent.verticalCenter
            sourceSize.width: 160
            fillMode: Image.PreserveAspectFit

            MouseArea {
                id: logoArea
                anchors.fill: parent
                hoverEnabled: true
                pressAndHoldInterval: root.holdMs

                onPressAndHold:{
                    skipRequested = true
                    skipAll()
                }
            }
            // tooltip
            ToolTip.visible: logoArea.containsPress
            ToolTip.text: "Hold " + Math.round(root.holdMs/1000) + "s to skip preheat"

        }

        // bottom lineCenter
        Rectangle {
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            height: 1
            color: "#A7ADB4"
        }
    }
    // ===== Ending TOP BAR =====

    // ===== CENTER AREA =====
    Item {
        id: centerArea
        anchors {
            top: parent.top //topBar.bottom
            bottom: progressArea.top
            left: parent.left
            right: parent.right
            topMargin:  0
            bottomMargin: 12
        }

        Column {
            id: centerBox
            anchors.centerIn: parent
            spacing: 16

            // 상태 표시줄
            Rectangle {
                id: statusBox
                anchors.horizontalCenter: parent.horizontalCenter
                width: 480
                height: 40
                radius: 8
                border.color: "#5f6b77"; border.width: 2
                color: "transparent"


                Text {
                    anchors.centerIn: parent
                    text: statusText()
                    color: "#333"; font.pixelSize: 18; font.bold: true
                }
            }

            // 남은시간
            Text {
                id: timerText
                text: formatMMSS(remainingSec)
                font.pixelSize: 96
                font.bold: true
                color: "#2e63ff"
                horizontalAlignment: Text.AlignHCenter
                anchors.horizontalCenter: parent.horizontalCenter
            }

            // Nhãn dưới timer
            Text {
                text: "남은 시간"
                font.pixelSize: 20
                color: "#555"
                horizontalAlignment: Text.AlignHCenter
                anchors.horizontalCenter: parent.horizontalCenter
            }
        }
    }

    // ===== PROGRESS Near bottom =====
    Item {
        id: progressArea
        anchors {
            left: parent.left
            right: parent.right
            bottom: parent.bottom
            leftMargin: 0
            rightMargin: 0
            bottomMargin: 24
        }
        height: 64

        Column {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            spacing: 8

            //
            Row {
                spacing: 6
                anchors.horizontalCenter: centerArea.left
                Text { text: "진행율 :"; font.pixelSize: 18; color: "#333" }
                Text { text: Math.round(progress()*100) + " %"; font.pixelSize: 24; color: "#333" }
            }

            ProgressBar {
                id: bar
                width: Math.min(root.width * 0.8, 480)
                from: 0; to: 1
                value: progress()
            }
        }
    }



    // Ending Center

    // ==== FUNCTIONS ====sys
    function formatMMSS(sec) {
        var m = Math.floor(sec / 60)
        var s = sec % 60
        return (m < 10 ? "0" + m : m) + ":" + (s < 10 ? "0" + s : s)
    }

    function progress() {
        if (totalSec <= 0) return 1
        return (totalSec - remainingSec) / totalSec
    }


    function statusText() {
        if (skipRequested) return "예열 공정 건너뜀"
        if (!running)
        {
            if(isRunFinish==true) return "예열 완료"
            else return "시스템 준비중"
        }
        if (currentStage === 1) return "예열 1 진행중"
        if (currentStage === 2) return "예열 2 진행중"
        return "예열 완료"
    }

    function skipAll() {
        skipRequested = true
        running = false
        tick.stop()
        remainingSec = 0
        bar.value = 1
        root.skipped()
        root.finished()
    }

    function finishAll() {
        running = false
        isRunFinish = true
        tick.stop()
        bar.value = 1
        root.finished()
    }

    // ==== TIMER ====
    Timer {
        id: tick
        interval: 1000
        repeat: true
        onTriggered: {
            if (remainingSec > 0) {
                remainingSec--
                var spent = totalSec - remainingSec
                if (spent >= preheat1Sec && currentStage === 1 && preheat2Sec > 0)
                    currentStage = 2
            } else finishAll()
        }
    }

    // ==== START ====
    Component.onCompleted: {
        if (typeof sys !== "undefined" && !sys.checkALStatus()) {
            console.log("AL check failed, preheat stopped.")
            return
        }

        if (totalSec <= 0) { // 모든 시간이 0이면 skip
            skipAll()
            return
        }

        // Initiallize in 3sec: "시스템 준비중"
        running = false
        currentStage = 0

        //after 3 secon 예열
        Qt.createQmlObject('import QtQuick 2.15; Timer { interval: 3000; running: true; repeat: false; onTriggered: { root.startPreheat() } }', root)
    }

    function startPreheat() {
        currentStage = preheat1Sec > 0 ? 1 : (preheat2Sec > 0 ? 2 : 0)
        running = true
        tick.start()
    }
}
