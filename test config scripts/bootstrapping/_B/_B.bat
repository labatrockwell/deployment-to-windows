setlocal enableextensions
cd /d "%~dp0"
set pwd=%~dp0
REM <--this is how you "comment out"

REM everything should have been copied to the downloads directory
REM set pwd=C:\Users\%username%\Downloads\_B
REM echo %pwd%

REM set powershell permission level
powershell set-executionpolicy unrestricted

REM run decrapifier
01_0_pc-decrapifier-2.3.1
pause


REM disable windows firewall
REM set screen to full brightness
REM disable computer/screen sleep

REM install python
msiexec /qn /i 05_0_python-3.3.2.amd64.msi

REM install cygwin
06_0_cygwin-setup-x86_64.exe -q -L -l %pwd%06_0_cygwin_files\ -P expect,tcl,cygrunsrv,heimdal,libedit,libidn,libmetalink,libssh2,libtasn1,openldap,p11-kit,sqlite3,tcp_wrappers,wget,csih,ca-certificates,shutdown,zip,unzip,vim,nano,curl,less,openssh,openssl

REM launch cygwin first time to set up stuff
start C:\cygwin64\Cygwin.bat
REM wait 10 seconds (common hack using ping to self with 1s between pings)
ping 127.0.0.1 -n 11 > null
taskkill /im bash.exe /f

REM prepare for sshd setup
C:\cygwin64\bin\mkgroup -l > C:\cygwin64\etc\group
C:\cygwin64\bin\mkpasswd -l > C:\cygwin64\etc\passwd
set PATH=C:\cygwin64\bin;%PATH%

REM and then run sshd setup
C:\cygwin64\bin\expect 07_0_sshd_setup.sh

REM and then replace sshd_config with our version (to \etc\sshd_config)
copy /Y 08_0_sshd_config C:\cygwin64\etc\sshd_config

REM and set up sshd on boot (some file to startup directory, and some bash script)
copy /Y 09_0_cygwin_sshd.cmd "C:\Users\lab\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\cygwin_sshd.cmd"
mkdir C:\cygwin64\home\lab\bin
copy /Y 10_0_start_sshd.sh C:\cygwin64\home\lab\bin\start_sshd.sh
REM *** REMOVE THE USB DRIVE AS SOON AS THE COMPUTER SHUTS OFF ***
REM **************************************************************
pause

REM restart computer
shutdown /r /t 00
