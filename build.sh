#!/bin/bash

# Mihomo-ECH 跨平台编译脚本
# 支持: Linux AMD64, Linux ARM64, Windows AMD64

set -e

echo "========================================="
echo "  Mihomo-ECH 跨平台编译脚本"
echo "========================================="
echo ""

# 颜色定义
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# 版本信息
VERSION=$(git describe --tags --always --dirty 2>/dev/null || echo "dev")
BUILD_TIME=$(date -u '+%Y-%m-%d %H:%M:%S UTC')
GO_VERSION=$(go version | awk '{print $3}')

echo -e "${BLUE}版本信息:${NC}"
echo "  版本: $VERSION"
echo "  构建时间: $BUILD_TIME"
echo "  Go 版本: $GO_VERSION"
echo ""

# 创建输出目录
OUTPUT_DIR="build"
rm -rf $OUTPUT_DIR
mkdir -p $OUTPUT_DIR

# 编译函数
build() {
    local GOOS=$1
    local GOARCH=$2
    local OUTPUT=$3
    
    echo -e "${BLUE}[编译] $GOOS/$GOARCH${NC}"
    
    # 设置编译参数
    export CGO_ENABLED=0
    export GOOS=$GOOS
    export GOARCH=$GOARCH
    
    # 编译
    go build -trimpath \
        -ldflags "-s -w -X 'github.com/metacubex/mihomo/constant.Version=$VERSION' -X 'github.com/metacubex/mihomo/constant.BuildTime=$BUILD_TIME'" \
        -o "$OUTPUT_DIR/$OUTPUT" \
        .
    
    if [ $? -eq 0 ]; then
        local SIZE=$(du -h "$OUTPUT_DIR/$OUTPUT" | cut -f1)
        echo -e "${GREEN}[成功] $OUTPUT ($SIZE)${NC}"
    else
        echo -e "${RED}[失败] $OUTPUT${NC}"
        exit 1
    fi
    echo ""
}

# 开始编译
echo "========================================="
echo "  开始编译"
echo "========================================="
echo ""

# Linux AMD64
build linux amd64 mihomo-linux-amd64

# Linux ARM64
build linux arm64 mihomo-linux-arm64

# Windows AMD64
build windows amd64 mihomo-windows-amd64.exe

# 编译完成
echo "========================================="
echo "  编译完成!"
echo "========================================="
echo ""
echo "输出文件:"
ls -lh $OUTPUT_DIR/
echo ""
echo -e "${GREEN}所有文件已保存到 $OUTPUT_DIR/ 目录${NC}"
