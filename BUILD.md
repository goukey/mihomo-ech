# Ubuntu 编译指南

## 📋 前置要求

### 1. 安装 Go

```bash
# 下载 Go (以 1.21.5 为例)
wget https://go.dev/dl/go1.21.5.linux-amd64.tar.gz

# 解压
sudo rm -rf /usr/local/go
sudo tar -C /usr/local -xzf go1.21.5.linux-amd64.tar.gz

# 配置环境变量
echo 'export PATH=$PATH:/usr/local/go/bin' >> ~/.bashrc
source ~/.bashrc

# 验证安装
go version
```

### 2. 安装 Git

```bash
sudo apt update
sudo apt install git -y
```

---

## 🚀 编译步骤

### 方法 1: 使用编译脚本 (推荐)

```bash
# 1. 克隆项目
git clone https://github.com/YOUR_USERNAME/mihomo-ech.git
cd mihomo-ech

# 2. 安装依赖
go mod download

# 3. 赋予执行权限
chmod +x build.sh

# 4. 运行编译脚本
./build.sh
```

编译完成后,文件在 `build/` 目录:
- `mihomo-linux-amd64` - Linux AMD64
- `mihomo-linux-arm64` - Linux ARM64
- `mihomo-windows-amd64.exe` - Windows AMD64

---

### 方法 2: 手动编译

#### Linux AMD64

```bash
CGO_ENABLED=0 GOOS=linux GOARCH=amd64 \
go build -trimpath -ldflags "-s -w" \
-o mihomo-linux-amd64 .
```

#### Linux ARM64

```bash
CGO_ENABLED=0 GOOS=linux GOARCH=arm64 \
go build -trimpath -ldflags "-s -w" \
-o mihomo-linux-arm64 .
```

#### Windows AMD64

```bash
CGO_ENABLED=0 GOOS=windows GOARCH=amd64 \
go build -trimpath -ldflags "-s -w" \
-o mihomo-windows-amd64.exe .
```

---

## 📦 编译参数说明

| 参数 | 说明 |
|------|------|
| `CGO_ENABLED=0` | 禁用 CGO,生成纯静态二进制 |
| `GOOS` | 目标操作系统 (linux/windows) |
| `GOARCH` | 目标架构 (amd64/arm64) |
| `-trimpath` | 移除文件系统路径 |
| `-ldflags "-s -w"` | 去除调试信息,减小文件大小 |

---

## ✅ 验证编译结果

### 检查文件

```bash
ls -lh build/
```

### 测试运行

#### Linux

```bash
# AMD64
./build/mihomo-linux-amd64 -v

# ARM64 (需要在 ARM64 机器上)
./build/mihomo-linux-arm64 -v
```

#### Windows

```bash
# 在 Windows 上运行
mihomo-windows-amd64.exe -v
```

---

## 🎯 一键编译命令

如果你只想快速编译,直接运行:

```bash
git clone https://github.com/YOUR_USERNAME/mihomo-ech.git && \
cd mihomo-ech && \
go mod download && \
chmod +x build.sh && \
./build.sh
```

---

## 📊 预期文件大小

| 平台 | 文件大小 (约) |
|------|--------------|
| Linux AMD64 | ~15-20 MB |
| Linux ARM64 | ~15-20 MB |
| Windows AMD64 | ~15-20 MB |

---

## 🐛 常见问题

### Q: 编译报错 "go: command not found"

**A**: Go 未正确安装或环境变量未配置
```bash
# 检查 Go 是否安装
which go

# 重新配置环境变量
export PATH=$PATH:/usr/local/go/bin
```

### Q: 编译报错 "package xxx is not in GOROOT"

**A**: 依赖未下载
```bash
go mod download
go mod tidy
```

### Q: 权限不足

**A**: 赋予脚本执行权限
```bash
chmod +x build.sh
```

### Q: 编译速度慢

**A**: 配置 Go 代理加速
```bash
go env -w GOPROXY=https://goproxy.cn,direct
```

---

## 🚀 高级选项

### 并行编译

```bash
# 修改 build.sh,添加并行编译
build linux amd64 mihomo-linux-amd64 &
build linux arm64 mihomo-linux-arm64 &
build windows amd64 mihomo-windows-amd64.exe &
wait
```

### 压缩文件

```bash
# 编译后压缩
cd build
tar -czf mihomo-linux-amd64.tar.gz mihomo-linux-amd64
tar -czf mihomo-linux-arm64.tar.gz mihomo-linux-arm64
zip mihomo-windows-amd64.zip mihomo-windows-amd64.exe
```

### 添加版本信息

```bash
# 在 build.sh 中已包含
VERSION=$(git describe --tags --always)
BUILD_TIME=$(date -u '+%Y-%m-%d %H:%M:%S UTC')
```

---

## 📝 完整示例

```bash
# 1. 准备环境
sudo apt update
sudo apt install git wget -y

# 2. 安装 Go
wget https://go.dev/dl/go1.21.5.linux-amd64.tar.gz
sudo tar -C /usr/local -xzf go1.21.5.linux-amd64.tar.gz
echo 'export PATH=$PATH:/usr/local/go/bin' >> ~/.bashrc
source ~/.bashrc

# 3. 配置 Go 代理 (可选,加速下载)
go env -w GOPROXY=https://goproxy.cn,direct

# 4. 克隆并编译
git clone https://github.com/YOUR_USERNAME/mihomo-ech.git
cd mihomo-ech
go mod download
chmod +x build.sh
./build.sh

# 5. 查看结果
ls -lh build/
```

---

## ✨ 编译成功后

你将得到三个可执行文件:

1. **mihomo-linux-amd64** - 适用于 x86_64 Linux 系统
2. **mihomo-linux-arm64** - 适用于 ARM64 Linux 系统 (如树莓派)
3. **mihomo-windows-amd64.exe** - 适用于 Windows 64位系统

可以直接分发给用户使用! 🎉
