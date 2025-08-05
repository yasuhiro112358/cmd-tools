@echo off

set GITCMD="C:\apps\git\PortableGit\cmd"
set PATH=%GITCMD%;%PATH%

echo [INFO] Git global configuration:
git config --global --list
echo.

pause
