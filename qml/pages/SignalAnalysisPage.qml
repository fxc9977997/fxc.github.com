import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import "../DataStore.js" as DataStore
import "../components"

Item {
    id: root
    property string currentSubsystem: "gen"
    property bool loaded: false
    property string signalType: "振动"

    ColumnLayout {
        anchors.fill: parent
        spacing: 10

        Text { text: DataStore.subsystemData[currentSubsystem].name + " — 信号分析"; color: "#e8ecf4"; font.pixelSize: 16; font.bold: true }

        SectionCard {
            title: "数据加载"
            Layout.fillWidth: true
            Layout.preferredHeight: 84

            Row {
                anchors.fill: parent
                anchors.margins: 10
                spacing: 8

                ComboBox { model: ["振动", "电流"]; onCurrentTextChanged: root.signalType = currentText }
                ComboBox { model: root.signalType === "振动" ? ["X轴", "Y轴", "Z轴"] : ["A相", "B相", "C相"] }
                Button { text: "📂 加载数据"; onClicked: root.loaded = true }
                Text { text: root.loaded ? "✓ 已加载" : "未加载"; color: root.loaded ? "#10b981" : "#93a4be"; anchors.verticalCenter: parent.verticalCenter }
            }
        }

        RowLayout {
            Layout.fillWidth: true
            Layout.fillHeight: true
            spacing: 10

            SectionCard {
                title: "时域波形"
                Layout.fillWidth: true
                Layout.fillHeight: true

                Canvas {
                    anchors.fill: parent
                    anchors.margins: 12
                    onPaint: {
                        const ctx = getContext("2d")
                        ctx.fillStyle = "#0b1220"
                        ctx.fillRect(0, 0, width, height)

                        ctx.strokeStyle = root.signalType === "振动" ? "#06b6d4" : "#3b82f6"
                        ctx.lineWidth = 2
                        ctx.beginPath()
                        for (let x = 0; x < width; x++) {
                            const y = height / 2 + Math.sin(x / 24.0) * 25 + Math.sin(x / 9.0) * 8
                            if (x === 0) ctx.moveTo(x, y)
                            else ctx.lineTo(x, y)
                        }
                        ctx.stroke()
                    }
                    Component.onCompleted: requestPaint()
                }
            }

            SectionCard {
                title: "频谱与指标"
                Layout.preferredWidth: 360
                Layout.fillHeight: true

                Column {
                    anchors.fill: parent
                    anchors.margins: 10
                    spacing: 8

                    Repeater {
                        model: root.signalType === "振动"
                               ? ["峰值: 8.72 m/s²", "RMS: 2.34 m/s²", "峭度: 4.21", "偏度: -0.18"]
                               : ["均值: 285.3 A", "RMS: 302.1 A", "峰值: 724 A", "主频: 50 Hz"]
                        delegate: Rectangle {
                            width: parent.width
                            height: 34
                            radius: 6
                            color: "#0b1220"
                            border.color: "#1e2d4a"
                            Text { anchors.centerIn: parent; text: modelData; color: "#cbd5e1" }
                        }
                    }
                }
            }
        }
    }
}
