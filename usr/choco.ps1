Set-ExecutionPolicy Bypass -Scope Process -Force;
$InstallDir='C:\chocoportable'  
[Environment]::SetEnvironmentVariable('ChocolateyInstall', "$InstallDir", 'User')
$env:ChocolateyInstall="$InstallDir"
iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
C:\chocoportable\choco.exe install -y telegram
Remove-Item -Path C:\chocoportable -Recurse -Force
exit
