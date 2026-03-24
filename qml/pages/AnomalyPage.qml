import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import "../DataStore.js" as DataStore
import "../components"

Item {
    ColumnLayout {
        anchors.fill: parent
        spacing: 10

        Text { text: "异常报警管理"; color: "#e8ecf4"; font.pixelSize: 16; font.bold: true }

        RowLayout {
            Layout.fillWidth: true
            MetricCard { Layout.fillWidth: true; Layout.preferredHeight: 92; title: "危险(2)"; value: "2"; accent: "#ef4444" }
            MetricCard { Layout.fillWidth: true; Layout.preferredHeight: 92; title: "警告(1)"; value: "1"; accent: "#f59e0b" }
            MetricCard { Layout.fillWidth: true; Layout.preferredHeight: 92; title: "已处理"; value: "0"; accent: "#10b981" }
            MetricCard { Layout.fillWidth: true; Layout.preferredHeight: 92; title: "检测算法"; value: "3"; suffix: "3σ/KMeans/AE"; accent: "#3b82f6" }
        }

        SectionCard {
            title: "报警数据表"
            Layout.fillWidth: true
            Layout.fillHeight: true

            ListView {
                anchors.fill: parent
                anchors.margins: 10
                model: DataStore.alarms
                spacing: 8
                delegate: Rectangle {
                    width: ListView.view.width
                    height: 74
                    radius: 8
                    color: "#0b1220"
                    border.color: modelData.level === 2 ? "#ef4444" : "#f59e0b"

                    Column {
                        anchors.fill: parent
                        anchors.margins: 8
                        spacing: 4
                        Row {
                            spacing: 8
                            Text { text: modelData.id; color: "#67e8f9"; font.family: "monospace" }
                            Text { text: modelData.component; color: "#e8ecf4"; font.bold: true }
                            Text { text: modelData.type; color: "#e8ecf4" }
                            Text { text: modelData.status; color: modelData.status === "未处理" ? "#ef4444" : "#f59e0b" }
                        }
                        Text { text: modelData.detail; color: "#93a4be"; wrapMode: Text.Wrap }
                    }
                }
            }
        }
    }
}
