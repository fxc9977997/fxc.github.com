import QtQuick
import QtQuick.Controls

Rectangle {
    id: root
    property string currentPage: "home"
    signal pageSelected(string pageKey)

    color: "#111827"
    border.color: "#1e2d4a"

    ListModel {
        id: menuModel
        ListElement { key: "home"; icon: "🏠"; label: "装备状态总览" }
        ListElement { key: "monitor"; icon: "🔍"; label: "状态监测与信号" }
        ListElement { key: "assess"; icon: "📊"; label: "状态评估" }
        ListElement { key: "anomaly"; icon: "⚡"; label: "异常报警" }
        ListElement { key: "diagnosis"; icon: "🧠"; label: "故障诊断" }
        ListElement { key: "signal"; icon: "〰"; label: "信号分析" }
        ListElement { key: "decision"; icon: "💡"; label: "辅助决策" }
        ListElement { key: "maintenance"; icon: "🔧"; label: "维修事件管理" }
        ListElement { key: "log"; icon: "📝"; label: "系统日志" }
    }

    Column {
        anchors.fill: parent
        anchors.margins: 8
        spacing: 4

        Text { text: "功能模块"; color: "#4a5568"; font.bold: true; font.pixelSize: 10 }

        Repeater {
            model: menuModel
            delegate: Rectangle {
                width: parent.width
                height: 32
                radius: 6
                color: root.currentPage === key ? "#1e3a8a" : "transparent"
                border.color: root.currentPage === key ? "#3b82f6" : "transparent"

                Row {
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.left
                    anchors.leftMargin: 8
                    spacing: 6
                    Text { text: icon; color: root.currentPage === key ? "#60a5fa" : "#93a4be" }
                    Text { text: label; color: root.currentPage === key ? "#60a5fa" : "#93a4be"; font.pixelSize: 12 }
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: root.pageSelected(key)
                }
            }
        }
    }
}
