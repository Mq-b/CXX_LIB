# 检查是否以管理员权限运行
function Test-Admin {
    $currentUser = New-Object Security.Principal.WindowsPrincipal (
        [Security.Principal.WindowsIdentity]::GetCurrent()
    )
    return $currentUser.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
}

if (-not (Test-Admin)) {
    Write-Host "未以管理员权限运行，尝试以管理员身份重新启动脚本..." -ForegroundColor Yellow
    Start-Process powershell.exe -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
    exit
}

# 加载 Windows Forms 以支持文件夹选择对话框
Add-Type -AssemblyName System.Windows.Forms

# 创建文件夹选择对话框
$folderBrowser = New-Object System.Windows.Forms.FolderBrowserDialog
$folderBrowser.Description = "请选择存放 CXX_LIB 的文件夹"
$folderBrowser.ShowNewFolderButton = $true

# 显示对话框并获取用户选择的路径
if ($folderBrowser.ShowDialog() -eq [System.Windows.Forms.DialogResult]::OK) {
    $destinationPath = $folderBrowser.SelectedPath
} else {
    Write-Host "未选择路径，操作已取消。" -ForegroundColor Yellow
    exit 1
}

# 如果用户选择的是盘符根目录，例如 D:\
if ([System.IO.Directory]::Exists($destinationPath) -and [System.IO.Path]::GetPathRoot($destinationPath) -eq $destinationPath) {
    $destinationPath = Join-Path $destinationPath "CXX_LIB"
    Write-Host "目标是盘符根目录，创建子目录: $destinationPath" -ForegroundColor Yellow
    New-Item -ItemType Directory -Path $destinationPath -Force | Out-Null
}

# 构建仓库 URL
$repoUrl = "https://github.com/Mq-b/CXX_LIB"

# 克隆仓库
Write-Host "正在克隆仓库到 $destinationPath ..." -ForegroundColor Green
git clone $repoUrl $destinationPath

if ($LASTEXITCODE -ne 0) {
    Write-Host "仓库克隆失败，请检查您的网络连接或存储路径。" -ForegroundColor Red
    exit 1
}

Write-Host "仓库已成功克隆至 $destinationPath。" -ForegroundColor Green

# 设置全局环境变量
$envName = "CMAKE_PREFIX_PATH"
$setPathCommand = "[Environment]::SetEnvironmentVariable('$envName', '$destinationPath', [EnvironmentVariableTarget]::Machine)"

try {
    Invoke-Expression $setPathCommand
    Write-Host "环境变量 $envName 已设置为 $destinationPath。" -ForegroundColor Green
} catch {
    Write-Host "设置全局环境变量失败：" $_.Exception.Message -ForegroundColor Red
    exit 1
}

Write-Host "操作完成，请重新启动终端以使环境变量生效。" -ForegroundColor Cyan
