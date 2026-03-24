.pragma library

var subsystemData = ({
    gen: {
        name: "发电机系统", icon: "⚡", health: 85,
        signals: [
            { name: "发电机电压", id: "Gen_voltage", value: "862 V", status: "normal" },
            { name: "电机绕组温度", id: "GCU_WindingTemp", value: "186 °C", status: "normal" },
            { name: "发电机转矩", id: "Gen_torque", value: "2340 N·m", status: "warning" }
        ],
        subHealth: [
            { name: "电气", value: 92 }, { name: "热管理", value: 88 }, { name: "机械", value: 76 }, { name: "通讯", value: 98 }
        ]
    },
    hydraulic: {
        name: "液压系统", icon: "💧", health: 78,
        signals: [
            { name: "油泵电压", id: "BOilP_Voltage", value: "845 V", status: "normal" },
            { name: "主压力", id: "OilPress_Main", value: "2.1 MPa", status: "warning" }
        ],
        subHealth: [
            { name: "油泵电气", value: 90 }, { name: "压力", value: 68 }, { name: "热管理", value: 85 }, { name: "润滑", value: 82 }
        ]
    },
    clutch: {
        name: "离合器与制动器", icon: "⚙", health: 91,
        signals: [
            { name: "左制动压力", id: "OilPress_LeftBrake", value: "1.2 MPa", status: "normal" },
            { name: "右离合压力", id: "OilPress_RightClutch", value: "1.9 MPa", status: "normal" }
        ],
        subHealth: [
            { name: "制动", value: 95 }, { name: "离合", value: 88 }, { name: "阀控", value: 90 }, { name: "同步", value: 92 }
        ]
    },
    coupling: {
        name: "功率耦合机构", icon: "🔗", health: 88,
        signals: [
            { name: "耦合振动RMS", id: "Coupling_Vib", value: "2.4 g", status: "warning" }
        ],
        subHealth: [
            { name: "振动", value: 82 }, { name: "结构", value: 94 }, { name: "传动", value: 88 }
        ]
    },
    motorL: {
        name: "左驱动电机", icon: "🔴", health: 62,
        signals: [
            { name: "左绕组温度", id: "MCUL_WindingTemp", value: "268 °C", status: "danger" },
            { name: "左MCU温度", id: "MCUL_ModuleTemp", value: "245 °C", status: "warning" },
            { name: "左电机电流", id: "CMot_WireCurrent_L", value: "870 A", status: "warning" }
        ],
        subHealth: [
            { name: "电气", value: 75 }, { name: "热管理", value: 48 }, { name: "机械", value: 70 }, { name: "通讯", value: 95 }
        ]
    },
    motorR: {
        name: "右驱动电机", icon: "🟢", health: 89,
        signals: [
            { name: "右电机电压", id: "AMot_Voltage_R", value: "885 V", status: "normal" },
            { name: "右电机转速", id: "GMot_Spd_R", value: "7580 r/min", status: "normal" }
        ],
        subHealth: [
            { name: "电气", value: 92 }, { name: "热管理", value: 86 }, { name: "机械", value: 88 }, { name: "通讯", value: 98 }
        ]
    }
});

var alarms = [
    { id: "ALM-20260306-001", level: 2, component: "左驱动电机", type: "绕组温度超标", status: "未处理", detail: "MCUL_WindingTemp=268°C>260°C" },
    { id: "ALM-20260307-002", level: 2, component: "发电机", type: "转矩接近过载", status: "未处理", detail: "Gen_torque=2340N·m接近2500" },
    { id: "ALM-20260305-003", level: 1, component: "液压系统", type: "主压力低于标准", status: "处理中", detail: "OilPress_Main=2.1<2.4MPa" }
];

var decisions = [
    { id: "DEC-001", alarmId: "ALM-001", component: "左驱动电机", priority: "高", suggestion: "降载至80%，停机检查", status: "待执行" },
    { id: "DEC-002", alarmId: "ALM-002", component: "发电机", priority: "中", suggestion: "间歇降载，72h内检查", status: "待审批" },
    { id: "DEC-003", alarmId: "ALM-003", component: "液压系统", priority: "中", suggestion: "检查油泵和过滤器", status: "执行中" }
];

var maintenanceOrders = [
    { id: "WO-228", title: "发电机绝缘检测", component: "发电机", owner: "张伟", status: "已完成" },
    { id: "WO-307", title: "液压主压力校准", component: "液压", owner: "李明", status: "进行中" },
    { id: "WO-315", title: "左电机轴承更换", component: "左电机", owner: "待分配", status: "已排期" }
];

function subsystemKeys() {
    return ["gen", "hydraulic", "clutch", "coupling", "motorL", "motorR"];
}

function healthColor(score) {
    if (score >= 85) return "#10b981";
    if (score >= 70) return "#f59e0b";
    return "#ef4444";
}

function statusColor(status) {
    if (status === "normal") return "#10b981";
    if (status === "warning") return "#f59e0b";
    return "#ef4444";
}
