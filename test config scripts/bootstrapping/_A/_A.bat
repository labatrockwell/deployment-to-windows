setlocal enableextensions
cd /d "%~dp0"
REM <--this is how you "comment out"

REM everything should have been copied to the downloads directory
REM set pwd=C:\Users\%username%\Downloads\_A
REM echo %pwd%

REM set powershell permission level
powershell set-executionpolicy unrestricted

REM create lab account if it does not exist
REM and set password
REM and set up auto-boot
REM and set to skip intro video
powershell ./01_0_userExists.ps1

REM run SkipMetroSuite
REM so we can auto-boot to desktop (and turn off charms bar)
02_0_SkipMetroSuite\x64\SkipMetroSuiteUI
REM *** REMOVE THE USB DRIVE AS SOON AS THE COMPUTER SHUTS OFF ***
REM **************************************************************
pause

REM restart computer
shutdown /r /t 00
