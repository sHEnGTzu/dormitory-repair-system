# 宿舍报修系统 (Dormitory Repair System)

基于 Java + Vue 3 的宿舍报修管理系统。

## 项目结构

```
dormitory-repair-system/
├── frontend/          # 前端 - Vue 3 + TypeScript
└── backend/           # 后端 - Spring Boot + MyBatis-Plus
```

## 快速启动

### 后端

```bash
cd backend
mvn spring-boot:run
```

服务运行在 `http://localhost:8012`

### 前端

```bash
cd frontend
pnpm install
pnpm dev
```

服务运行在 `http://localhost:8011`

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
