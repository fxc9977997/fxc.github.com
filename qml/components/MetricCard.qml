import QtQuick

Rectangle {
    id: root
    property string title: ""
    property string value: ""
    property color accent: "#3b82f6"
    property string suffix: ""

    radius: 10
    color: "#151d2e"
    border.color: "#1e2d4a"

    Rectangle {
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        height: 3
        radius: 3
        color: root.accent
    }

    Column {
        anchors.fill: parent
        anchors.margins: 10
        spacing: 6

        Text { text: root.title; color: "#93a4be"; font.pixelSize: 11 }
        Row {
            spacing: 2
            Text { text: root.value; color: root.accent; font.pixelSize: 24; font.bold: true }
            Text { text: root.suffix; color: "#64748b"; font.pixelSize: 11; anchors.verticalCenter: parent.verticalCenter }
        }
    }
}
