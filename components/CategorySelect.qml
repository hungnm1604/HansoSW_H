import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15


Item {

    id: root
    width: 800
    height: 480

    property alias logoSource: logo.source
    property string csSSelectMsg: ""
    property string csNameButton1: ""
    property string csNameButton2: ""
    property string csNameButton3: ""
    property string csNameButton4: ""
    property string csNameButton5: ""
    property string csNameButton6: ""

    // BackgroundMyButton
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
            text: "시스템 대기"
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


    // ===== Header at center =====
    Rectangle {
        id: headcentererBox
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: topBar.bottom
        anchors.topMargin: 16
        width: Math.min(root.width * 0.7, 520)
        height: 48
        radius: 6
        color: "#f1f3f5"
        border.color: "#2f3c4a"
        border.width: 2

        Text {
            anchors.centerIn: parent
            text: csSSelectMsg
            color: "#222"
            font.pixelSize: 20
            font.bold: true
        }
    }

    //Ending Header


    //Create 6 button
    Grid {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        columns: 3
        rowSpacing: 30
        columnSpacing: 30

        CommonButton {
            text: csNameButton1
            onClicked: console.log("방독면 선택")
        }
        CommonButton {
            text: csNameButton2
            onClicked: console.log("헬멧 선택")
        }
        CommonButton {
            text: csNameButton3
            onClicked: console.log("조끼 선택")
        }
        CommonButton {
            text: csNameButton4
            onClicked: console.log("수통 선택")
        }
        CommonButton {
            text: csNameButton5
            onClicked: console.log("전자기기 선택")
        }
        CommonButton {
            text: csNameButton6
            onClicked: console.log("개인화기 선택")
        }
    }

}
