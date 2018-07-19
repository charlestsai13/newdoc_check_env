@echo off
REM === 以下設定 java 最低版本 與 JRE 安裝檔位置 ===
SET JRE_MINI_VER=180181
SET JRE_FILE=\\nas\share\newdoc\jre-8u181-windows-x64.exe

PATH %PATH%;%JAVA_HOME%\bin\
FOR /f tokens^=2-5^ delims^=.-_^" %%j IN ('java -fullversion 2^>^&1') DO SET "jver=%%j%%k%%l%%m"
REM 未安裝會出錯 跳至錯誤處理
IF %ERRORLEVEL% NEQ 0 GOTO ProcessError

REM 未出錯 繼續測試版本
IF NOT DEFINED jver (
  echo 未安裝
  echo 安裝中請稍後...
  start /w %JRE_FILE% /s REMOVEOUTOFDATEJRES=1
) else (
  echo 目前版本 %jver%
  IF %jver% LSS %JRE_MINI_VER% (
    echo 安裝新版中請稍後...
    start /w %JRE_FILE% /s REMOVEOUTOFDATEJRES=1
  )
)
exit /b 0

:ProcessError
REM 錯誤處理
echo 找不到安裝
echo 新安裝中請稍後...
  start /w %JRE_FILE% /s REMOVEOUTOFDATEJRES=1
exit /b 1
