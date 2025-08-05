@echo off
chcp 65001 >nul

echo ===============================
echo [env-check.bat] 開発環境チェック開始
echo ===============================

REM set GITCMD="C:\apps\git\PortableGit\cmd"
set GITCMD=C:\apps\git\PortableGit\cmd
echo [INFO] GITCMD=%GITCMD%
set PATH=%GITCMD%;%PATH%

set NPPCMD=C:\apps\notepad++\npp.8.8.3.portable.x64
echo [INFO] NPPCMD=%NPPCMD%
set PATH=%NPPCMD%;%PATH%

echo [INFO] PATH=%PATH%

REM 3. Git チェック
where git >nul 2>nul
if %errorlevel% == 0 (
	echo [OK] Git found:
	where git
    git --version
) else (
	echo [ERROR] Git not found: %GITCMD%
    pause
    exit /b
)

REM 4. Notepad++ チェック（任意）
where notepad++ >nul 2>nul
if %errorlevel% == 0 (
    echo [OK] Notepad++ found:
	where notepad++
) else (
    echo [WARNING] Notepad++ not found at expected location: %NPPCMD%
)

REM 5. システム情報（確認用）
echo [INFO] OS: %OS%
echo [INFO] PROCESSOR_ARCHITECTURE: %PROCESSOR_ARCHITECTURE%

echo ===============================
echo [env-check.bat] 完了
echo ===============================

pause
