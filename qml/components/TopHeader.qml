import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Rectangle {
    id: root
    property string title: "机电复合传动系统健康管理与故障诊断平台"

    color: "#111f3a"
    height: 52
    border.color: "#1e2d4a"

    RowLayout {
        anchors.fill: parent
        anchors.margins: 12
        spacing: 12

        Rectangle {
            width: 28; height: 28; radius: 6
            color: "#3b82f6"
            Text { anchors.centerIn: parent; text: "H"; color: "white"; font.bold: true }
        }

        Text {
            text: root.title
            color: "#e8ecf4"
            font.pixelSize: 14
            font.bold: true
        }

        Item { Layout.fillWidth: true }

        Rectangle {
            color: "#0f172a"; radius: 12; border.color: "#1e2d4a"
            height: 24; width: 88
            Text { anchors.centerIn: parent; text: "● 在线"; color: "#10b981"; font.pixelSize: 11 }
        }

        Text {
            id: clockText
            color: "#93a4be"
            font.family: "monospace"
            font.pixelSize: 12
        }

        Timer {
            running: true; repeat: true; interval: 1000
            onTriggered: {
                var now = new Date()
                function p(v) { return (v < 10 ? "0" + v : "" + v) }
                clockText.text = now.getFullYear() + "-" + p(now.getMonth() + 1) + "-" + p(now.getDate()) +
                                 " " + p(now.getHours()) + ":" + p(now.getMinutes()) + ":" + p(now.getSeconds())
            }
            Component.onCompleted: triggered()
        }
    }
}
