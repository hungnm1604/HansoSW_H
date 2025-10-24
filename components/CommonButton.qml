import QtQuick 2.15
import QtQuick.Controls 2.15

Rectangle {
    id: root
    property alias text: label.text
    signal clicked()

    width: 150
    height: 80
    radius: 16
    color: rootMouseArea.pressed ? "#a6a6a6" : "#bcbcbc"
    border.color: "#334155"
    border.width: rootMouseArea.containsMouse ? 3 : 2
    opacity: 1.0

    // Text
    Text {
        id: label
        anchors.centerIn: parent
        font.pixelSize: 28
        font.bold: true
        color: "#111"
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }

    // MouseArea
    MouseArea {
        id: rootMouseArea
        anchors.fill: parent
        hoverEnabled: true
        onClicked: root.clicked()
    }
}
