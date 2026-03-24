import QtQuick
import QtQuick.Controls
import "../DataStore.js" as DataStore

Rectangle {
    id: root
    property string currentSubsystem: "gen"
    signal subsystemSelected(string subsystemKey)

    color: "#0f172a"
    border.color: "#1e2d4a"

    Column {
        anchors.fill: parent
        anchors.margins: 8
        spacing: 4

        Text { text: "子系统导航"; color: "#4a5568"; font.bold: true; font.pixelSize: 10 }

        Repeater {
            model: DataStore.subsystemKeys().length
            delegate: Rectangle {
                property string key: DataStore.subsystemKeys()[index]
                property var sub: DataStore.subsystemData[key]

                width: parent.width
                height: 32
                radius: 6
                color: root.currentSubsystem === key ? "#0e7490" : "transparent"
                border.color: root.currentSubsystem === key ? "#06b6d4" : "transparent"

                Row {
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.left
                    anchors.leftMargin: 8
                    spacing: 6
                    Text { text: sub.icon }
                    Text { text: sub.name; color: root.currentSubsystem === key ? "#67e8f9" : "#93a4be"; font.pixelSize: 12 }
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: root.subsystemSelected(key)
                }
            }
        }
    }
}
