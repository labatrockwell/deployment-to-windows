#!/usr/bin/env bash
prsync -ra -h clients.txt -o out_dir -e err_dir test_rsync/test_rsync.txt /cygdrive/c/Users/lab/Downloads/
pssh -h clients.txt -o out_dir_2 -e err_dir_2 cat /cygdrive/c/Users/lab/Downloads/test_rsync.txt