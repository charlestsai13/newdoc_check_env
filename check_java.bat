@echo off
REM �H�U�]�w java �̧C���� �P JRE �w���ɦ�m
SET JRE_MINI_VER=180181
SET JRE_FILE=\\nas\share\nowdoc\jre-8u181-windows-x64.exe

PATH %PATH%;%JAVA_HOME%\bin\
for /f tokens^=2-5^ delims^=.-_^" %%j in ('java -fullversion 2^>^&1') do set "jver=%%j%%k%%l%%m"

if not defined jver (
 echo �|���w�� JAVA
 echo �w�ˤ��еy��...
 start /w %JRE_FILE% /s REMOVEOUTOFDATEJRES=1
) else (
 echo �ثe���� %jver%
 if %jver% LSS %JRE_MINI_VER% (
  echo �s�����w�ˤ��еy��...
  start /w %JRE_FILE% /s REMOVEOUTOFDATEJRES=1
  )
)
