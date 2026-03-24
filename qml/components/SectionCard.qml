import QtQuick

Rectangle {
    id: root
    property string title: ""
    default property alias content: contentArea.data

    radius: 10
    color: "#151d2e"
    border.color: "#1e2d4a"

    Column {
        anchors.fill: parent

        Rectangle {
            width: parent.width
            height: 36
            color: "transparent"
            border.color: "#1e2d4a"

            Text {
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: 12
                text: root.title
                color: "#e8ecf4"
                font.pixelSize: 12
                font.bold: true
            }
        }

        Item {
            id: contentArea
            width: parent.width
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.topMargin: 0
        }
    }
}
