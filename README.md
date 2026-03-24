# Mechatronic Health Platform (QML)

基于 Qt Quick/QML 的工程级原型项目，参考原 HTML 设计实现：

- 装备状态总览
- 状态监测与信号
- 状态评估
- 异常报警
- 故障诊断
- 信号分析
- 辅助决策
- 维修事件管理
- 系统日志

## 构建

> 依赖：Qt 6.5+（Quick 模块）、CMake 3.21+

```bash
cmake -S . -B build
cmake --build build
```

运行：

```bash
./build/app_mechatronic
```

## 项目结构

- `main.cpp`：Qt 应用入口
- `CMakeLists.txt`：工程配置
- `qml/Main.qml`：主界面布局与页面路由
- `qml/components/`：通用组件（顶部栏、侧边栏、卡片等）
- `qml/pages/`：各业务页面
- `qml/DataStore.js`：模拟数据与颜色辅助函数
