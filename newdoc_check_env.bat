@echo off

REM == 以下三個檔案請設定在共用資料夾上 ex:\\nas\share\newdoc\kdapp.jnlp ==
SET chkHicos=\\nas\share\newdoc\checkHicos.ps1
SET fileJavaCert=\\nas\share\newdoc\trusted.jssecerts
SET fileKdapp=\\nas\share\newdoc\kdapp.jnlp

REM ==============================================================
SET javaExpSites=%userprofile%\AppData\LocalLow\Sun\Java\Deployment\security\exception.sites
SET javaCert=%userprofile%\AppData\LocalLow\Sun\Java\Deployment\security\trusted.jssecerts
SET javaCache=%userprofile%\AppData\LocalLow\Sun\Java\Deployment\deployment.properties
SET kdappStartup=%appdata%\Microsoft\Windows\Start Menu\Programs\Startup\kdapp.jnlp

:checkHicos
powershell.exe -noprofile -executionpolicy bypass -file %chkHicos%

:checkJavaExpSites
IF NOT EXIST %javaExpSites% fsutil file createnew %javaExpSites% 0  
IF EXIST %javaExpSites% GOTO foundExp  
GOTO :CheckCert
  
:foundExp
FOR %%G IN (  
 https://doctest.gov.taipei 
 https://doc.gov.taipei 
 https://edoc.gov.taipei 
 ) DO (CALL :checkExpLine %%G)  
GOTO :CheckCert
  
:checkExpLine  
find "%1" %javaExpSites% || echo %1 >> %javaExpSites%  
GOTO :eof
 
:CheckCert
IF NOT EXIST %javaCert% copy %fileJavaCert% %javaCert%

:CheckJavaCache
IF EXIST %javaCache% find "deployment.cache.enabled=true" %javaCache% || echo deployment.cache.enabled=true >> %javaCache% 

:CheckKdapp
IF NOT EXIST "%kdappStartup%" copy "%fileKdapp%" "%kdappStartup%"
