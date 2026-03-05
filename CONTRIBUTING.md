# 贡献指南

感谢你对 OpenClaw 多Agent协同项目的兴趣！我们欢迎各种形式的贡献。

## 如何贡献

### 报告问题

如果你发现了bug或有改进建议：

1. 先搜索现有Issues，避免重复
2. 创建新Issue，描述：
   - 问题现象
   - 复现步骤
   - 预期行为
   - 实际行为
   - 环境信息（OpenClaw版本、操作系统等）

### 提交代码

1. **Fork** 本仓库
2. **Clone** 你的Fork：`git clone https://github.com/YOUR_USERNAME/openclaw-multi-agent.git`
3. **创建分支**：`git checkout -b feature/your-feature-name`
4. **提交更改**：`git commit -m "描述你的更改"`
5. **推送分支**：`git push origin feature/your-feature-name`
6. **创建 Pull Request**

### 贡献内容

我们特别欢迎以下贡献：

- **新的踩坑记录**：如果你遇到了新的问题并解决，请补充到教程中
- **新的Agent人格**：分享你的Agent配置
- **改进文档**：修正错误、补充说明、翻译
- **示例配置**：添加更多使用场景的配置示例
- **脚本工具**：自动化部署、监控等工具

## 代码规范

### 配置文件

- 使用清晰的JSON格式，带缩进
- 添加注释说明关键配置项
- 所有敏感信息使用占位符（如 `YOUR_TOKEN_HERE`）
- 不要在示例中包含真实Token

### 文档

- 使用Markdown格式
- 中英文之间加空格
- 代码块标明语言类型
- 添加适当的标题层级

### 提交信息

使用清晰的提交信息：

```
类型: 简短描述

详细说明（如果需要）
```

类型包括：
- `feat`: 新功能
- `fix`: 修复bug
- `docs`: 文档更新
- `style`: 格式调整（不影响功能）
- `refactor`: 代码重构
- `test`: 测试相关
- `chore`: 构建过程或辅助工具的变动

示例：
```
fix: 修复 requireMention 配置位置的说明

tutorials/MULTI_AGENT_SETUP_GUIDE.md 中的配置示例
错误地将 requireMention 放在了 channels 层级，
实际上应该在 guilds 层级。
```

## 隐私保护

⚠️ **非常重要**：

- **永远不要**提交包含真实Token、API Key、密码的文件
- **永远不要**提交你的 `.env` 文件
- **永远不要**提交你的 `openclaw.json`（如果包含真实Token）
- 使用 `.env.example` 作为模板，让用户自己填入

## 审查流程

1. 维护者会审查你的PR
2. 可能需要根据反馈进行修改
3. 通过审查后会被合并

## 行为准则

- 保持友善和尊重
- 接受建设性的批评
- 关注对社区最有利的事情
- 展示同理心

## 提问

有任何问题？

- 开Issue提问
- 在现有Issue中参与讨论

感谢你的贡献！🎉
