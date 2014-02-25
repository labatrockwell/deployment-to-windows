echo '####  Copying'
pscp -r -p 100 -h clients_TabletClient.txt -h clients_StructureClient.txt -o out_dir -e err_dir sync_time /cygdrive/c/Users/lab/Downloads/scripts/
echo '####  Resetting Time'
pssh -h clients_TabletClient.txt -h clients_StructureClient.txt 'runas /user:administrator /savecred "C:\\Users\\lab\\Downloads\\scripts\\sync_time\\reset_time.bat"'