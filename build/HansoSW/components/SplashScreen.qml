// SplashScreen.qml
import QtQuick 2.15
import QtQuick.Controls 2.15

Item {
    id: root
    width: 800
    height: 480

    // ---- API ----
    property alias logoSource: logo.source
    property alias splashImgSource: splashImg.source
    property string productName: ""
    property string model: ""
    property string website: ""
    property string email: ""
    property int splashMs: 3000
    property int holdMs: 1500

    signal enterAdmin()
    signal finished()

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
                anchors.fill: parent
                hoverEnabled: true
                pressAndHoldInterval: root.holdMs
                onPressAndHold: root.enterAdmin()
            }
            // tooltip
            ToolTip.visible: ma.containsPress
            ToolTip.text: "Hold " + Math.round(root.holdMs/1000) + "s to access Admin"
            MouseArea { id: ma; anchors.fill: parent }
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

    // Center
    Column {
        spacing: 10
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter

        Image {
            id: splashImg
            source: ""
            width: 360
            fillMode: Image.PreserveAspectFit
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Text {
            text: model
            font.pixelSize: 36
            font.bold: true
            color: "#3b3b3b"
            horizontalAlignment: Text.AlignHCenter
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }

    // ===== Ending Center =====

    //Email and adreess
    Column {
        id: contactInfo
        spacing: 4
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: bar.top
        anchors.bottomMargin: 20
        Text {
            text: website ? "W: " + website : ""
            font.pixelSize: 18
            color: "#555"
        }
        Text {
            text: email ? "E: " + email : ""
            font.pixelSize: 18
            color: "#555"
        }
    }

     // ===== Ending Email and Address =====

    // Progress bar
    ProgressBar {
        id: bar
        width: Math.min(parent.width * 0.8, 480)
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 28
        from: 0
        to: 1
        value: 0
    }

    // Autmatic progress bar and go to finished()
    NumberAnimation {
        id: barAnim
        target: bar
        property: "value"
        from: 0; to: 1
        duration: root.splashMs
        running: true
        onStopped: root.finished()
    }
}
