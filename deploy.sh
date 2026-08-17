#!/bin/bash
# =============================================
# 权限管理系统 - 一键部署脚本
# =============================================

set -e

echo "============================================"
echo "=== 权限管理系统部署 ==="
echo "============================================"

# 检查 Docker 是否安装
if ! command -v docker &> /dev/null; then
    echo "错误: Docker 未安装"
    exit 1
fi

# 检查 Docker Compose 是否安装
if ! command -v docker-compose &> /dev/null; then
    echo "错误: Docker Compose 未安装"
    exit 1
fi

echo ""
echo "步骤 1/5: 构建后端镜像..."
docker-compose build --no-cache backend

echo ""
echo "步骤 2/5: 构建管理后台前端镜像..."
docker-compose build --no-cache frontend

echo ""
echo "步骤 3/5: 构建树洞用户端前端镜像..."
docker-compose build --no-cache treehole-web

echo ""
echo "步骤 4/5: 启动所有服务..."
docker-compose up -d

echo ""
echo "步骤 5/5: 等待服务启动..."
sleep 15

echo ""
echo "============================================"
echo "=== 部署完成！ ==="
echo "============================================"
echo ""
echo "服务地址:"
echo "  树洞用户端: http://localhost"
echo "  管理后台:   http://localhost:8082"
echo "  后端API:    http://localhost:8081"
echo ""
echo "默认账号:"
echo "  管理员: admin / Admin@1234"
echo ""
echo "查看日志:"
echo "  docker-compose logs -f backend"
echo "  docker-compose logs -f frontend"
echo ""
echo "停止服务:"
echo "  docker-compose down"
echo ""
