@echo off
chcp 65001 >nul
title 宿舍报修系统 - 启动中...

echo ============================================
echo    宿舍报修系统 - 一键启动脚本
echo ============================================
echo.

REM ----- 检查后端依赖 -----
where java >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo [错误] 未找到 Java，请安装 JDK 17+ 并配置环境变量
    pause
    exit /b 1
)

REM ----- 检查 Node.js -----
where node >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo [错误] 未找到 Node.js，请安装 Node.js 18+ 并配置环境变量
    pause
    exit /b 1
)

set ROOT=%~dp0

echo ^> [1/4] 安装前端依赖（如有新增依赖才会下载）...
cd /d "%ROOT%frontend"
call npm install
if %ERRORLEVEL% neq 0 (
    echo [错误] npm install 失败
    pause
    exit /b 1
)
echo.

REM ----- 检查后端是否已编译 -----
if exist "%ROOT%backend\target\dormitory-repair-1.0.0.jar" (
    echo ^> [2/4] 后端 JAR 已存在，跳过编译
) else (
    echo ^> [2/4] 编译后端项目（首次或 JAR 不存在时触发）...
    cd /d "%ROOT%backend"
    call mvnw.cmd clean package -DskipTests -q
    if %ERRORLEVEL% neq 0 (
        echo [错误] 后端编译失败
        pause
        exit /b 1
    )
)
echo.

echo ^> [3/4] 启动后端服务 (端口 8012)...
start "Backend" cmd /c "cd /d "%ROOT%backend" && java -jar target\dormitory-repair-1.0.0.jar"
echo.

echo ^> [4/4] 启动前端服务 (端口 8011)...
start "Frontend" cmd /c "cd /d "%ROOT%frontend" && npm run dev"
echo.

echo ============================================
echo    启动完成！
echo.
echo    前端页面: http://localhost:8011
echo    后端接口: http://localhost:8012
echo.
echo    提示: 请确保 MariaDB/MySQL 已启动
echo         且数据库 dormitory_repair 存在
echo ============================================
echo.

pause
