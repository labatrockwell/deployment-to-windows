#!/usr/bin/env bash
echo '**********************'
echo '***** ensuring script directory exists'
echo '**********************'
./runpssh.sh < createScriptDir.txt
echo '**********************'
echo '***** copying over changeip directory'
echo '**********************'
pscp -r -p 100 -h clients.txt -o out_dir -e err_dir changeip /cygdrive/c/Users/lab/Downloads/scripts/
echo '**********************'
echo '***** running change ip powershell'
echo '**********************'
#http://stackoverflow.com/questions/4090301/root-user-sudo-equivalent-in-cygwin
#./runas-admin.bat "powershell C:\Users\lab\Downloads\scripts\changeip\changeip.ps1"
#
#http://stackoverflow.com/questions/10811209/how-to-supply-password-to-runas-command-when-executing-it-from-java
#runas /user:Administrator "powershell C:\Users\lab\Downloads\scripts\changeip\changeip.ps1"
pssh -h clients.txt -o out_dir -e err_dir 'runas /user:administrator /savecred "powershell C:\\Users\\lab\\Downloads\\scripts\\changeip\\changeip.ps1"'