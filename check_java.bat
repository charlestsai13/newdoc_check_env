@echo off
REM === �H�U�]�w java �̧C���� �P JRE �w���ɦ�m ===
SET JRE_MINI_VER=180181
SET JRE_FILE=\\nas\share\newdoc\jre-8u181-windows-x64.exe

PATH %PATH%;%JAVA_HOME%\bin\
FOR /f tokens^=2-5^ delims^=.-_^" %%j IN ('java -fullversion 2^>^&1') DO SET "jver=%%j%%k%%l%%m"
REM ���w�˷|�X�� ���ܿ��~�B�z
IF %ERRORLEVEL% NEQ 0 GOTO ProcessError

REM ���X�� �~����ժ���
IF NOT DEFINED jver (
  echo ���w��
  echo �w�ˤ��еy��...
  start /w %JRE_FILE% /s REMOVEOUTOFDATEJRES=1
) else (
  echo �ثe���� %jver%
  IF %jver% LSS %JRE_MINI_VER% (
    echo �w�˷s�����еy��...
    start /w %JRE_FILE% /s REMOVEOUTOFDATEJRES=1
  )
)
exit /b 0

:ProcessError
REM ���~�B�z
echo �䤣��w��
echo �s�w�ˤ��еy��...
  start /w %JRE_FILE% /s REMOVEOUTOFDATEJRES=1
exit /b 1
