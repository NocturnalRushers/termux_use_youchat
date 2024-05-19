#!/bin/bash

# Check if 'apt' is available
if ! command -v apt &> /dev/null; then
    echo "Error: 'apt' package manager is not available."
    exit 1
fi

# Check and install 'apt update'
if ! apt list --upgradable &> /dev/null; then
    echo "Running 'apt update'..."
    apt update
fi

# Check and install 'apt upgrade'
if ! apt list --upgradable &> /dev/null; then
    echo "Running 'apt upgrade'..."
    apt upgrade -y
fi

# Check and install 'nodejs'
if ! command -v node &> /dev/null; then
    echo "Installing 'nodejs'..."
    apt install nodejs -y
fi

# Check and install 'git'
if ! command -v git &> /dev/null; then
    echo "Installing 'git'..."
    apt install git -y
fi

echo "All required packages are installed."

# 克隆YOUChat_Proxy项目
git clone https://github.com/NocturnalRushers/Youchat_proxy_ter.git
cd Youchat_proxy_ter

# 检查是否需要更新包
echo "检查是否需要更新包..."
pkg upgrade -y

# 检查并安装nodejs
if ! command -v node &> /dev/null
then
    echo "nodejs 未安装，正在安装 nodejs..."
    pkg install nodejs -y
fi

# 安装依赖
npm install

echo "是否要启动第二个脚本tuy.sh？(y/n)"
read launch_choice
if [ "$launch_choice" = "y" ]; then
cd /data/data/com.termux/files/home
curl -O https://raw.githubusercontent.com/NocturnalRushers/termux_use_youchat/main/tuy.sh && chmod +x tuy.sh && ./tuy.sh
else
    echo "退出当前脚本。"
fi
