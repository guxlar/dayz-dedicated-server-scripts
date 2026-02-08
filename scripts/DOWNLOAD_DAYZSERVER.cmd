:: DAYZ SERVER DOWNLOADER
:: Requirement: SteamCMD installed.
:: Requirement: Steam user and password.
@echo off

:: CONFIGURATION - MODIFY

:: steamCmdFolder = folder where the steamcmd.exe program is installed
SET steamCmdFolder=D:\steamCmd

:: downloadFolder = folder where to download the server
SET downloadFolder=D:\DOWNLOADED-dayzserver

::::::::::::DO NOT MODIFY ANYTHING BELOW ::::::::::::

CLS
ECHO ***SCRIPT TO DOWNLOAD THE DAYZ STEAM SERVER
ECHO ***You need to connect to Steam with a username and password that you used to purchase DayZ !
SET /p steamLoginName=Steam username?:
SET /p steamPassword=Steam password?:

CLS

IF NOT EXIST %downloadFolder% MKDIR %downloadFolder%

ECHO ***SCRIPT CONFIGURATION:
ECHO Folder where steamcmd.exe is already installed: %steamCmdFolder%
ECHO Folder where to save the Dayz Server: %downloadFolder%
ECHO ***
SET /P AREYOUSURE=Ready to execute, are you sure (Y/[N])?
IF "%AREYOUSURE%" NEQ "Y" GOTO END2

:: GENERATE A UNIQUE ID
setlocal enabledelayedexpansion
FOR /F %%a IN ('POWERSHELL -COMMAND "$([guid]::NewGuid().ToString())"') DO ( SET uniqueid=%%a )
echo %uniqueid%

:: DOWNLOAD DAYZ STEAM SERVER
%steamCmdFolder%\steamcmd.exe +force_install_dir %downloadFolder%\dayzserver_%uniqueid%  +login %steamLoginName% %steamPassword% +app_update 223350 validate +quit

:END1
ECHO ***
ECHO ***DAYZ SERVER DOWNLOADED IN THE FOLDER:
ECHO %downloadFolder%\dayzserver_%uniqueid%

:END2
ECHO ***END OF SCRIPT
PAUSE
