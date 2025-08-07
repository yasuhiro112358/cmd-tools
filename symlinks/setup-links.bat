@echo off
setlocal EnableDelayedExpansion
chcp 65001 >nul

:: Set env variables
set DST=C:\apps\tools

cd %~dp0\..
set REPO=%CD%
set SRC=%REPO%\tools

echo [INFO] === setup-links.bat === 
echo [INFO] Starting symlink setup...

echo [INFO] Repository path : %REPO%
echo [INFO] Source path     : %SRC%
echo [INFO] Destination path: %DST%

echo [INFO] Checking administrator privileges...
net session >nul 2>nul
if %errorlevel% neq 0 (
    echo [ERROR] This script requires administrator privileges.
    echo [ERROR] Please run as administrator.
    pause
    exit /b 1
)

if not exist "%SRC%" (
    echo [ERROR] Source directory does not exist: %SRC%
    echo [ERROR] Please check the repository path.
    pause
    exit /b 1
)


if not exist "%DST%" (
    echo [INFO] Making directory: %DST%
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
	set "DSTLINK=!DST!\%%~nxF"
	
    if exist "!DST!\%%~nxF" (
        echo [INFO] Already exists: !DST!\%%~nxF
    ) else (
        echo [INFO] Creating symlink: %%~nxF
        mklink "!DST!\%%~nxF" "%%~fF"
        if !errrlevel! neq 0 (
            echo [ERROR] Failed to create symlink for: %%~nxF
        ) 
    )	
	set /a count+=1
)

echo [INFO] Processing completed. Total files processed: %count%

pause