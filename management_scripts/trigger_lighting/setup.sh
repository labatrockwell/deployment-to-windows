#!/usr/bin/env bash
#ensure script dir exists
pssh -h clients_FramesServer.txt -o out_dir -e err_dir mkdir -p /cygdrive/c/Users/CD004931/Downloads/scripts
#copy script over
pscp -h clients_FramesServer.txt -o out_dir -e err_dir -r trigger_lighting /cygdrive/c/Users/CD004931/Downloads/scripts/
#set up stuff'm
#pssh -h clients_FramesServer.txt -o out_dir -e err_dir powershell C:\\\\Users\\\\CD004724\\\\Downloads\\\\scripts\\\\trigger_lighting\\\\setup.ps1
