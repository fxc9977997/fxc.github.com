import QtQuick
import QtQuick.Layouts
import "../DataStore.js" as DataStore
import "../components"

Item {
    id: root
    property string currentSubsystem: "gen"
    property var subsystem: DataStore.subsystemData[currentSubsystem]

    ColumnLayout {
        anchors.fill: parent
        spacing: 10

        Text { text: subsystem.name + " — 状态评估"; color: "#e8ecf4"; font.pixelSize: 16; font.bold: true }

        RowLayout {
            Layout.fillWidth: true
            spacing: 10

            MetricCard { Layout.fillWidth: true; Layout.preferredHeight: 96; title: "健康评分"; value: subsystem.health; accent: DataStore.healthColor(subsystem.health) }
            MetricCard { Layout.fillWidth: true; Layout.preferredHeight: 96; title: "评估结论"; value: subsystem.health >= 85 ? "正常" : (subsystem.health >= 70 ? "一般异常" : "严重异常"); accent: DataStore.healthColor(subsystem.health) }
        }

        SectionCard {
            title: "规则判定结果"
            Layout.fillWidth: true
            Layout.fillHeight: true

            ListView {
                anchors.fill: parent
                anchors.margins: 10
                model: subsystem.signals
                spacing: 6
                delegate: Rectangle {
                    width: ListView.view.width
                    height: 48
                    radius: 6
                    color: "#0b1220"
                    border.color: "#1e2d4a"
                    Row {
                        anchors.fill: parent
                        anchors.margins: 8
                        spacing: 10
                        Text { text: modelData.name; color: "#e8ecf4"; width: 220; elide: Text.ElideRight }
                        Text { text: modelData.id; color: "#67e8f9"; width: 130; font.family: "monospace"; elide: Text.ElideRight }
                        Text { text: modelData.value; color: DataStore.statusColor(modelData.status); width: 90 }
                        Text { text: modelData.status === "normal" ? "正常" : (modelData.status === "warning" ? "预警" : "告警"); color: DataStore.statusColor(modelData.status); font.bold: true }
                    }
                }
            }
        }
    }
}
