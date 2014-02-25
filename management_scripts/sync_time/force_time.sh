#set everyone to the same timezone
pssh -p 100 -h clients_StructureClient.txt -h clients_TabletClient.txt -h clients_FramesServer.txt "tzutil /s \"Pacific Standard Time\""
#copy script dir out
pscp -r -p 100 -h clients_TabletClient.txt -h clients_StructureClient.txt sync_time /cygdrive/c/Users/lab/Downloads/scripts/
pscp -r -p 100 -h clients_FramesServer.txt sync_time /cygdrive/c/Users/CD004724/Downloads/scripts/
#get time and date from server
ssh intel-server2 "/cygdrive/c/Users/CD004724/Downloads/scripts/sync_time/force_time_get.bat"
TIME=`ssh intel-server2 cat /cygdrive/c/Users/CD004724/Downloads/scripts/sync_time/curr_time.txt`
DATE=`ssh intel-server2 cat /cygdrive/c/Users/CD004724/Downloads/scripts/sync_time/curr_date.txt`
###### returns in DAY MM/DD/YYYY, but we need MM-DD-YY :(
DATE=12-12-13
#set time and date on clients
pssh -p 100 -h clients_StructureClient.txt -h clients_TabletClient.txt "echo -n $TIME > /cygdrive/c/Users/lab/Downloads/scripts/sync_time/curr_time.txt"
pssh -p 100 -h clients_StructureClient.txt -h clients_TabletClient.txt "echo -n $DATE > /cygdrive/c/Users/lab/Downloads/scripts/sync_time/curr_date.txt"
pssh -p 100 -h clients_StructureClient.txt -h clients_TabletClient.txt -o out_dir -e err_dir 'runas /user:administrator /savecred "cmd /c C:\\Users\\lab\\Downloads\\scripts\\sync_time\\force_time_set.bat"'