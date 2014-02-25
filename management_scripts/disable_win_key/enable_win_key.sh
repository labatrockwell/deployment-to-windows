#!/usr/bin/env bash
#constants
VALID_EXES=("FramesServer" "TabletClient" "StructureClient" "SpotlightClient" "SpotlightServer" "LeviathanClient" "LeviathanServer")
COMMAND=disable_win_key/enable_win_key
##get the directory that the script is located
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

DID_ONE=false
while test $# -gt 0
	do
	VALID=false
	DID_ONE=true
	GRP=$1
	EXE=${GRP%%_*}
	shift
	for VALID_EXE in ${VALID_EXES[*]}
		do
		if [ $EXE == $VALID_EXE ]
			then
			VALID=true
		fi
	done

	if [ $VALID == false ]
		then
		echo "Unrecognised argument: $GRP"
		echo "\"./${COMMAND}.sh\" for usage info"
	else
		echo "Valid!"
		USER="lab"
		#remove 'Server' from end of string
		REMAINDER=${EXE%Server}
		if [ ${#REMAINDER} -ne ${#EXE} ]
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
			pssh -h clients_${GRP}.txt -o out_dir -e err_dir -I < createScriptDir.txt
			echo '**********************'
			echo '***** copying over disable_win_key directory'
			echo '**********************'
			pscp -r -p 100 -h clients_${GRP}.txt -o out_dir -e err_dir disable_win_key /cygdrive/c/Users/lab/Downloads/scripts/
			echo '**********************'
			echo '***** running disable_win_key powershell'
			echo '**********************'
			pssh -h clients_${GRP}.txt -o out_dir -e err_dir 'runas /user:administrator /savecred "regedit.exe /S C:\\Users\\lab\\Downloads\\scripts\\disable_win_key\\DisableKeyboardRemap.reg"'
			echo '#############'
			echo 'RESTART COMPUTERS'
		fi
		###############
		###############
	fi
done

if [ $DID_ONE == false ]
	then
	echo "command format: ./${COMMAND}.sh [APP_NAME](, [APP_NAME])*"
	echo "supported app names: ${VALID_EXES[*]}"
fi
