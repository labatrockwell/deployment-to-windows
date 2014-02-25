#!/usr/bin/env bash
#constants
VALID_EXES=("FramesServer" "TabletClient" "StructureClient" "SpotlightClient" "SpotlightServer" "LeviathanClient" "LeviathanServer")
COMMAND=setbackground/setbackground
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
			echo '***** copying over setbackground directory'
			echo '**********************'
			pscp -r -p 100 -h clients_${GRP}.txt -o out_dir -e err_dir setbackground /cygdrive/c/Users/lab/Downloads/scripts/
			echo '**********************'
			echo '***** running set background powershell'
			echo '**********************'
			#theme setting taken from here: http://stackoverflow.com/a/5367525
			# and since I can't seem to get the handle for File Explorer windows unless I am writing a windows application...
			# I just use a hack of killing and re-starting explorer.exe
			pssh -h clients_${GRP}.txt -o out_dir -e err_dir '/cygdrive/c/Users/lab/Downloads/scripts/setbackground/launch_theme.bat; sleep 2; taskkill /f /im explorer.exe; sleep 2; explorer;'
			echo '**********************'
			echo '***** requires restart to get all computers to show new background'
			echo '**********************'
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
