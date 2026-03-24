import QtQuick
import QtQuick.Layouts
import "../DataStore.js" as DataStore
import "../components"

Item {
    id: root
    property string currentSubsystem: "gen"

    ColumnLayout {
        anchors.fill: parent
        spacing: 10

        RowLayout {
            Layout.fillWidth: true
            spacing: 8

            MetricCard { Layout.fillWidth: true; Layout.preferredHeight: 96; title: "健康指数"; value: "82"; accent: "#10b981" }
            MetricCard { Layout.fillWidth: true; Layout.preferredHeight: 96; title: "传感器在线"; value: "42/42"; accent: "#06b6d4" }
            MetricCard { Layout.fillWidth: true; Layout.preferredHeight: 96; title: "故障"; value: "2"; accent: "#ef4444"; suffix: "待处理" }
            MetricCard { Layout.fillWidth: true; Layout.preferredHeight: 96; title: "警告"; value: "5"; accent: "#f59e0b" }
        }

        RowLayout {
            Layout.fillWidth: true
            Layout.fillHeight: true
            spacing: 10

            SectionCard {
                title: "系统拓扑与分系统健康"
                Layout.fillWidth: true
                Layout.fillHeight: true

                Column {
                    anchors.fill: parent
                    anchors.margins: 12
                    spacing: 8

                    Text {
                        text: "发电机 → 功率耦合 → 左/右驱动电机；液压系统与离合制动并联支撑"
                        color: "#93a4be"
                        wrapMode: Text.Wrap
                    }

                    Repeater {
                        model: DataStore.subsystemKeys().length
                        delegate: Rectangle {
                            property string key: DataStore.subsystemKeys()[index]
                            property var subsystem: DataStore.subsystemData[key]
                            width: parent.width
                            height: 30
                            color: "#0b1220"
                            radius: 6
                            border.color: "#1e2d4a"

                            Row {
                                anchors.fill: parent
                                anchors.margins: 6
                                spacing: 6
                                Text { text: subsystem.icon }
                                Text { text: subsystem.name; color: "#e8ecf4"; width: 120; elide: Text.ElideRight }
                                Rectangle {
                                    width: parent.width - 200
                                    height: 8
                                    radius: 4
                                    color: "#1f2937"
                                    anchors.verticalCenter: parent.verticalCenter
                                    Rectangle {
                                        width: parent.width * (subsystem.health / 100.0)
                                        height: parent.height
                                        radius: 4
                                        color: DataStore.healthColor(subsystem.health)
                                    }
                                }
                                Text { text: subsystem.health; color: DataStore.healthColor(subsystem.health) }
                            }
                        }
                    }
                }
            }

            SectionCard {
                title: "异常列表"
                Layout.preferredWidth: 320
                Layout.fillHeight: true

                ListView {
                    anchors.fill: parent
                    anchors.margins: 10
                    model: DataStore.alarms
                    clip: true
                    spacing: 6
                    delegate: Rectangle {
                        width: ListView.view.width
                        height: 62
                        radius: 6
                        color: "#0b1220"
                        border.color: modelData.level === 2 ? "#ef4444" : "#f59e0b"

                        Column {
                            anchors.fill: parent
                            anchors.margins: 8
                            spacing: 4
                            Text { text: modelData.component + " - " + modelData.type; color: "#e8ecf4"; font.bold: true }
                            Text { text: modelData.detail; color: "#93a4be"; font.pixelSize: 11 }
                        }
                    }
                }
            }
        }
    }
}
