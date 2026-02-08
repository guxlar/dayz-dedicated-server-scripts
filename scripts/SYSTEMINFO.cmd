:: BASIC SYSTEM INFORMATION
:: Computer name, public IP address, local time
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
powershell.exe -Command "(Invoke-WebRequest -Uri 'https://www.showmyip.com/' -UseBasicParsing | Select-String -Pattern '\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}' -AllMatches).Matches.Value" > %~nx0.txt

SET /P EXTERNALIP=<%~nx0.txt

:: 2 - Send system info to Discord
CURL -k -s -i -H "Accept: application/json" -H "Content-Type:application/json" -X POST  --data "{\"content\": \"--- %~nx0 \"}" %DISCORDWEBHOOK% >NUL
CURL -k -s -i -H "Accept: application/json" -H "Content-Type:application/json" -X POST  --data "{\"content\": \"--- COMPUTER  : %COMPUTERNAME% \"}" %DISCORDWEBHOOK% >NUL
CURL -k -s -i -H "Accept: application/json" -H "Content-Type:application/json" -X POST  --data "{\"content\": \"--- IP ADDRESS: %EXTERNALIP% \"}" %DISCORDWEBHOOK% >NUL
CURL -k -s -i -H "Accept: application/json" -H "Content-Type:application/json" -X POST  --data "{\"content\": \"--- LOCAL TIME: %mytime%\"}" %DISCORDWEBHOOK% >NUL