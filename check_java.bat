@echo off
REM �H�U�]�w java �̧C���� �P JRE �w���ɦ�m
SET JRE_MINI_VER=180181
SET JRE_FILE=C:\Users\alexw\Downloads\jre-8u181-windows-x64.exe

PATH %PATH%
java >NUL 2>NUL
IF %ERRORLEVEL% NEQ 1 GOTO NOJAVA

FOR /f tokens^=2-5^ delims^=.-_^" %%j IN ('java -fullversion 2^>^&1') DO SET "jver=%%j%%k%%l%%m"
echo �ثe���� %jver%
IF %jver% LSS %JRE_MINI_VER% (
  echo �ݨD���� %JRE_MINI_VER%
  echo �w�˷s�����еy��...
  start /w %JRE_FILE% /s REMOVEOUTOFDATEJRES=1
) ELSE (
  echo ������s
)
GOTO :eof

:NOJAVA
echo �|���w��
echo �s�w�ˤ��еy��...
start /w %JRE_FILE% /s REMOVEOUTOFDATEJRES=1
