# 宿舍报修系统 (Dormitory Repair System)

基于 Java + Vue 3 的宿舍报修管理系统。

## 项目结构

```
dormitory-repair-system/
├── frontend/          # 前端 - Vue 3 + TypeScript
└── backend/           # 后端 - Spring Boot + MyBatis-Plus
```

## 环境要求

- **Java** 17+
- **Node.js** 18+
- **MariaDB** (或 MySQL 8.0+)
- 数据库 `dormitory_repair` 需提前创建，SQL 文件见 `backend/src/main/resources/seed_data.sql`

## 一键启动

### Windows

双击 `start.bat`（命令提示符）或右键 `start.ps1` → **使用 PowerShell 运行**。

脚本会自动完成：
1. 安装前端依赖 (`npm install`)
2. 编译后端项目 (`mvnw clean package`)
3. 启动后端服务 → http://localhost:8012
4. 启动前端服务 → http://localhost:8011

### 手动启动

**后端：**
```bash
cd backend
mvnw.cmd spring-boot:run    # Windows
./mvnw spring-boot:run      # Linux / macOS
```

**前端：**
```bash
cd frontend
npm install
npm run dev
```

### 访问地址

| 服务 | 地址 |
|------|------|
| 前端页面 | http://localhost:8011 |
| 后端接口 | http://localhost:8012 |

### 数据库

执行 `backend/src/main/resources/seed_data.sql` 初始化数据库：

```bash
mysql -u root -p < backend/src/main/resources/seed_data.sql
```

## 默认账号

| 角色 | 用户名 | 密码 |
|------|--------|------|
| 管理员 | admin | admin123 |
| 学生 | test01 / stu2~stu22 | 123456 |
