import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import MechatronicHealth

ApplicationWindow {
    id: root
    width: 1600
    height: 920
    visible: true
    title: "机电复合传动系统健康管理与故障诊断平台"
    color: "#0a0e1a"

    property string currentPage: "home"
    property string currentSubsystem: "gen"

    TopHeader {
        id: header
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
    }

    RowLayout {
        anchors.top: header.bottom
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        spacing: 0

        Sidebar {
            Layout.preferredWidth: 220
            Layout.fillHeight: true
            currentPage: root.currentPage
            onPageSelected: root.currentPage = pageKey
        }

        SubSidebar {
            Layout.preferredWidth: 220
            Layout.fillHeight: true
            currentSubsystem: root.currentSubsystem
            onSubsystemSelected: root.currentSubsystem = subsystemKey
        }

        Loader {
            id: pageLoader
            Layout.fillWidth: true
            Layout.fillHeight: true
            sourceComponent: {
                switch (root.currentPage) {
                case "home": return homePage
                case "monitor": return monitorPage
                case "assess": return assessPage
                case "anomaly": return anomalyPage
                case "diagnosis": return diagnosisPage
                case "signal": return signalPage
                case "decision": return decisionPage
                case "maintenance": return maintenancePage
                case "log": return logPage
                default: return homePage
                }
            }

            onLoaded: {
                if (item && item.hasOwnProperty("currentSubsystem")) {
                    item.currentSubsystem = root.currentSubsystem
                }
            }
        }
    }

    Component { id: homePage; HomePage { currentSubsystem: root.currentSubsystem } }
    Component { id: monitorPage; MonitorPage { currentSubsystem: root.currentSubsystem } }
    Component { id: assessPage; AssessPage { currentSubsystem: root.currentSubsystem } }
    Component { id: anomalyPage; AnomalyPage {} }
    Component { id: diagnosisPage; DiagnosisPage { currentSubsystem: root.currentSubsystem } }
    Component { id: signalPage; SignalAnalysisPage { currentSubsystem: root.currentSubsystem } }
    Component { id: decisionPage; DecisionPage {} }
    Component { id: maintenancePage; MaintenancePage {} }
    Component { id: logPage; LogPage {} }
}
