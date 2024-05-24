@ECHO OFF
set "params=%*"
cd /d "%~dp0" && ( if exist "%temp%\getadmin.vbs" del "%temp%\getadmin.vbs" ) && fsutil dirty query %systemdrive% 1>nul 2>nul || (  echo Set UAC = CreateObject^("Shell.Application"^) : UAC.ShellExecute "cmd.exe", "/k cd ""%~sdp0"" && %~s0 %params%", "", "runas", 1 >> "%temp%\getadmin.vbs" && "%temp%\getadmin.vbs" && exit /B )
powershell -executionpolicy RemoteSigned -file "C:\usr\full.ps1"

  if errorlevel 1 goto failed
       ECHO ON
       REG LOAD HKU\TEMP C:\Users\Default\NTUSER.DAT
       REG ADD HKU\TEMP\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnce /v choco /t REG_SZ /d  "C:\usr\choco.bat" /f
       REG UNLOAD HKU\TEMP
       pause
    
  :failed
      color 04
      ECHO "Install failed" 
      exit
