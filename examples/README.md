# 示例配置

本目录包含各种示例配置，帮助你快速上手。

## 目录结构

```
examples/
├── README.md                           # 本文件
├── agent-persona-template/             # Agent人格模板
│   ├── IDENTITY.md                     # 身份定义模板
│   ├── SOUL.md                         # 灵魂原则模板
│   ├── MEMORY.md                       # 工作记忆模板
│   └── AGENTS.md                       # 工作空间指南模板
└── openclaw-config-example.json        # 完整配置示例（脱敏）
```

## 使用说明

### 1. 创建新Agent人格

复制 `agent-persona-template/` 目录，重命名为你的Agent ID：

```bash
cp -r agent-persona-template ../agents/my-agent/
```

然后编辑模板文件，替换所有 `{{PLACEHOLDER}}` 为实际内容。

### 2. 配置文件

参考 `openclaw-config-example.json` 创建你的 `openclaw.json`。

**⚠️ 注意**: 示例文件中的敏感信息已被替换为占位符，如：
- `YOUR_DISCORD_BOT_TOKEN`
- `YOUR_DISCORD_USER_ID`
- `YOUR_GUILD_ID`
- `YOUR_CHANNEL_ID`

请使用你自己的真实值替换这些占位符。

## 模板变量说明

### IDENTITY.md 变量

| 变量 | 说明 | 示例 |
|------|------|------|
| `{{AGENT_NAME}}` | Agent名称 | 文匠 |
| `{{AGENT_TYPE}}` | Agent类型描述 | AI wordsmith |
| `{{AGENT_DESCRIPTION}}` | 类型详细描述 | a digital scribe |
| `{{PERSONALITY_TRAITS}}` | 性格特点 | elegant, thoughtful |
| `{{EMOJI}}` | 代表表情 | 📝 |
| `{{OWNER_NAME}}` | 主人名称 | 达宏 |
| `{{ROLE_DESCRIPTION}}` | 角色描述 | 写作专家 |
| `{{ABILITY_X}}` | 核心能力 | 撰写报告 |

### SOUL.md 变量

| 变量 | 说明 |
|------|------|
| `{{CAPABILITY_PRINCIPLES}}` | 能力相关原则 |

### MEMORY.md 变量

| 变量 | 说明 | 示例 |
|------|------|------|
| `{{TAGS}}` | 标签 | #writing #documentation |
| `{{DATE}}` | 日期 | 2026-03-06 |
| `{{AGENT_ID}}` | Agent ID | wenjiang |
| `{{CATEGORY_X}}` | 技能类别 | 办公文档 |
| `{{SKILL_X}}` | 具体Skill | docx |

### AGENTS.md 变量

| 变量 | 说明 |
|------|------|
| `{{TASK_TYPE_X}}` | 任务类型 |
| `{{YOUR_VALUE}}` | 你能提供的价值 |
| `{{TAGLINE}}` | 标语/口号 |

## 注意事项

1. **不要提交真实Token**: 所有示例文件都已脱敏处理
2. **使用.env文件**: 建议将敏感信息放在 `.env` 文件中
3. **遵循.gitignore**: 确保敏感文件不会被提交到Git

## 更多示例

欢迎贡献更多示例配置！请确保：
- 删除所有真实Token和ID
- 使用清晰的占位符命名
- 添加详细的注释说明
