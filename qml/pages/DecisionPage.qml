import QtQuick
import QtQuick.Layouts
import "../DataStore.js" as DataStore
import "../components"

Item {
    ColumnLayout {
        anchors.fill: parent
        spacing: 10

        Text { text: "辅助决策"; color: "#e8ecf4"; font.pixelSize: 16; font.bold: true }

        SectionCard {
            title: "决策列表"
            Layout.fillWidth: true
            Layout.fillHeight: true

            ListView {
                anchors.fill: parent
                anchors.margins: 10
                model: DataStore.decisions
                spacing: 6

                delegate: Rectangle {
                    width: ListView.view.width
                    height: 66
                    radius: 8
                    color: "#0b1220"
                    border.color: modelData.priority === "高" ? "#ef4444" : (modelData.priority === "中" ? "#f59e0b" : "#3b82f6")

                    Column {
                        anchors.fill: parent
                        anchors.margins: 8
                        spacing: 4
                        Text { text: modelData.id + " · " + modelData.component + " · 优先级 " + modelData.priority; color: "#e8ecf4"; font.bold: true }
                        Text { text: modelData.suggestion; color: "#93a4be"; wrapMode: Text.Wrap }
                    }
                }
            }
        }
    }
}
