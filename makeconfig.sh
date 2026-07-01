#!/bin/bash
# makeconfig.sh 生成ARCH=x86_64 tinyconfig / olddefconfig
set -euo pipefail

# 无root自动sudo重跑
if [ "$(id -u)" -ne 0 ]; then
    echo "需要管理员权限操作内核配置，自动sudo执行..."
    exec sudo bash "$0" "$@"
fi

# 校验当前目录是Linux源码根目录
if [ ! -f "Makefile" ] || [ ! -d "arch/x86" ]; then
    echo "❌ 错误：请进入Linux源码根目录再运行此脚本！"
    exit 1
fi

export ARCH=x86_64

echo "====================================="
echo "ARCH=$ARCH 内核配置生成工具"
echo "1 - tinyconfig 极简内核配置"
echo "2 - olddefconfig 修复/补全现有.config默认配置"
echo "====================================="
read -p "输入数字选择模式(1/2)：" MODE

case $MODE in
    1)
        echo "正在执行 make tinyconfig ARCH=x86_64"
        make ARCH=x86_64 tinyconfig
        echo "✅ 极简内核配置 .config 生成完成"
        ;;
    2)
        echo "正在执行 make olddefconfig ARCH=x86_64"
        make ARCH=x86_64 olddefconfig
        echo "✅ 现有配置已更新为默认参数"
        ;;
    *)
        echo "❌ 输入非法，仅支持 1 或 2"
        exit 1
        ;;
esac

echo ""
echo "如需手动调参：make menuconfig ARCH=x86_64"
echo "编译内核执行命令：./build.sh"
