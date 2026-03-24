import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import "../DataStore.js" as DataStore
import "../components"

Item {
    id: root
    property string currentSubsystem: "gen"
    property bool preprocessed: false
    property bool diagnosed: false

    ColumnLayout {
        anchors.fill: parent
        spacing: 10

        Text { text: DataStore.subsystemData[currentSubsystem].name + " — 智能故障诊断"; color: "#e8ecf4"; font.pixelSize: 16; font.bold: true }

        SectionCard {
            title: "诊断流程"
            Layout.fillWidth: true
            Layout.preferredHeight: 88

            Row {
                anchors.centerIn: parent
                spacing: 8
                Repeater {
                    model: ["①算法选择","②数据选择","③异常剔除","④预处理","⑤推理","⑥结果"]
                    delegate: Rectangle {
                        width: 90; height: 30; radius: 6
                        color: index < 3 || (index === 3 && root.preprocessed) || (index >= 4 && root.diagnosed) ? "#14532d" : "#1f2937"
                        border.color: "#1e2d4a"
                        Text { anchors.centerIn: parent; text: modelData; color: "#e8ecf4"; font.pixelSize: 10 }
                    }
                }
            }
        }

        RowLayout {
            Layout.fillWidth: true
            Layout.fillHeight: true
            spacing: 10

            SectionCard {
                title: "配置与执行"
                Layout.preferredWidth: 300
                Layout.fillHeight: true

                Column {
                    anchors.fill: parent
                    anchors.margins: 10
                    spacing: 10

                    ComboBox {
                        model: ["IFMAML 少样本诊断", "MCITL 多通道迁移学习", "电机匝间短路判别算法"]
                        width: parent.width
                    }

                    Button {
                        text: "▶ 运行预处理"
                        onClicked: { root.preprocessed = true; root.diagnosed = false }
                        width: parent.width
                    }

                    Button {
                        text: "🧠 开始故障诊断"
                        enabled: root.preprocessed
                        onClicked: root.diagnosed = true
                        width: parent.width
                    }

                    Text { text: root.preprocessed ? "✓ 预处理完成" : "请先运行预处理"; color: root.preprocessed ? "#10b981" : "#93a4be" }
                }
            }

            SectionCard {
                title: "诊断结果"
                Layout.fillWidth: true
                Layout.fillHeight: true

                Column {
                    anchors.fill: parent
                    anchors.margins: 14
                    spacing: 10

                    Text {
                        text: root.diagnosed ? "预测类别：轴承内圈故障（置信度 87.3%）" : "等待执行诊断"
                        color: root.diagnosed ? "#f59e0b" : "#93a4be"
                        font.pixelSize: 15
                        font.bold: true
                    }

                    Text {
                        text: root.diagnosed
                              ? "结论：检测到机械传动子系统存在内圈缺陷特征，建议安排检修更换。"
                              : "完成预处理后点击“开始故障诊断”运行推理。"
                        color: "#cbd5e1"
                        wrapMode: Text.Wrap
                    }
                }
            }
        }
    }
}
