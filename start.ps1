Write-Host "============================================" -ForegroundColor Cyan
Write-Host "   宿舍报修系统 - 一键启动脚本" -ForegroundColor Cyan
Write-Host "============================================" -ForegroundColor Cyan
Write-Host ""

$Root = Split-Path -Parent $MyInvocation.MyCommand.Path

# ----- 检查 Java -----
if (-not (Get-Command java -ErrorAction SilentlyContinue)) {
    Write-Host "[错误] 未找到 Java，请安装 JDK 17+ 并配置环境变量" -ForegroundColor Red
    Read-Host "按回车键退出"
    exit 1
}

# ----- 检查 Node.js -----
if (-not (Get-Command node -ErrorAction SilentlyContinue)) {
    Write-Host "[错误] 未找到 Node.js，请安装 Node.js 18+ 并配置环境变量" -ForegroundColor Red
    Read-Host "按回车键退出"
    exit 1
}

Write-Host "> [1/4] 安装前端依赖（如有新增依赖才会下载）..." -ForegroundColor Yellow
Set-Location "$Root\frontend"
npm install
if ($LASTEXITCODE -ne 0) {
    Write-Host "[错误] npm install 失败" -ForegroundColor Red
    Read-Host "按回车键退出"
    exit 1
}
Write-Host ""

$jarPath = "$Root\backend\target\dormitory-repair-1.0.0.jar"
if (Test-Path $jarPath) {
    Write-Host "> [2/4] 后端 JAR 已存在，跳过编译" -ForegroundColor Yellow
} else {
    Write-Host "> [2/4] 编译后端项目（首次或 JAR 不存在时触发）..." -ForegroundColor Yellow
    Set-Location "$Root\backend"
    .\mvnw.cmd clean package -DskipTests -q
    if ($LASTEXITCODE -ne 0) {
        Write-Host "[错误] 后端编译失败" -ForegroundColor Red
        Read-Host "按回车键退出"
        exit 1
    }
}
Write-Host ""

Write-Host "> [3/4] 启动后端服务 (端口 8012)..." -ForegroundColor Yellow
$backendJob = Start-Job -Name "Backend" -ScriptBlock {
    param($dir)
    Set-Location $dir
    java -jar "target\dormitory-repair-1.0.0.jar"
} -ArgumentList "$Root\backend"
Write-Host "   后端 PID: $($backendJob.Id)"
Write-Host ""

Write-Host "> [4/4] 启动前端服务 (端口 8011)..." -ForegroundColor Yellow
$frontendJob = Start-Job -Name "Frontend" -ScriptBlock {
    param($dir)
    Set-Location $dir
    npm run dev
} -ArgumentList "$Root\frontend"
Write-Host "   前端 PID: $($frontendJob.Id)"
Write-Host ""

Write-Host "============================================" -ForegroundColor Green
Write-Host "   启动完成！" -ForegroundColor Green
Write-Host ""
Write-Host "   前端页面: http://localhost:8011" -ForegroundColor Green
Write-Host "   后端接口: http://localhost:8012" -ForegroundColor Green
Write-Host ""
Write-Host "   提示: 请确保 MariaDB/MySQL 已启动" -ForegroundColor Yellow
Write-Host "        且数据库 dormitory_repair 存在" -ForegroundColor Yellow
Write-Host ""
Write-Host "   关闭本窗口即可停止所有服务" -ForegroundColor Yellow
Write-Host "============================================" -ForegroundColor Green
Write-Host ""

# 等待用户按 Ctrl+C 退出
Read-Host "按回车键停止服务并退出"

Write-Host "正在停止服务..." -ForegroundColor Yellow
Stop-Job $backendJob
Stop-Job $frontendJob
Remove-Job $backendJob
Remove-Job $frontendJob
Write-Host "服务已停止" -ForegroundColor Cyan
