#!/bin/bash
# build.sh 多核编译 x86_64 Linux内核
set -euo pipefail

# 无root自动sudo重跑
if [ "$(id -u)" -ne 0 ]; then
    echo "编译内核需要管理员权限，自动sudo启动脚本..."
    exec sudo bash "$0" "$@"
fi

# 校验源码根目录
if [ ! -f "Makefile" ] || [ ! -d "arch/x86" ]; then
    echo "❌ 错误：必须在Linux源码根目录执行本脚本"
    exit 1
fi

export ARCH=x86_64
# 获取CPU全部核心数，全速编译
CPU_CORES=$(nproc)
echo "====================================="
echo "ARCH=x86_64 并行编译内核"
echo "CPU核心数：$CPU_CORES ，使用 -j$CPU_CORES 全速编译"
echo "====================================="

# 编译内核镜像 + 内核模块
make -j$CPU_CORES ARCH=x86_64
make -j$CPU_CORES ARCH=x86_64 modules

echo ""
echo "====================================="
echo "✅ 内核与模块编译完成"
echo "如需安装内核到系统：make modules_install && make install ARCH=x86_64"
echo "====================================="
