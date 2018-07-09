@echo off

REM == �H�U�T���ɮ׽г]�w�b�@�θ�Ƨ��W ex:\\nas\share\newdoc\kdapp.jnlp ==
SET chkHicos=\\nas\share\newdoc\checkHicos.ps1
SET fileJavaCert=\\nas\share\newdoc\trusted.jssecerts
SET fileKdapp=\\nas\share\newdoc\kdapp.jnlp

REM ==============================================================
SET javaExpSites=%userprofile%\AppData\LocalLow\Sun\Java\Deployment\security\exception.sites
SET javaCert=%userprofile%\AppData\LocalLow\Sun\Java\Deployment\security\trusted.jssecerts
SET javaCache=%userprofile%\AppData\LocalLow\Sun\Java\Deployment\deployment.properties
SET vbsc=%TEMP%\mklnk.vbs
SET desktopLink=%USERPROFILE%\Desktop\�s���夸��.lnk
REM SET kdappStartup=%appdata%\Microsoft\Windows\Start Menu\Programs\Startup\kdapp.jnlp

:check64
SET x86dir=%ProgramFiles(x86)%
IF NOT "%x86dir%"=="" GOTO win64
SET x86dir=%ProgramFiles%
:win64

:checkHicos
powershell.exe -noprofile -executionpolicy bypass -file %chkHicos%

:checkJavaInit
IF NOT EXIST %userprofile%\AppData\LocalLow\Sun "%x86dir%\Common Files\Java\Java Update\jucheck.exe"

:checkJavaExpSites
IF NOT EXIST %javaExpSites% fsutil file createnew %javaExpSites% 0  
IF EXIST %javaExpSites% GOTO foundExp  
  
:foundExp
FOR %%G IN (  
 https://doctest.gov.taipei 
 https://doc.gov.taipei 
 https://edoc.gov.taipei 
 ) DO (CALL :checkExpLine %%G)  
GOTO :checkCert
  
:checkExpLine  
find "%1" %javaExpSites% || echo %1 >> %javaExpSites%  
GOTO :eof
 
:checkCert
IF NOT EXIST %javaCert% copy %fileJavaCert% %javaCert%

:checkJavaCache
IF EXIST %javaCache% find "deployment.cache.enabled=true" %javaCache% || echo deployment.cache.enabled=true >> %javaCache% 

:checkLink
IF EXIST %desktopLink% GOTO :startKdapp

:makeLink
echo Set oWS = WScript.CreateObject("WScript.Shell") >> %vbsc%
echo sLinkFile = "%desktopLink%" >> %vbsc%
echo Set oLink = oWS.CreateShortcut(sLinkFile) >> %vbsc%
echo oLink.TargetPath = "%fileKdapp%" >> %vbsc%
echo oLink.Save >> %vbsc%
cscript /nologo %vbsc%
del %vbsc%

:startKdapp
timeout /t 15
javaws.exe %fileKdapp%
