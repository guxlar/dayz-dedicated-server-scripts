:: SCRIPT TO MONITOR SERVICES

@ECHO OFF
TITLE %~nx0
COLOR 0A
::
:: CONFIGURE THESE VARIABLES AS APPROPRIATE
::
:: WAITINSECONDS = time in seconds between each measurement
:: DISCORDWEBHOOK = link to the Discord webhook where messages are displayed
::
SET ESPERAENSEGUNDOS=60
SET DISCORDWEBHOOK=https://discord.com/api/webhooks/blablabla
::
:::::::::::: DO NOT MODIFY ANYTHING BELOW ::::::::::::

CLS

:: MONITORING SERVER STATUS
:checkServer
FOR /f "tokens=2-4 delims=/ " %%a IN ('date /t') DO (set mydate=%%c%%b%%a)
FOR /f "tokens=1-2 delims=/:" %%a IN ('time /t') DO (set mytime=%%a%%b)

:: 1 - Get the server's current IP address.
powershell.exe -Command "(Invoke-WebRequest -Uri "http://ifconfig.me/ip").Content" > monitor-ip.txt

SET /P EXTERNALIP=<monitor-ip.txt
CURL -s -i -H "Accept: application/json" -H "Content-Type:application/json" -X POST  --data "{\"content\": \"[%mydate% %mytime% - %~nx0] ---SERVER: %COMPUTERNAME% (%EXTERNALIP%)\"}" %DISCORDWEBHOOK% >NUL
ECHO [%mydate% %mytime% - %~nx0] SERVER: %COMPUTERNAME% (%EXTERNALIP%)

:: I'm checking if DayZServer_x64.exe is working
ECHO [%mydate% %mytime% - %~nx0] Monitoreando: DayZServer_x64.exe
 
TASKLIST | find /i "DayZServer_x64.exe" && CURL -s -i -H "Accept: application/json" -H "Content-Type:application/json" -X POST  --data "{\"content\": \"[%mydate% %mytime% - %~nx0] ON: DayZServer_x64.exe\"}" %DISCORDWEBHOOK% >NUL
TASKLIST | find /i "DayZServer_x64.exe" || CURL -s -i -H "Accept: application/json" -H "Content-Type:application/json" -X POST  --data "{\"content\": \"[%mydate% %mytime% - %~nx0] ***OFF: DayZServer_x64.exe\"}" %DISCORDWEBHOOK% >NUL

:: I'm checking if OmegaManager.exe is working.
ECHO [%mydate% %mytime% - %~nx0] Monitoreando: OmegaManager.exe

TASKLIST | find /i "OmegaManager.exe" && CURL -s -i -H "Accept: application/json" -H "Content-Type:application/json" -X POST  --data "{\"content\": \"[%mydate% %mytime% - %~nx0] ON: OmegaManager.exe\"}" %DISCORDWEBHOOK% >NUL
TASKLIST | find /i "OmegaManager.exe" || CURL -s -i -H "Accept: application/json" -H "Content-Type:application/json" -X POST  --data "{\"content\": \"[%mydate% %mytime% - %~nx0] ***OFF: OmegaManager.exe\"}" %DISCORDWEBHOOK% >NUL

:: I'm checking if EVLWATCHER is working.
ECHO [%mydate% %mytime% - %~nx0] Monitoreando: EvlWatcher.exe

TASKLIST | find /i "EvlWatcher.exe" && CURL -s -i -H "Accept: application/json" -H "Content-Type:application/json" -X POST  --data "{\"content\": \"[%mydate% %mytime% - %~nx0] ON: EvlWatcher.exe\"}" %DISCORDWEBHOOK% >NUL
TASKLIST | find /i "EvlWatcher.exe" || CURL -s -i -H "Accept: application/json" -H "Content-Type:application/json" -X POST  --data "{\"content\": \"[%mydate% %mytime% - %~nx0] ***OFF: EvlWatcher.exe\"}" %DISCORDWEBHOOK% >NUL

:: I'm checking if ParkControl.exe is working.
ECHO [%mydate% %mytime% - %~nx0] Monitoreando: ParkControl.exe

TASKLIST | find /i "ParkControl.exe" && CURL -s -i -H "Accept: application/json" -H "Content-Type:application/json" -X POST  --data "{\"content\": \"[%mydate% %mytime% - %~nx0] ON: ParkControl.exe\"}" %DISCORDWEBHOOK% >NUL
TASKLIST | find /i "ParkControl.exe" || CURL -s -i -H "Accept: application/json" -H "Content-Type:application/json" -X POST  --data "{\"content\": \"[%mydate% %mytime% - %~nx0] ***OFF: ParkControl.exe\"}" %DISCORDWEBHOOK% >NUL

:: I wait a few seconds and try again
CURL -s -i -H "Accept: application/json" -H "Content-Type:application/json" -X POST  --data "{\"content\": \"[%mydate% %mytime% - %~nx0] ---Esperando %ESPERAENSEGUNDOS% segundos...\"}" %DISCORDWEBHOOK% >NUL
ECHO [%mydate% %mytime% - %~nx0] Next check in %ESPERAENSEGUNDOS% seconds - %COMPUTERNAME% (%EXTERNALIP%)

TIMEOUT %ESPERAENSEGUNDOS%
GOTO checkServer
