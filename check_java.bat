@echo off
REM 以下設定 java 最低版本 與 JRE 安裝檔位置
SET JRE_MINI_VER=180181
SET JRE_FILE=\\nas\share\nowdoc\jre-8u181-windows-x64.exe

PATH %PATH%;%JAVA_HOME%\bin\
for /f tokens^=2-5^ delims^=.-_^" %%j in ('java -fullversion 2^>^&1') do set "jver=%%j%%k%%l%%m"

if not defined jver (
 echo 尚未安裝 JAVA
 echo 安裝中請稍後...
 start /w %JRE_FILE% /s REMOVEOUTOFDATEJRES=1
) else (
 echo 目前版本 %jver%
 if %jver% LSS %JRE_MINI_VER% (
  echo 新版本安裝中請稍後...
  start /w %JRE_FILE% /s REMOVEOUTOFDATEJRES=1
  )
)
