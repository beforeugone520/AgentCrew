# OpenClaw 多Agent协同实战完全指南

> 从0到7个AIAgent在Discord里协同工作
> 作者：OpenClaw Team
> 日期：2026-03-06

---

## 📋 目录

1. [项目概述](#项目概述)
2. [最终架构](#最终架构)
3. [踩坑记录（错误示范）](#踩坑记录)
4. [正确配置步骤](#正确配置步骤)
5. [完整配置文件](#完整配置文件)
6. [使用示例](#使用示例)
7. [故障排查](#故障排查)

---

## 项目概述

### 目标
搭建一个基于 OpenClaw 的多Agent协作系统，让多个AI角色在同一个Discord频道里像工作群一样协同完成任务。

### 我们的配置
| Agent | 角色 | 职能 |
|-------|------|------|
| Niko | 总指挥 | 调度协调 |
| 文匠 | 文案专家 | 写作、文档 |
| 极客 | 技术专家 | 编程、调试 |
| 猎手 | 调研专家 | 搜索、信息收集 |
| 苏格拉底 | 分析专家 | 逻辑分析、方案评估 |
| 金手指 | 数据专家 | 数据分析、可视化 |
| 造物主 | 架构专家 | 系统设计、搭建 |

### 技术栈
- **框架**: OpenClaw
- **通信平台**: Discord
- **模型**: Kimi Code (k2.5)
- **模式**: A2A (Agent-to-Agent)

---

## 最终架构

```
┌─────────────────────────────────────────────────────────┐
│                    用户                                   │
└──────────────────────┬──────────────────────────────────┘
                       │
                       ▼
┌─────────────────────────────────────────────────────────┐
│                   Discord 频道                          │
│              （1478296908119146600）                     │
└──────────────────────┬──────────────────────────────────┘
                       │
         ┌─────────────┼─────────────┐
         ▼             ▼             ▼
┌────────────┐ ┌────────────┐ ┌────────────┐
│    Niko    │ │   文匠      │ │   极客     │
│  (总指挥)   │ │  (文案)     │ │  (编程)     │
└────────────┘ └────────────┘ └────────────┘
       │
       ├─── 委派任务 ───► 各专业Agent
       │
       └─── 汇总结果 ───► 返回给用户
```

---

## 踩坑记录

### ❌ 坑1: requireMention 位置错误

**错误配置：**
```json
"channels": {
  "1478296908119146600": { 
    "allow": true, 
    "requireMention": true   // ❌ 错在这里！
  }
}
```

**问题现象：**
- Bot不响应任何消息
- 日志显示配置无效

**正确配置：**
```json
"guilds": {
  "1478296908119146597": {
    "requireMention": true,   // ✅ 应该在guilds层级
    "channels": {
      "1478296908119146600": { "allow": true }
    }
  }
}
```

---

### ❌ 坑2: 无限循环

**错误配置：**
```json
"1478296908119146600": { "allow": true, "requireMention": false }
```

**问题现象：**
- 两个Bot在群里无限@对方
- 消息疯狂刷屏
- 直到Token耗尽

**原因：**
`requireMention: false` 意味着Bot会回复频道里的**所有消息**，包括另一个Bot的回复。

**解决方案：**
```json
"requireMention": true   // 只有被@时才回复
```

---

### ❌ 坑3: 缺少 visibility: all

**错误配置：**
没有这个配置！

**问题现象：**
- Niko @文匠派任务
- 文匠响应"收到！"
- 然后...没有然后了
- 文匠不执行任务，只说"进行中"

**原因：**
文匠看不到Niko发的任务内容，只能看到自己被@了。

**正确配置：**
```json
"tools": {
  "sessions": {
    "visibility": "all"   // ✅ 所有Agent都能看到频道全部消息
  }
}
```

---

### ❌ 坑4: 缺少 agentToAgent 权限

**错误配置：**
没有这个配置！

**问题现象：**
- Niko尝试派任务给文匠
- 系统报错或无视
- Agent之间无法通信

**正确配置：**
```json
"tools": {
  "agentToAgent": {
    "enabled": true,
    "allow": ["main", "wenjiang", "geek", "hunter", "socrates", "golden", "creator"]
  }
}
```

---

### ❌ 坑5: users白名单缺少自己的ID

**错误配置：**
```json
"users": [
  "1478385935757480089",   // Niko
  "1478988385808023583"    // 文匠
]
```

**问题现象：**
- 用户@Bot
- Bot完全不理人
- 像死了一样

**原因：**
Bot只响应白名单里的用户。如果白名单只有Bot自己的ID，人类用户就被当成"陌生人"过滤掉了。

**正确配置：**
```json
"users": [
  "YOUR_USER_ID_HERE",        // ✅ 你自己（用户ID）
  "1478385935757480089",       // Niko
  "1478988385808023583",       // 文匠
  "14789990211655663637",      // 极客
  "1479003552843300935",       // 猎手
  "1479003893349482496",       // 苏格拉底
  "1479004334187610305",       // 金手指
  "1479004620159193118"        // 造物主
]
```

**获取Discord User ID的方法：**
1. Discord设置 → 高级 → 开启开发者模式
2. 右键点击自己的头像
3. 选择"复制用户ID"

---

### ❌ 坑6: 配置不存在的字段

**错误配置：**
```json
{
  "id": "wenjiang",
  "workspace": "...",
  "runtime": "subagent",      // ❌ 不存在！
  "triggers": {               // ❌ 不存在！
    "discord": { "mode": "mention" }
  }
}
```

**问题现象：**
- 启动报错：`agents.list.1: Unrecognized keys: "runtime", "triggers"`

**教训：**
OpenClaw的`agents.list`只支持`id`和`workspace`两个字段，不要自己发明配置。

---

## 正确配置步骤

### Step 1: 准备工作

**需要的材料：**
- OpenClaw已安装
- 每个Agent一个Discord Bot Token
- 每个Bot的Discord User ID
- 你的Discord User ID
- 服务器ID (Guild ID)
- 频道ID (Channel ID)

**获取Discord ID的方法：**
```
Discord设置 → 高级 → 开启开发者模式
右键目标 → 复制ID
```

---

### Step 2: 创建Agent目录结构

```bash
# 创建Agent目录
mkdir -p agents/{wenjiang,geek,hunter,socrates,golden,creator}/{agent,sessions}
mkdir -p workspace/agents/{wenjiang,geek,hunter,socrates,golden,creator}

# 每个Agent需要：
# agents/{id}/agent/auth-profiles.json    # API认证
# agents/{id}/agent/models.json           # 模型配置
# workspace/agents/{id}/IDENTITY.md       # 身份定义
# workspace/agents/{id}/SOUL.md           # 核心原则
# workspace/agents/{id}/USER.md           # 用户画像
# workspace/agents/{id}/MEMORY.md         # 工作记忆
# workspace/agents/{id}/AGENTS.md         # 工作指南
```

---

### Step 3: 配置 openclaw.json

**核心配置结构：**

```json
{
  "agents": {
    "list": [
      { "id": "main" },
      { "id": "wenjiang", "workspace": "~/.openclaw/workspace/agents/wenjiang" },
      { "id": "geek", "workspace": "~/.openclaw/workspace/agents/geek" }
      // ... 其他Agent
    ]
  },
  
  "bindings": [
    { "agentId": "main", "match": { "channel": "discord", "accountId": "default" } },
    { "agentId": "wenjiang", "match": { "channel": "discord", "accountId": "wenjiang" } }
    // ... 每个Agent的绑定
  ],
  
  "tools": {
    "agentToAgent": {
      "enabled": true,
      "allow": ["main", "wenjiang", "geek", "hunter", "socrates", "golden", "creator"]
    },
    "sessions": {
      "visibility": "all"
    }
  },
  
  "channels": {
    "discord": {
      "enabled": true,
      "groupPolicy": "allowlist",
      "allowBots": true,
      "accounts": {
        "default": {
          "token": "YOUR_NIKO_BOT_TOKEN",
          "guilds": {
            "YOUR_GUILD_ID": {
              "requireMention": true,
              "users": ["YOUR_ID", "NIKO_ID", "WENJIANG_ID", ...],
              "channels": {
                "YOUR_CHANNEL_ID": { "allow": true }
              }
            }
          }
        },
        "wenjiang": {
          "token": "YOUR_WENJIANG_BOT_TOKEN",
          "guilds": { ...同样的配置... }
        }
        // ... 每个Bot的账户配置
      }
    }
  }
}
```

---

### Step 4: 配置人格文件

**SOUL.md 关键内容（任务执行协议）：**

```markdown
## CRITICAL: Task Execution Protocol ⭐

When you receive a task from Niko or the user in Discord:

1. **ACKNOWLEDGE IMMEDIATELY** — Respond with "收到！"
2. **CLARIFY IF NEEDED** — Ask questions if unclear
3. **EXECUTE RIGHT AWAY** — Start working immediately
4. **PROVIDE RESULTS** — Return actual deliverables
5. **ALWAYS @MENTION** — Reply must @mention the task assigner

**DO NOT:**
- ❌ Just say "正在处理" and stop
- ❌ Wait for further prompting to start working

**DO:**
- ✅ Start working immediately after acknowledgment
- ✅ Use appropriate skills
- ✅ Report completion with actual results
```

---

### Step 5: 启动服务

```bash
# 停止旧服务
pkill -f openclaw

# 启动Gateway
openclaw gateway

# 验证配置
openclaw config validate
```

---

## 完整配置文件

见本目录下的 `openclaw-reference.json`

---

## 使用示例

### 示例1: 简单委派
```
用户: @Niko 让文匠写一份周报

Niko: @文匠 请写一份周报，要求...

文匠: 收到！开始撰写...
      [内容]
      @Niko 周报已完成！
```

### 示例2: 协作模式
```
用户: @Niko 帮我分析这个月的小红书数据

Niko: @金手指 请分析小红书数据

金手指: 收到！分析完成...
        [图表]
        @Niko 数据分析完成！

Niko: @文匠 根据数据写一份运营报告

文匠: 收到！报告如下...
      @Niko 报告已完成！

Niko: @用户 任务完成！包含数据分析和运营报告。
```

---

## 故障排查

### Bot不理人
1. 检查 `users` 白名单是否包含你的Discord ID
2. 检查 `requireMention` 是否为 `true`
3. 检查 Bot Token 是否正确
4. 检查频道ID是否正确

### Bot能响应但不执行任务
1. 检查是否配置 `visibility: all`
2. 检查是否配置 `agentToAgent.enabled: true`
3. 检查人格文件中的Task Execution Protocol

### Bot无限循环
检查 `requireMention` 是否为 `false`，应该设为 `true`

### 配置报错
1. 检查JSON格式是否正确
2. 检查是否有不认识的配置键
3. 使用 `openclaw config validate` 验证

---

## 最佳实践

1. **白名单管理**：把所有Agent和用户的ID都加入白名单
2. **requireMention**: 始终设为 `true` 避免意外触发
3. **visibility**: 必须设为 `all` 让Agent看到完整上下文
4. **agentToAgent**: 开启并列出所有Agent ID
5. **人格文件**：在SOUL.md中明确定义任务执行协议

---

## 总结

经过这次配置，我们搭建了一个7Agent协同系统。关键是理解：

1. **权限管理**：谁可以指挥谁（users白名单）
2. **通信机制**：Agent如何看到彼此的消息（visibility）
3. **触发控制**：什么时候响应（requireMention）
4. **人格定义**：每个Agent应该做什么（人格文件）

希望这篇指南能帮助你避开我们踩过的坑！

---

*文档版本: 1.0*
*最后更新: 2026-03-06*
