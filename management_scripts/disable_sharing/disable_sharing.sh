echo "####  Copy Over Script"
pscp -r -h clients.txt -o out_dir -e err_dir disable_sharing /cygdrive/c/Users/lab/Downloads/scripts/
echo "####  Running"
pssh -h clients.txt -o out_dir_2 -e err_dir_2 'runas /user:administrator /savecred "powershell C:\\Users\\lab\\Downloads\\scripts\\disable_sharing\\disable_sharing.ps1"'