# ����Ƿ��Թ���ԱȨ������
function Test-Admin {
    $currentUser = New-Object Security.Principal.WindowsPrincipal (
        [Security.Principal.WindowsIdentity]::GetCurrent()
    )
    return $currentUser.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
}

if (-not (Test-Admin)) {
    Write-Host "δ�Թ���ԱȨ�����У������Թ���Ա������������ű�..." -ForegroundColor Yellow
    Start-Process powershell.exe -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
    exit
}

# ���� Windows Forms ��֧���ļ���ѡ��Ի���
Add-Type -AssemblyName System.Windows.Forms

# �����ļ���ѡ��Ի���
$folderBrowser = New-Object System.Windows.Forms.FolderBrowserDialog
$folderBrowser.Description = "��ѡ���� CXX_LIB ���ļ���"
$folderBrowser.ShowNewFolderButton = $true

# ��ʾ�Ի��򲢻�ȡ�û�ѡ���·��
if ($folderBrowser.ShowDialog() -eq [System.Windows.Forms.DialogResult]::OK) {
    $destinationPath = $folderBrowser.SelectedPath
} else {
    Write-Host "δѡ��·����������ȡ����" -ForegroundColor Yellow
    exit 1
}

# ����û�ѡ������̷���Ŀ¼������ D:\
if ([System.IO.Directory]::Exists($destinationPath) -and [System.IO.Path]::GetPathRoot($destinationPath) -eq $destinationPath) {
    $destinationPath = Join-Path $destinationPath "CXX_LIB"
    Write-Host "Ŀ�����̷���Ŀ¼��������Ŀ¼: $destinationPath" -ForegroundColor Yellow
    New-Item -ItemType Directory -Path $destinationPath -Force | Out-Null
}

# �����ֿ� URL
$repoUrl = "https://github.com/Mq-b/CXX_LIB"

# ��¡�ֿ�
Write-Host "���ڿ�¡�ֿ⵽ $destinationPath ..." -ForegroundColor Green
git clone $repoUrl $destinationPath

if ($LASTEXITCODE -ne 0) {
    Write-Host "�ֿ��¡ʧ�ܣ����������������ӻ�洢·����" -ForegroundColor Red
    exit 1
}

Write-Host "�ֿ��ѳɹ���¡�� $destinationPath��" -ForegroundColor Green

# ����ȫ�ֻ�������
$envName = "CMAKE_PREFIX_PATH"
$setPathCommand = "[Environment]::SetEnvironmentVariable('$envName', '$destinationPath', [EnvironmentVariableTarget]::Machine)"

try {
    Invoke-Expression $setPathCommand
    Write-Host "�������� $envName ������Ϊ $destinationPath��" -ForegroundColor Green
} catch {
    Write-Host "����ȫ�ֻ�������ʧ�ܣ�" $_.Exception.Message -ForegroundColor Red
    exit 1
}

Write-Host "������ɣ������������ն���ʹ����������Ч��" -ForegroundColor Cyan
