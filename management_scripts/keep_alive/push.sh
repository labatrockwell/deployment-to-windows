#!/usr/bin/env bash
#constants
VALID_APPS=("FramesServer" "TabletClient" "StructureClient" "SpotlightClient" "SpotlightServer" "LeviathanClient" "LeviathanServer" "StructureWifi")
COMMAND=keep_alive/push
##get the directory that the script is located
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

DID_ONE=false
while test $# -gt 0
	do
	VALID=false
	DID_ONE=true
	APP=$1
	shift
	for VALID_APP in ${VALID_APPS[*]}
		do
		if [ $APP == $VALID_APP ]
			then
			VALID=true
		fi
	done

	if [ $VALID == false ]
		then
		echo "Unrecognised argument: $APP"
		echo "\"./${COMMAND}.sh\" for usage info"
	else
		echo "Valid!"
		USER="lab"
		EXE=$APP
		if [ $APP == "StructureWifi" ]
			then
			EXE="StructureClient"
		fi
		#remove 'Server' from end of string
		REMAINDER=${APP%Server}
		if [ ${#REMAINDER} -ne ${#APP} ]
			then
			echo "Server app!"
			USER="CD004931"
		fi
		###############
		#### HERE IS THE ACTUAL COMMAND
		###############
		if [ $USER != "lab" ]
			then
			echo 'does not support server computers'
		else
			echo '**********************'
			echo '***** ensuring script directory exists'
			echo '**********************'
			pssh -p 100 -h clients_${EXE}.txt -o out_dir -e err_dir -I < createScriptDir.txt
			echo '**********************'
			echo '***** copying over keep_alive directory'
			echo '**********************'
			pscp -r -p 100 -h clients_${EXE}.txt -o out_dir -e err_dir keep_alive /cygdrive/c/Users/lab/Downloads/scripts/
		fi
		###############
		###############
	fi
done

if [ $DID_ONE == false ]
	then
	echo "command format: ./${COMMAND}.sh [APP_NAME](, [APP_NAME])*"
	echo "supported app names: ${VALID_APPS[*]}"
fi