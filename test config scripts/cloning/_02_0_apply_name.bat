setlocal enableextensions
cd /d "%~dp0"
REM <--this is how you "comment out"

REM set powershell permission level
powershell set-executionpolicy unrestricted

powershell ./_02_1_apply_name.ps1
