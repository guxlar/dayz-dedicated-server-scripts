:: DAYZ SERVER BACKUP SCRIPT
:: PART 1 - COPY SERVER CONFIGURATION
:: PART 2 - COPY SERVER PROFILES
:: PART 3 - COPY MPMISSIONS
@ECHO OFF
TITLE %~nx0
COLOR 0A
::
:: CONFIGURE THESE VARIABLES AS APPROPRIATE
::
:: DISCORDWEBHOOK = Link to Discord webhook
:: SERVERFOLDER = Folder of the server to be backed up
:: BACKUPFOLDERS = Folder where backups are saved
:: LOGFOLDERS = Folder for process logs
:: LOGFILENAME = File name for the process log
:: SERVERPROFILES = Folder for server profiles
::
SET DISCORDWEBHOOK=https://discord.com/api/webhooks/blablabla
SET CARPETASERVIDOR=C:\Users\Administrator\Desktop\OmegaManager\servers\Chernarus
SET CARPETABAK=D:\BACKUPS-SERVER-CHERNARUS
SET CARPETALOG=D:\LOGS\BACKUPS-SERVER-CHERNARUS
SET LOGFILENAME=%CARPETALOG%\LOG-backup-servidor
SET SERVERPROFILES=profiles
::
:::::::::::: DO NOT MODIFY ANYTHING BELOW THIS LINE ::::::::::::

CLS
SETLOCAL enabledelayedexpansion
FOR /F %%a IN ('POWERSHELL -COMMAND "$([guid]::NewGuid().ToString().Trim())"') DO ( SET uniqueid=%%a )
SET uniqueid=%uniqueid: =%
SET logFile="%LOGFILENAME%_%uniqueid%.log"
IF NOT EXIST "%CARPETALOG%" MKDIR "%CARPETALOG%"

SET backupServer=%CARPETABAK%\BAK_%uniqueid%
IF NOT EXIST "%backupServer%" MKDIR "%backupServer%"

ECHO ***Script configuration
ECHO uniqueid: [%uniqueid%]
ECHO Server to back up: %CARPETASERVIDOR%
ECHO Backup folder: %backupServer%
ECHO Process logs: %CARPETALOG%
ECHO logFile=%logFile%
ECHO ***
ECHO *** THE DAYZ SERVER MUST BE STOPPED ***

CURL -k -s -i -H "Accept: application/json" -H "Content-Type:application/json" -X POST  --data "{\"content\": \"[%~nx0] Starting backup... \"}" %DISCORDWEBHOOK% >NUL

:: I'm enabling the backup process log
ECHO %~nx0 > %logFile%
ECHO logFile% >> %logFile%
date /t >> %logFile%
time /t >> %logFile%
ECHO Server: %COMPUTERNAME% >> %logFile%
ECHO User: %USERNAME% >> %logFile%
ECHO [INFO]CARPETASERVIDOR=%CARPETASERVIDOR% >> %logFile%
ECHO [INFO]BACKUPSERVER=%backupServer% >> %logFile%
ECHO [INFO]CARPETALOG=%CARPETALOG% >> %logFile%
ECHO [INFO]logFile=%logFile% >> %logFile%

:: PART 1 - COPY SERVER CONFIGURATION
ECHO [INFO]xcopy1 files from %CARPETASERVIDOR% to %backupServer% >> %logFile%
COPY /y "%CARPETASERVIDOR%\*.*" "%backupServer%"
IF %ERRORLEVEL% EQU 0 (ECHO [INFO]OK >> %logFile%) ELSE (ECHO [ERROR]xcopy 1 >> %logFile%)

CURL -k -s -i -H "Accept: application/json" -H "Content-Type:application/json" -X POST  --data "{\"content\": \"[%~nx0] Part 1 of 3.  \"}" %DISCORDWEBHOOK% >NUL

:: PART 2 - COPY SERVER PROFILES
ECHO [INFO]xcopy2 %CARPETASERVIDOR%\%SERVERPROFILES% to %backupServer%\%SERVERPROFILES% >> %logFile%
XCOPY /s /e /y /j /q "%CARPETASERVIDOR%\%SERVERPROFILES%" "%backupServer%\%SERVERPROFILES%\" 
IF %ERRORLEVEL% EQU 0 (ECHO [INFO]OK >> %logFile%) ELSE (ECHO [ERROR]xcopy 2 >> %logFile%)

CURL -k -s -i -H "Accept: application/json" -H "Content-Type:application/json" -X POST  --data "{\"content\": \"[%~nx0] Part 2 of 3.  \"}" %DISCORDWEBHOOK% >NUL

:: PART 3 - COPY MPMISSIONS
ECHO [INFO]xcopy3 %CARPETASERVIDOR%\mpmissions to %backupServer%\mpmissions >> %logFile%
XCOPY /s /e /y /j /q "%CARPETASERVIDOR%\mpmissions" "%backupServer%\mpmissions\"
IF %ERRORLEVEL% EQU 0 (ECHO [INFO]OK >> %logFile%) ELSE (ECHO [ERROR]xcopy 3 >> %logFile%)

CURL -k -s -i -H "Accept: application/json" -H "Content-Type:application/json" -X POST  --data "{\"content\": \"[%~nx0] Part 3 of 3.  \"}" %DISCORDWEBHOOK% >NUL

CURL -k -s -i -H "Accept: application/json" -H "Content-Type:application/json" -X POST  --data "{\"content\": \"[%~nx0] Backup complete. \"}" %DISCORDWEBHOOK% >NUL

:END
ECHO [INFO]***END OF SCRIPT*** >> %logFile%
ECHO [INFO]logFile% >> %logFile%

