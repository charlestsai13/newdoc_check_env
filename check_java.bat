@echo off
REM 以下設定 java 最低版本 與 JRE 安裝檔位置
SET JRE_MINI_VER=180181
SET JRE_FILE=C:\Users\alexw\Downloads\jre-8u181-windows-x64.exe

PATH %PATH%
java >NUL 2>NUL
IF %ERRORLEVEL% NEQ 1 GOTO NOJAVA

FOR /f tokens^=2-5^ delims^=.-_^" %%j IN ('java -fullversion 2^>^&1') DO SET "jver=%%j%%k%%l%%m"
echo 目前版本 %jver%
IF %jver% LSS %JRE_MINI_VER% (
  echo 需求版本 %JRE_MINI_VER%
  echo 安裝新版中請稍後...
  start /w %JRE_FILE% /s REMOVEOUTOFDATEJRES=1
) ELSE (
  echo 不須更新
)
GOTO :eof

:NOJAVA
echo 尚未安裝
echo 新安裝中請稍後...
start /w %JRE_FILE% /s REMOVEOUTOFDATEJRES=1
