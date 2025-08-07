@echo off
chcp 65001 >nul

echo [INFO] setup-links.bat 
echo [INFO] Starting symlink setup...


ech[INFO] Checking administrator privileges...
net session >nul 2>&1
if %enulorlevel% neq 0 (
    echo [ERROR] This script requires administrator privileges.
    echo [ERROR] Please run as administrator.
    pause
    exit /b 1
)

set REPO=Z:\github.com\yasuhiro112358\cmd-tools
echo [INFO] Repository path: %REPO%

REM ソースディレクトリの存ls
echo [INFO] Source path: %SRC%
if not exist "%SRC%" (
    echo [ERROR] Source directory does not exist: %SRC%
    echo [ERROR] Please check the repository path.
    pause
    exit /b 1
)

set DST=C:\apps\tools
echo [INFO] Destination path: %DST%

if not exist "%DST%" (
    eo [INFO] Making directory: %DST%
    mkdir "%DST%"
    if %errorlevel% neq 0 (
        echo [ERROR] Failed to create directory: %DST%
        pause
        exit /b 1
    )
)

echo [INFO] Processing .bat files in %SRC%...
set /a count=0
for %%F in ("%SRC%\*.bat") do (
    set "SRCFILE=%%~fF"
    set "DSTLINK=%DST%\%%~nxF"
    set /a count+=1

    if exist "%DST%\%%~nxF" (
        echo [SKIP] Already exists: %DST%\%%~nxF
    ) else (
        echo [LINK] Creating symlink: %%~nxF
        echo       Source: %%~fF
        echo       Target: %DST%\%%~nxF
        mklink "%DST%\%%~nxF" "%%~fF"
        if %errrlevel% neq 0 (
            echo [ERROR] Failed to create symlink for: %%~nxF
        ) else (
            echo [SUCCESS] Symlink created successfully.
        )
    )
    echo.
)

echo [INFO] Processing completed. Total files processed: %count%

pause