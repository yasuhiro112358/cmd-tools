@echo off
setlocal enabledelayedexpansion
chcp 65001 >nul
:: logger.bat
:: 使い方:
::   call logger.bat ログレベル メッセージ
:: 例:
::   call logger.bat INFO "This is an info message."
::   call logger.bat ERROR "This is an error message."
:: ログは tools/logs フォルダに ISO ファイル名で保存される
:: 例: tools/logs/2024-06-12_14-30-00.log
:: ログレベルは任意の文字列を指定可能 (例: INFO, ERROR, DEBUG)
:: メッセージにスペースを含む場合は引用符で囲むことを推奨
:: 内部で timeutil.bat を使用して ISO タイムスタンプを生成
::

call timeutil.bat :make_iso_timestamp
:: ISO_DATE=YYYY-MM-DD
:: ISO_TIME=HH:MM:SS
:: ISO_TIMESTAMP=YYYY-MM-DD HH:MM:SS
:: ISO_FILE_TIMESTAMP=YYYY-MM-DD_HH-MM-SS

set "LINE=[%ISO_TIMESTAMP%] [%~1] %~2"
echo %LINE%

echo %LINE%>>"%~dp0\logs\%ISO_DATE%.log"

exit /b 0

endlocal