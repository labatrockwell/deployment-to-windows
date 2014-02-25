setlocal enableextensions
cd /d "%~dp0"
REM <--this is how you "comment out"

REM set powershell permission level
powershell set-executionpolicy unrestricted

powershell ./_00_1_set_name.ps1
