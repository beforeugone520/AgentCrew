# 多Agent配置快速检查清单

## ✅ 配置前准备

- [ ] 已安装 OpenClaw
- [ ] 已获取所有 Bot 的 Discord Token
- [ ] 已获取所有 Bot 的 Discord User ID
- [ ] 已获取你的 Discord User ID
- [ ] 已获取服务器 ID (Guild ID)
- [ ] 已获取频道 ID (Channel ID)

---

## ✅ 配置文件检查

### 1. agents.list
```json
"list": [
  { "id": "main" },
  { "id": "wenjiang", "workspace": "..." }
  // ...
]
```
- [ ] 每个Agent都有唯一的ID
- [ ] workspace路径正确
- [ ] **不要**加 runtime 或 triggers（不存在！）

### 2. bindings
```json
"bindings": [
  { "agentId": "main", "match": { "channel": "discord", "accountId": "default" } },
  { "agentId": "wenjiang", "match": { "channel": "discord", "accountId": "wenjiang" } }
]
```
- [ ] 每个Agent都有对应的binding
- [ ] accountId 和 channels.discord.accounts 的键名一致

### 3. tools.agentToAgent
```json
"agentToAgent": {
  "enabled": true,
  "allow": ["main", "wenjiang", ...]
}
```
- [ ] enabled: true
- [ ] allow列表包含所有Agent ID

### 4. tools.sessions
```json
"sessions": {
  "visibility": "all"
}
```
- [ ] visibility: "all" ⭐ 关键！

### 5. channels.discord
```json
"discord": {
  "enabled": true,
  "allowBots": true,
  "accounts": {
    "default": {
      "token": "...",
      "guilds": {
        "GUILD_ID": {
          "requireMention": true,     // ✅ 在guilds层级！
          "users": ["...", "..."],    // ✅ 包含所有ID！
          "channels": {
            "CHANNEL_ID": { "allow": true }
          }
        }
      }
    }
  }
}
```
- [ ] allowBots: true
- [ ] requireMention 在 **guilds** 层级，不是在channels
- [ ] users 白名单包含：你 + 所有Bot
- [ ] 每个Bot账户都有独立token

---

## ✅ 人格文件检查

每个Agent的 `workspace/agents/{id}/SOUL.md` 必须包含：

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

## ✅ 启动检查

```bash
# 1. 验证配置
openclaw config validate

# 2. 重启服务
pkill -f openclaw
openclaw gateway

# 3. 检查日志
openclaw logs
```

---

## ✅ 功能测试

### 测试1: 基础响应
```
你: @Niko 你好
预期: Niko响应你
```

### 测试2: 跨Agent委派
```
你: @Niko 让文匠写一份周报
预期: 
  - Niko响应：收到，派文匠执行
  - 文匠响应：收到，开始执行
  - 文匠返回结果
```

### 测试3: 上下文感知
```
你: @Niko 分析下这个
Niko: @金手指 请分析数据
金手指: [返回分析]
Niko: @文匠 根据分析写报告
文匠: [能看到金手指的分析结果]
```

---

## ❌ 常见问题排查

| 问题 | 可能原因 | 解决方案 |
|------|---------|---------|
| Bot不理人 | users白名单缺少你的ID | 把你的Discord ID加入白名单 |
| Bot无限@ | requireMention为false | 设为true |
| Bot说"进行中"没结果 | 缺少visibility: all | 添加tools.sessions.visibility |
| Agent间无法委派 | 缺少agentToAgent | 启用并配置allow列表 |
| 配置报错 | 有非法字段 | 检查是否有runtime/triggers等 |

---

## 📚 相关文件

- `MULTI_AGENT_SETUP_GUIDE.md` - 完整教程
- `openclaw-config-template.json` - 配置模板
- `QUICK_START_CHECKLIST.md` - 本文件

---

祝你配置顺利！🎉
