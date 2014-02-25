setlocal enableextensions
cd /d "%~dp0"
REM <--this is how you "comment out"

REM set powershell permission level
powershell set-executionpolicy unrestricted

powershell ./_01_1_link_name.ps1
