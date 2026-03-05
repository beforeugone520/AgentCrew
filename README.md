# OpenClaw 多Agent协同工作流

> 从0到7个AI Agent在Discord里像团队一样协同工作
> 
> [中文](#中文) | [English](#english)

---

## 中文

### 项目简介

本项目记录了如何在 **OpenClaw** 框架下搭建多Agent协同系统，让多个AI角色在同一个Discord频道里像工作群一样协同完成任务。

### 核心特色

- **7个专业Agent**: 总指挥、文案、技术、调研、分析、数据、架构
- **A2A通信**: Agent之间可以互相委派任务
- **上下文共享**: 所有Agent能看到频道完整对话历史
- **实战踩坑**: 记录了完整的踩坑过程和解决方案

### 项目结构

```
.
├── README.md                          # 项目说明
├── MULTI_AGENT_SETUP_GUIDE.md         # 完整配置教程（含踩坑记录）
├── QUICK_START_CHECKLIST.md           # 快速检查清单
├── openclaw-config-template.json      # 配置模板（需填写自己的Token）
├── examples/                          # 示例配置
│   └── agent-persona-template/        # Agent人格模板
├── LICENSE                            # 开源协议
└── .gitignore                         # Git忽略规则
```

### 快速开始

1. **阅读教程**: [MULTI_AGENT_SETUP_GUIDE.md](./MULTI_AGENT_SETUP_GUIDE.md)
2. **使用模板**: [openclaw-config-template.json](./openclaw-config-template.json)
3. **检查清单**: [QUICK_START_CHECKLIST.md](./QUICK_START_CHECKLIST.md)

### 核心配置要点

```json
{
  "tools": {
    "agentToAgent": { "enabled": true },    // 允许Agent间通信
    "sessions": { "visibility": "all" }      // 共享频道上下文 ⭐关键
  },
  "channels": {
    "discord": {
      "allowBots": true,                       // 允许Bot间对话
      "accounts": {
        "default": {
          "guilds": {
            "GUILD_ID": {
              "requireMention": true,          // 必须@才响应（防循环）
              "users": ["..."]                 // 白名单（重要！）
            }
          }
        }
      }
    }
  }
}
```

### Agent角色定义

| Agent | 角色 | Emoji | 核心能力 |
|-------|------|-------|---------|
| Niko | 总指挥 | 🦐 | 任务调度、协调 |
| 文匠 | 文案专家 | 📝 | 写作、文档处理 |
| 极客 | 技术专家 | 🔧 | 编程、调试 |
| 猎手 | 调研专家 | 🔍 | 搜索、信息收集 |
| 苏格拉底 | 分析专家 | 🧠 | 逻辑分析、方案评估 |
| 金手指 | 数据专家 | ✨ | 数据分析、可视化 |
| 造物主 | 架构专家 | 🎨 | 系统设计、搭建 |

### 使用示例

```
达宏: @Niko 启动协作，帮我调研小红书运营策略

Niko: @猎手 请调研小红书运营策略
猎手: 收到！开始调研...
      [返回调研结果]
      @Niko 调研完成！

Niko: @文匠 根据调研写一份运营报告
文匠: 收到！报告如下...
      @Niko 报告已完成！

Niko: @达宏 任务完成！包含调研报告和运营方案。
```

### 隐私保护声明

⚠️ **重要**: 本项目不包含任何真实的API Token或密钥。

- 所有配置文件模板中的敏感信息均为占位符（如 `YOUR_TOKEN_HERE`）
- 请妥善保管你的Discord Bot Token，不要提交到Git仓库
- 建议使用 `.env` 文件管理敏感信息

### 技术栈

- **框架**: [OpenClaw](https://docs.openclaw.ai)
- **通信平台**: Discord
- **AI模型**: Kimi Code (k2.5)
- **模式**: A2A (Agent-to-Agent)

### 贡献

欢迎提交Issue和PR！如果你也踩了新的坑，欢迎补充到教程中。

---

## English

### Introduction

This project documents how to build a multi-Agent collaboration system using the **OpenClaw** framework, where multiple AI agents work together in a Discord channel like a team.

### Key Features

- **7 Specialized Agents**: Coordinator, Writer, Engineer, Researcher, Analyst, Data Expert, Architect
- **A2A Communication**: Agents can delegate tasks to each other
- **Context Sharing**: All agents see the complete channel conversation history
- **Battle-tested**: Includes complete troubleshooting records

### Quick Start

1. Read the guide: [MULTI_AGENT_SETUP_GUIDE.md](./MULTI_AGENT_SETUP_GUIDE.md)
2. Use the template: [openclaw-config-template.json](./openclaw-config-template.json)
3. Check the checklist: [QUICK_START_CHECKLIST.md](./QUICK_START_CHECKLIST.md)

### Privacy Notice

⚠️ This project does not contain any real API tokens or secrets.

All sensitive information in configuration templates are placeholders (e.g., `YOUR_TOKEN_HERE`).
Please keep your Discord Bot Tokens secure and never commit them to Git repositories.

### License

MIT License - see [LICENSE](./LICENSE) file for details.

---

*Created with ❤️ by BeforeUgone (达宏) & Niko*
