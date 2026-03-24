import QtQuick
import QtQuick.Layouts
import "../DataStore.js" as DataStore
import "../components"

Item {
    ColumnLayout {
        anchors.fill: parent
        spacing: 10

        Text { text: "维修事件管理"; color: "#e8ecf4"; font.pixelSize: 16; font.bold: true }

        RowLayout {
            Layout.fillWidth: true
            MetricCard { Layout.fillWidth: true; Layout.preferredHeight: 88; title: "已完成"; value: "1"; accent: "#10b981" }
            MetricCard { Layout.fillWidth: true; Layout.preferredHeight: 88; title: "进行中"; value: "1"; accent: "#f59e0b" }
            MetricCard { Layout.fillWidth: true; Layout.preferredHeight: 88; title: "已排期"; value: "1"; accent: "#3b82f6" }
        }

        SectionCard {
            title: "工单列表"
            Layout.fillWidth: true
            Layout.fillHeight: true

            ListView {
                anchors.fill: parent
                anchors.margins: 10
                model: DataStore.maintenanceOrders
                spacing: 6
                delegate: Rectangle {
                    width: ListView.view.width
                    height: 62
                    radius: 8
                    color: "#0b1220"
                    border.color: "#1e2d4a"

                    Row {
                        anchors.fill: parent
                        anchors.margins: 8
                        spacing: 12
                        Text { text: modelData.id; color: "#67e8f9"; width: 80 }
                        Text { text: modelData.title; color: "#e8ecf4"; width: 220; elide: Text.ElideRight }
                        Text { text: modelData.component; color: "#93a4be"; width: 80 }
                        Text { text: modelData.owner; color: "#93a4be"; width: 80 }
                        Text { text: modelData.status; color: modelData.status === "已完成" ? "#10b981" : (modelData.status === "进行中" ? "#f59e0b" : "#60a5fa") }
                    }
                }
            }
        }
    }
}
