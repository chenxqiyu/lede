#!/bin/bash

# 获取 CPU 核心数
cores=$(nproc)

# 从全部核心开始尝试
for ((i=cores; i>0; )); do
    # 输出当前尝试的编译命令
    echo "尝试使用 $i 个核心..."
    echo "尝试运行以下命令："
    echo "make V=s -j$i $@"

    # 执行编译命令
    make V=s -j$i "$@" && { echo "编译成功，使用 $i 个核心。"; break; }
    i=$((i - 2))

    # 当核心数减到 0 时，将其设置为 1
    if [ $i -eq 0 ]; then
        i=1
    fi
done

if [ $? -ne 0 ]; then
    echo "所有核心配置都编译失败。"
fi
