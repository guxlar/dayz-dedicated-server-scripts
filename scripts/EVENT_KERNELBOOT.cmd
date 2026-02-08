:: KERNEL BOOT IN THE EVENT VIEWER
:: Attach this script to the Event Viewer event
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
powershell.exe -Command "(Invoke-WebRequest -Uri 'https://www.showmyip.com/' | Select-String -Pattern '\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}' -AllMatches).Matches.Value" > %~nx0.txt

SET /P EXTERNALIP=<%~nx0.txt

:: 2 - Send message to discord
CURL -k -s -i -H "Accept: application/json" -H "Content-Type:application/json" -X POST  --data "{\"content\": \"[%mydate% %mytime% %~nx0] Kernel boot. \"}" %DISCORDWEBHOOK% >NUL
