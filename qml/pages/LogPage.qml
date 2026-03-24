import QtQuick
import QtQuick.Layouts
import "../components"

Item {
    ListModel {
        id: logModel
        ListElement { time: "14:12:03"; level: "INFO"; msg: "采样任务正常完成" }
        ListElement { time: "14:10:33"; level: "WARN"; msg: "左电机MCU温度接近阈值" }
        ListElement { time: "14:09:11"; level: "ERROR"; msg: "左绕组温度超过安全阈值" }
        ListElement { time: "14:07:01"; level: "INFO"; msg: "故障诊断任务进入队列" }
        ListElement { time: "14:05:47"; level: "INFO"; msg: "液压压力采样正常" }
    }

    ColumnLayout {
        anchors.fill: parent
        spacing: 10

        Text { text: "系统日志"; color: "#e8ecf4"; font.pixelSize: 16; font.bold: true }

        SectionCard {
            title: "日志流"
            Layout.fillWidth: true
            Layout.fillHeight: true

            ListView {
                anchors.fill: parent
                anchors.margins: 10
                model: logModel
                spacing: 6
                delegate: Rectangle {
                    width: ListView.view.width
                    height: 46
                    radius: 6
                    color: "#0b1220"
                    border.color: level === "ERROR" ? "#ef4444" : (level === "WARN" ? "#f59e0b" : "#1e2d4a")

                    Row {
                        anchors.fill: parent
                        anchors.margins: 8
                        spacing: 10
                        Text { text: time; color: "#93a4be"; width: 80; font.family: "monospace" }
                        Text { text: level; color: level === "ERROR" ? "#ef4444" : (level === "WARN" ? "#f59e0b" : "#10b981"); width: 60 }
                        Text { text: msg; color: "#cbd5e1"; elide: Text.ElideRight; width: parent.width - 170 }
                    }
                }
            }
        }
    }
}
