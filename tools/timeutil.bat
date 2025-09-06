@echo off
chcp 65001 >nul
setlocal EnableExtensions
:: timeutil.bat
:: 使い方:
::   call timeutil :make_iso_timestamp
:: 実行後に呼び出し元へ以下を返す:
::   ISO_DATE=YYYY-MM-DD
::   ISO_TIME=HH:MM:SS
::   ISO_TIMESTAMP=YYYY-MM-DD HH:MM:SS
::   ISO_FILE_TIMESTAMP=YYYY-MM-DD_HH-MM-SS

if "%~1"==":make_iso_timestamp" goto make_iso_timestamp
exit /b 0

:make_iso_timestamp

:: Get iDATE (0=MDY,1=DMY,2=YMD) from registry; order of date components
set "IDATE=2"
for /f "tokens=3" %%I in (
    'reg query ^"HKCU\Control Panel\International^" /v iDate ^| findstr /i ^"iDate^"'
) do (
    set "IDATE=%%I"
)
:: echo [DEBUG] iDate=%IDATE%

:: Get sDate (date separator) from registry
set "SDATE=/"
for /f "tokens=3" %%S in (
    'reg query ^"HKCU\Control Panel\International^" /v sDate ^| findstr /i ^"sDate^"'
) do (
    set "SDATE=%%S"
)
:: echo [DEBUG] sDate=%SDATE%

:: Delims include space to handle cases like "Wed 2024/06/12"
set "DELIMS=%SDATE% "
for /f "tokens=1-4 delims=%DELIMS%" %%A in (
    "%date%"
) do (
    set "D1=%%A" & set "D2=%%B" & set "D3=%%C" & set "D4=%%D"
)
:: echo [DEBUG] D1=%D1%, D2=%D2%, D3=%D3%, D4=%D4%

:: [Issue] D1が曜日の場合がある (例: "Wed 2024/06/12")
:: [Issue] Yearが2桁の場合がある (例: "24/06/12")
if "%IDATE%"=="0" (
    set "MM=%D2%" & set "DD=%D3%" & set "YYYY=%D4%"
) else if "%IDATE%"=="1" (
    set "DD=%D1%" & set "MM=%D2%" & set "YYYY=%D3%"
) else if "%IDATE%"=="2" (
    set "YYYY=%D1%" & set "MM=%D2%" & set "DD=%D3%"
) else (
    echo [ERROR] Unknown iDate value: %IDATE%
    exit /b 1
)

REM Month/Dayが1桁の場合の対策
REM Padding with leading zero
set "MM=0%MM%"
set "MM=%MM:~-2%"
set "DD=0%DD%"
set "DD=%DD:~-2%"

:: 時刻（先頭スペース対策・ミリ秒除去）
set "HH=%TIME:~0,2%"
if "%HH:~0,1%"==" " (
    set "HH=%HH: =0%"
)
set "NN=%TIME:~3,2%"
set "SS=%TIME:~6,2%"

:: echo [DEBUG] YYYY=%YYYY%, MM=%MM%, DD=%DD%, HH=%HH%, NN=%NN%, SS=%SS%

set "O_DATE=%YYYY%-%MM%-%DD%"
set "O_TIME=%HH%:%NN%:%SS%"
set "O_TIMESTAMP=%O_DATE% %O_TIME%"
set "O_FILE_TIMESTAMP=%O_DATE%_%HH%-%NN%-%SS%"

endlocal & (
  set "ISO_DATE=%O_DATE%"
  set "ISO_TIME=%O_TIME%"
  set "ISO_TIMESTAMP=%O_TIMESTAMP%"
  set "ISO_FILE_TIMESTAMP=%O_FILE_TIMESTAMP%"
)
:: echo [DEBUG] ISO_DATE=%ISO_DATE%
:: echo [DEBUG] ISO_TIME=%ISO_TIME%
:: echo [DEBUG] ISO_TIMESTAMP=%ISO_TIMESTAMP%
:: echo [DEBUG] ISO_FILE_TIMESTAMP=%ISO_FILE_TIMESTAMP%

exit /b 0
