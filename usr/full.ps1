Write-Host "Checking for admin rights..."
if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(`
[Security.Principal.WindowsBuiltInRole] "Administrator")) {
Write-Warning "Insufficient rights. Programm will be restarted with elevated access."
pause
Start-Process Powershell -ArgumentList $PSCommandPath -Verb RunAs
break
}
else {
Write-Host "Checked successfully. Commencing install..." -ForegroundColor Green
}

$Folder = 'C:\ProgramData\chocolatey'
if (Test-Path -Path $Folder) {
    Write-Host "Chocolatey is already installed. Delete 'C:\ProgramData\chocolatey' if not needed." -ForegroundColor red
    pause
    exit 55
}

$Folder = 'C:\chocoportable'
if (Test-Path -Path $Folder) {
    Write-Host "Choco portable is already installed. Delete C\chocoportable and try again." -ForegroundColor red
    pause
    exit 55
}
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))




choco install -y telegram 7zip googlechrome adobereader

New-Item -ErrorAction Ignore env:ChocolateyInstall -Value "C:\ProgramData\chocolatey"
icacls "$env:ChocolateyInstall" /remove BUILTIN\Users
