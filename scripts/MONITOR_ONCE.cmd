:: SCRIPT TO MONITOR SERVICES JUST ONCE TIME
::
:: This script only performs ONCE. 
:: To perform it on a schedule, schedule it in the Task Scheduler.
::
@ECHO OFF
TITLE %~nx0
COLOR 0A
::
:: CONFIGURE THESE VARIABLES AS APPROPRIATE
::
:: DISCORDWEBHOOK = link to the Discord webhook where messages are displayed
::
SET DISCORDWEBHOOK=https://discord.com/api/webhooks/blablabla
::
:::::::::::: DO NOT MODIFY ANYTHING BELOW ::::::::::::

:checkServer
FOR /f "tokens=2-4 delims=/ " %%a IN ('date /t') DO (set mydate=%%c%%b%%a)
FOR /f "tokens=1-2 delims=/:" %%a IN ('time /t') DO (set mytime=%%a%%b)

:: 1 - I get the current IP address of the server
powershell.exe -Command "(Invoke-WebRequest -Uri "http://ifconfig.me/ip").Content" -UseBasicParsing > %~nx0.txt

SET /P EXTERNALIP=<%~nx0.txt

CURL -k -s -i -H "Accept: application/json" -H "Content-Type:application/json" -X POST  --data "{\"content\": \"[%mydate% %mytime% %~nx0] ----- %COMPUTERNAME% (%EXTERNALIP%)\"}" %DISCORDWEBHOOK%

:: I'm checking if DAYZ SERVER is working.
TASKLIST | find /i "dayzserver_x64.exe" && CURL -k -s -i -H "Accept: application/json" -H "Content-Type:application/json" -X POST  --data "{\"content\": \"[%mydate% %mytime% %~nx0] ON: dayzserver_x64.exe \"}" %DISCORDWEBHOOK% >NUL
TASKLIST | find /i "dayzserver_x64.exe" || CURL -k -s -i -H "Accept: application/json" -H "Content-Type:application/json" -X POST  --data "{\"content\": \"[%mydate% %mytime% %~nx0] ***OFF: dayzserver_x64.exe \"}" %DISCORDWEBHOOK% >NUL

:: I'm checking if OMEGA MANAGER is working
TASKLIST | find /i "omegamanager.exe" && CURL -k -s -i -H "Accept: application/json" -H "Content-Type:application/json" -X POST  --data "{\"content\": \"[%mydate% %mytime% %~nx0] ON: omegamanager.exe \"}" %DISCORDWEBHOOK% >NUL
TASKLIST | find /i "omegamanager.exe" || CURL -k -s -i -H "Accept: application/json" -H "Content-Type:application/json" -X POST  --data "{\"content\": \"[%mydate% %mytime% %~nx0] ***OFF: omegamanager.exe \"}" %DISCORDWEBHOOK% >NUL

:: I'm checking if EvlWatcher.exe is working
TASKLIST | find /i "EvlWatcher.exe" && CURL -k -s -i -H "Accept: application/json" -H "Content-Type:application/json" -X POST  --data "{\"content\": \"[%mydate% %mytime% %~nx0] ON: EvlWatcher.exe \"}" %DISCORDWEBHOOK% >NUL
TASKLIST | find /i "EvlWatcher.exe" || CURL -k -s -i -H "Accept: application/json" -H "Content-Type:application/json" -X POST  --data "{\"content\": \"[%mydate% %mytime% %~nx0] ***OFF: EvlWatcher.exe \"}" %DISCORDWEBHOOK% >NUL

