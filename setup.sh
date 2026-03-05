#!/bin/bash

# OpenClaw 多Agent协同系统 - 一键部署脚本
# 使用方法: ./setup.sh

set -e

echo "========================================"
echo "OpenClaw 多Agent协同系统 - 部署脚本"
echo "========================================"
echo ""

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# 检查OpenClaw是否安装
check_openclaw() {
    echo "🔍 检查 OpenClaw 安装..."
    if ! command -v openclaw &> /dev/null; then
        echo -e "${RED}❌ OpenClaw 未安装${NC}"
        echo "请先安装 OpenClaw: https://docs.openclaw.ai"
        exit 1
    fi
    echo -e "${GREEN}✅ OpenClaw 已安装${NC}"
}

# 检查.env文件
check_env() {
    echo ""
    echo "🔍 检查环境变量..."
    if [ ! -f ".env" ]; then
        echo -e "${YELLOW}⚠️  未找到 .env 文件${NC}"
        echo "请复制 .env.example 为 .env 并填入你的配置:"
        echo "  cp .env.example .env"
        echo "  nano .env  # 编辑配置"
        exit 1
    fi
    
    # 加载.env
    export $(grep -v '^#' .env | xargs)
    
    # 检查关键变量
    if [ -z "$NIKO_BOT_TOKEN" ] || [ "$NIKO_BOT_TOKEN" = "your_niko_bot_token_here" ]; then
        echo -e "${RED}❌ 请在 .env 文件中填入真实的 Discord Bot Token${NC}"
        exit 1
    fi
    
    echo -e "${GREEN}✅ 环境变量检查通过${NC}"
}

# 创建目录结构
create_directories() {
    echo ""
    echo "📁 创建目录结构..."
    
    AGENTS=("wenjiang" "geek" "hunter" "socrates" "golden" "creator")
    
    for agent in "${AGENTS[@]}"; do
        mkdir -p "agents/$agent/agent"
        mkdir -p "agents/$agent/sessions"
        mkdir -p "workspace/agents/$agent"
        echo "  ✅ 创建 $agent 目录"
    done
    
    echo -e "${GREEN}✅ 目录结构创建完成${NC}"
}

# 复制人格模板
copy_persona_templates() {
    echo ""
    echo "📋 复制人格模板..."
    
    AGENTS=("wenjiang" "geek" "hunter" "socrates" "golden" "creator")
    
    for agent in "${AGENTS[@]}"; do
        if [ ! -f "workspace/agents/$agent/IDENTITY.md" ]; then
            cp "examples/agent-persona-template/IDENTITY.md" "workspace/agents/$agent/"
            cp "examples/agent-persona-template/SOUL.md" "workspace/agents/$agent/"
            cp "examples/agent-persona-template/MEMORY.md" "workspace/agents/$agent/"
            cp "examples/agent-persona-template/AGENTS.md" "workspace/agents/$agent/"
            echo "  ✅ 复制 $agent 人格模板"
        fi
    done
    
    echo -e "${GREEN}✅ 人格模板复制完成${NC}"
    echo -e "${YELLOW}⚠️  请编辑 workspace/agents/*/ 下的文件，填入具体内容${NC}"
}

# 生成openclaw.json
generate_config() {
    echo ""
    echo "⚙️  生成配置文件..."
    
    if [ -f "openclaw.json" ]; then
        echo -e "${YELLOW}⚠️  openclaw.json 已存在，备份为 openclaw.json.backup${NC}"
        cp openclaw.json "openclaw.json.backup.$(date +%s)"
    fi
    
    # 这里可以使用 sed 替换模板中的占位符
    # 简化起见，提示用户手动编辑
    echo -e "${YELLOW}⚠️  请手动编辑 openclaw-config-template.json，替换所有占位符${NC}"
    echo "然后将其保存为 openclaw.json"
    echo ""
    echo "关键配置项："
    echo "  1. 填入所有 YOUR_XXX_BOT_TOKEN"
    echo "  2. 填入所有 Discord User ID"
    echo "  3. 填入 YOUR_GUILD_ID 和 YOUR_CHANNEL_ID"
}

# 主函数
main() {
    check_openclaw
    check_env
    create_directories
    copy_persona_templates
    generate_config
    
    echo ""
    echo "========================================"
    echo -e "${GREEN}🎉 部署准备完成！${NC}"
    echo "========================================"
    echo ""
    echo "下一步："
    echo "1. 编辑 workspace/agents/*/ 下的人格文件"
    echo "2. 编辑 openclaw-config-template.json 并保存为 openclaw.json"
    echo "3. 运行: openclaw gateway"
    echo ""
    echo "详细教程: MULTI_AGENT_SETUP_GUIDE.md"
    echo ""
}

# 运行主函数
main
