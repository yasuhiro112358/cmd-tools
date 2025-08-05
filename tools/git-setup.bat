@echo off
echo Setting up Git global config...

set GITCMD="C:\apps\git\PortableGit\cmd"
set PATH=%GITCMD%;%PATH%

git config --global user.name "Yasuhiro WATANABE"
git config --global user.email "nabeyasu581@gmail.com"
git config --global core.autocrlf true
git config --global i18n.commitEncoding utf-8
git config --global i18n.logOutputEncoding utf-8
git config --global core.editor "C:/apps/notepad++/npp.8.8.3.portable.x64/notepad++.exe"
git config --global color.ui auto
git config --global push.default simple

echo Git global configuration completed.
pause
