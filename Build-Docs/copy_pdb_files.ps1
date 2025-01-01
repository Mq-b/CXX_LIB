# 设置源目录和目标目录
$SourceDir = "D:\project\abseil-cpp\build\absl"
$TargetDir = "D:\CXX_LIB\abseil-cpp\lib\Debug"

# 确保目标目录存在
if (-not (Test-Path -Path $TargetDir)) {
    New-Item -ItemType Directory -Path $TargetDir -Force
}

# 获取所有 .pdb 文件并复制到目标目录
Get-ChildItem -Path $SourceDir -Recurse -Filter *.pdb | ForEach-Object {
    $TargetPath = Join-Path -Path $TargetDir -ChildPath $_.Name
    Copy-Item -Path $_.FullName -Destination $TargetPath -Force
}

Write-Host "所有 .pdb 文件已复制到 $TargetDir" -ForegroundColor Green
