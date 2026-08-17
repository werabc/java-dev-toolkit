# 部署清单

## 部署包内容

```
deploy-package/
├── deploy.sh                     # 一键部署脚本
├── docker-compose.yml            # Docker 编排配置
├── permission-admin/             # 后端源码
│   ├── permission-api/           # API 模块 (控制器)
│   ├── permission-common/        # 公共模块 (实体、DTO)
│   ├── permission-framework/     # 框架模块 (安全、JWT)
│   ├── permission-system/        # 系统模块 (服务、Mapper)
│   ├── sql/                      # SQL 脚本
│   ├── Dockerfile                # Docker 构建文件
│   └── pom.xml                   # Maven 配置
├── permission-ui/                # 管理后台前端
│   ├── src/                      # 源码
│   ├── nginx.conf                # Nginx 配置
│   ├── Dockerfile                # Docker 构建文件
│   └── package.json              # npm 配置
├── treehole-web/                 # 树洞用户端前端
│   ├── src/                      # 源码
│   ├── nginx.conf                # Nginx 配置
│   ├── Dockerfile                # Docker 构建文件
│   └── package.json              # npm 配置
└── docs/                         # 文档
    ├── API.md                    # API 接口文档
    └── DEVELOPMENT.md            # 开发文档
```

## 安全密钥 (已生成)

```
JWT_SECRET_KEY=VlqkEc6zS/x7fmKbIR/Gxds3vuX1AeuheQqYzFszLzhyVcDr/K7M9kBRWI0D2HIrQf0Fkc6N7qXbWQaO6pLI+w==
MYSQL_ROOT_PASSWORD=123456abc
REDIS_PASSWORD=redis123456
```

## 部署步骤

### 1. 上传部署包到服务器

```bash
scp -r deploy-package root@your-server:/home/admin/app/deploy
```

### 2. 执行部署脚本

```bash
cd /home/admin/app/deploy
chmod +x deploy.sh
./deploy.sh
```

### 3. 验证服务

```bash
# 查看容器状态
docker-compose ps

# 查看日志
docker-compose logs -f backend

# 测试 API
curl http://localhost:8081/api/auth/captcha
```

## 端口分配

| 服务 | 端口 | 说明 |
|------|------|------|
| treehole-web | 80 | 树洞用户端 |
| backend | 8081 | 后端 API |
| frontend | 8082 | 管理后台 |
| mysql | 3306 | 数据库 |
| redis | 6379 | 缓存 |

## 默认账号

| 角色 | 用户名 | 密码 |
|------|--------|------|
| 管理员 | admin | Admin@1234 |
| 树洞用户 | 自行注册 | - |

## 新增功能 (v1.1.0)

### 后端
- **ThPublicController**: 树洞公共接口 (分类/帖子/评论/举报/个人中心)
- **ThReportService.createReport()**: 创建举报功能
- **ThUserService 扩展**: 个人中心、通知、个人资料管理

### 前端
- **新增页面**: 操作日志、登录日志
- **增强视图**: 仪表盘、用户管理、帖子管理、评论管理、举报管理 (9个视图)

### Bug 修复
- 修复举报后页面无响应 (添加错误处理)
- 修复 Nginx 配置语法错误
- 修复 Dashboard API 500 错误

## 数据库表 (16张)

### 系统管理表
- sys_user, sys_role, sys_menu, sys_dept
- sys_user_role, sys_role_menu
- sys_login_log, sys_operation_log

### 树洞业务表
- th_user, th_post, th_comment, th_category
- th_like, th_report, th_notification
- th_setting, th_announcement, th_user_log

## 注意事项

1. **首次启动**会自动创建数据库表
2. **JWT 密钥**已随机生成，请妥善保管
3. **生产环境**请修改默认密码
4. **端口冲突**请修改 docker-compose.yml 中的端口映射
