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


}
