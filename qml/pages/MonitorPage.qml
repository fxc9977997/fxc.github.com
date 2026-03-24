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

        Text {
            text: subsystem.name + " — 状态监测与信号"
            color: "#e8ecf4"
            font.pixelSize: 16
            font.bold: true
        }

        SectionCard {
            title: "CAN总线信号"
            Layout.fillWidth: true
            Layout.preferredHeight: 240

            ListView {
                anchors.fill: parent
                anchors.margins: 10
                model: subsystem.signals
                spacing: 6
                clip: true

                delegate: Rectangle {
                    width: ListView.view.width
                    height: 50
                    radius: 6
                    color: "#0b1220"
                    border.color: "#1e2d4a"

                    Row {
                        anchors.fill: parent
                        anchors.margins: 8
                        spacing: 8

                        Text { text: modelData.name; color: "#e8ecf4"; width: 180; elide: Text.ElideRight }
                        Text { text: modelData.id; color: "#67e8f9"; width: 140; elide: Text.ElideRight; font.family: "monospace" }
                        Text { text: modelData.value; color: DataStore.statusColor(modelData.status); font.bold: true }
                        Rectangle {
                            width: 64
                            height: 22
                            radius: 11
                            color: Qt.rgba(0, 0, 0, 0)
                            border.color: DataStore.statusColor(modelData.status)
                            Text {
                                anchors.centerIn: parent
                                text: modelData.status === "normal" ? "正常" : (modelData.status === "warning" ? "预警" : "告警")
                                color: DataStore.statusColor(modelData.status)
                                font.pixelSize: 11
                            }
                        }
                    }
                }
            }
        }

        RowLayout {
            Layout.fillWidth: true
            Layout.fillHeight: true
            spacing: 10

            SectionCard {
                title: "分项健康"
                Layout.fillWidth: true
                Layout.fillHeight: true

                Column {
                    anchors.fill: parent
                    anchors.margins: 10
                    spacing: 8
                    Repeater {
                        model: subsystem.subHealth
                        delegate: Rectangle {
                            width: parent.width
                            height: 34
                            radius: 6
                            color: "#0b1220"
                            border.color: "#1e2d4a"
                            Row {
                                anchors.fill: parent
                                anchors.margins: 8
                                spacing: 8
                                Text { text: modelData.name; color: "#93a4be"; width: 70 }
                                Rectangle {
                                    width: parent.width - 130
                                    height: 8
                                    radius: 4
                                    color: "#1f2937"
                                    anchors.verticalCenter: parent.verticalCenter
                                    Rectangle {
                                        width: parent.width * (modelData.value / 100.0)
                                        height: parent.height
                                        radius: 4
                                        color: DataStore.healthColor(modelData.value)
                                    }
                                }
                                Text { text: modelData.value; color: DataStore.healthColor(modelData.value) }
                            }
                        }
                    }
                }
            }

            SectionCard {
                title: "健康总分"
                Layout.preferredWidth: 260
                Layout.fillHeight: true

                Column {
                    anchors.centerIn: parent
                    spacing: 10
                    Text {
                        text: subsystem.health
                        color: DataStore.healthColor(subsystem.health)
                        font.pixelSize: 48
                        font.bold: true
                        horizontalAlignment: Text.AlignHCenter
                    }
                    Text {
                        text: "当前子系统: " + subsystem.name
                        color: "#93a4be"
                    }
                }
            }
        }
    }
}
