rm -rf sync_time/results
rm -rf sync_time/errors
echo '#### Getting Times'
pssh -p 100 -h clients_TabletClient.txt -h clients_StructureClient.txt -o sync_time/results -e sync_time/errors -t 10 'date +%s%N'
echo '#### Compiling'
MIN=0
MAX=0
SUM=0
NUM=0
for F in sync_time/results/*
	do
	A=`cat $F`
	if [ $A ]
		then
		if [ $MIN -eq 0 ]
			then
			MIN=$A
		fi

		if [ $MIN -gt $A ]
			then
			MIN=$A
		elif [ $MAX -lt $A ]
			then
			MAX=$A
		fi

		if [ $NUM -eq 0 ]
			then
			SUM=$A
		else
			#a somewhat complicated accumulating average to avoid overflow
			TMP=`expr $A / $NUM`
			SUM=`expr $SUM + $TMP`
			NXT=`expr $NUM + 1`
			SUM=`expr $SUM / $NXT`
			SUM=`expr $SUM \* $NUM`
		fi
		NUM=`expr $NUM + 1`
	fi
done
echo '#### results in nanoseconds'
echo max: $MAX
echo min: $MIN
printf "diff: %'d\n" `expr $MAX - $MIN`
echo num: $NUM
#AVG=`expr $SUM / $NUM`
AVG=$SUM
echo avg: $AVG
printf "diff: %'d / %'d\n" `expr $MAX - $AVG` `expr $AVG - $MIN`
# echo '####  Copying'
# pscp -r -p 100 -h clients.txt -o out_dir -e err_dir sync_time /cygdrive/c/Users/lab/Downloads/scripts/
# echo '####  Checking Time'
# pssh -h clients_TabletClient.txt -h clients_StructureClient.txt 'runas /user:administrator /savecred "C:\\Users\\lab\\Downloads\\scripts\\sync_time\\check_time.bat"'
# pssh -h clients_TabletClient.txt -h clients_StructureClient.txt -o sync_time/results -e sync_time/errors