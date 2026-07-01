#!/bin/bash
# install.sh - Ubuntu Linux内核编译依赖一键安装 x86_64
set -euo pipefail

# 无root权限则自动sudo重新运行
if [ "$(id -u)" -ne 0 ]; then
    echo "需要管理员权限安装依赖，自动调用sudo重新执行脚本..."
    exec sudo bash "$0" "$@"
fi

echo "====================================="
echo "更新软件源并安装Linux x86_64编译全套依赖"
echo "====================================="

apt update -y
apt upgrade -y

DEPS=(
    build-essential gcc g++ make cmake
    libncurses-dev flex bison libssl-dev
    libelf-dev libudev-dev libpci-dev libiberty-dev autoconf
    git wget curl dwarves cpio bc rsync
)

apt install -y "${DEPS[@]}"

echo "====================================="
echo "✅ 依赖全部安装完毕"
echo "使用流程："
echo "1. ./makeconfig.sh 生成内核配置"
echo "2. ./build.sh 多核编译内核"
echo "====================================="
