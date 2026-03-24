cmake_minimum_required(VERSION 3.21)
project(MechatronicHealthPlatform LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 6.5 REQUIRED COMPONENTS Quick)
qt_standard_project_setup(REQUIRES 6.5)

qt_add_executable(app_mechatronic
    main.cpp
)

qt_add_qml_module(app_mechatronic
    URI MechatronicHealth
    VERSION 1.0
    QML_FILES
        qml/Main.qml
        qml/components/TopHeader.qml
        qml/components/Sidebar.qml
        qml/components/SubSidebar.qml
        qml/components/MetricCard.qml
        qml/components/SectionCard.qml
        qml/pages/HomePage.qml
        qml/pages/MonitorPage.qml
        qml/pages/AssessPage.qml
        qml/pages/AnomalyPage.qml
        qml/pages/DiagnosisPage.qml
        qml/pages/SignalAnalysisPage.qml
        qml/pages/DecisionPage.qml
        qml/pages/MaintenancePage.qml
        qml/pages/LogPage.qml
    RESOURCES
        qml/DataStore.js
)

target_link_libraries(app_mechatronic PRIVATE Qt6::Quick)
