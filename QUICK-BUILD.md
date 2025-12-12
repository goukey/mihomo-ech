# 🚀 快速编译指南

## 一键编译 (Ubuntu)

```bash
# 完整流程
git clone https://github.com/YOUR_USERNAME/mihomo-ech.git && \
cd mihomo-ech && \
go mod download && \
chmod +x build.sh && \
./build.sh
```

---

## 分步执行

```bash
# 1. 克隆项目
git clone https://github.com/YOUR_USERNAME/mihomo-ech.git
cd mihomo-ech

# 2. 下载依赖
go mod download

# 3. 编译
chmod +x build.sh
./build.sh
```

---

## 输出文件

编译完成后,在 `build/` 目录:

- ✅ `mihomo-linux-amd64` - Linux x86_64
- ✅ `mihomo-linux-arm64` - Linux ARM64
- ✅ `mihomo-windows-amd64.exe` - Windows 64位

---

## 手动编译单个平台

### Linux AMD64
```bash
CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -trimpath -ldflags "-s -w" -o mihomo-linux-amd64 .
```

### Linux ARM64
```bash
CGO_ENABLED=0 GOOS=linux GOARCH=arm64 go build -trimpath -ldflags "-s -w" -o mihomo-linux-arm64 .
```

### Windows AMD64
```bash
CGO_ENABLED=0 GOOS=windows GOARCH=amd64 go build -trimpath -ldflags "-s -w" -o mihomo-windows-amd64.exe .
```

---

## 常见问题

### Go 未安装?

```bash
wget https://go.dev/dl/go1.21.5.linux-amd64.tar.gz
sudo tar -C /usr/local -xzf go1.21.5.linux-amd64.tar.gz
echo 'export PATH=$PATH:/usr/local/go/bin' >> ~/.bashrc
source ~/.bashrc
```

### 下载慢?

```bash
# 配置国内代理
go env -w GOPROXY=https://goproxy.cn,direct
```

---

## 测试编译结果

```bash
# 查看文件
ls -lh build/

# 测试运行
./build/mihomo-linux-amd64 -v
```

---

详细文档: [BUILD.md](BUILD.md)
