#!/usr/bin/env bash
echo '**********************'
echo '***** ensuring script directory exists'
echo '**********************'
pssh -h clients.txt -o out_dir -e err_dir -I < createScriptDir.txt
echo '**********************'
echo '***** copying over setup_rsync directory'
echo '**********************'
pscp -r -p 100 -h clients.txt -o out_dir -e err_dir setup_rsync /cygdrive/c/Users/lab/Downloads/scripts/
echo '**********************'
echo '***** running install'
echo '**********************'
pssh -p 100 -h clients.txt -o out_dir -e err_dir 'runas /user:administrator /savecred "C:\\Users\\lab\\Downloads\\scripts\\setup_rsync\\cygwin-setup-x86_64.exe -q -L -l C:\\Users\\lab\\Downloads\\scripts\\setup_rsync\\cygwin_files\\ -P rsync"'