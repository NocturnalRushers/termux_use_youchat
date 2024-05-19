#!/bin/bash

# 检查并安装git
if ! command -v git &> /dev/null
then
    echo "git 未安装，正在安装 git..."
    pkg install git -y
fi

# 克隆YOUChat_Proxy项目
git https://github.com/NocturnalRushers/YOUChat_Proxy.git
cd YOUChat_Proxy

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
curl -O https://github.com/NocturnalRushers/termux_use_youchat/blob/main/tuy.sh && chmod +x tuy.sh && ./tuy.sh
else
    echo "退出当前脚本。"
fi
