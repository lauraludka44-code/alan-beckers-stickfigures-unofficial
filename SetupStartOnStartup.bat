@echo off
setlocal

rem Define the paths
set TARGET_PATH=%~dp0AlansStickfigures.jar
set SHORTCUT_PATH=%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup\Alan Beckers Stickfigures.lnk
set SHORTCUT_STARTUP_PATH=%APPDATA%\Microsoft\Windows\Start Menu\Programs\Alan Beckers Stickfigures.lnk
set ICON_PATH=%~dp0img\icon.ico

rem Enable detailed error handling
set ERRORS_LOG=%~dp0error_log.txt

rem Check if the .jar file exists
if not exist "%TARGET_PATH%" (
  echo Error: %TARGET_PATH% does not exist.
  pause
  exit /b 1
)

rem Check if the icon file exists
if not exist "%ICON_PATH%" (
  echo Error: %ICON_PATH% does not exist.
  pause
  exit /b 1
)

rem Create the shortcut using PowerShell with error handling
powershell -command "try { $WshShell = New-Object -ComObject WScript.Shell; $Shortcut = $WshShell.CreateShortcut('%SHORTCUT_PATH%'); $Shortcut.TargetPath = '%TARGET_PATH%'; $Shortcut.WorkingDirectory = '%~dp0'; $Shortcut.IconLocation = '%ICON_PATH%'; $Shortcut.Save(); Write-Output 'Startup Shortcut created successfully.'; } catch { Write-Output 'Error: Unable to create startup shortcut.'; $_ | Out-File -FilePath '%ERRORS_LOG%'; exit 1; }"

powershell -command "try { $WshShell = New-Object -ComObject WScript.Shell; $Shortcut = $WshShell.CreateShortcut('%SHORTCUT_STARTUP_PATH%'); $Shortcut.TargetPath = '%TARGET_PATH%'; $Shortcut.WorkingDirectory = '%~dp0'; $Shortcut.IconLocation = '%ICON_PATH%'; $Shortcut.Save(); Write-Output 'Programs Shortcut created successfully.'; } catch { Write-Output 'Error: Unable to create programs shortcut.'; $_ | Out-File -FilePath '%ERRORS_LOG%'; exit 1; }"

if %errorlevel% neq 0 (
  echo Failed to create the shortcut. See error_log.txt for details.
  pause
) else (
  echo Shortcuts created successfully.
  pause
)

endlocal
