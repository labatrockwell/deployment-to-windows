#!/usr/bin/env bash
#constants
VALID_EXES=("FramesServer" "TabletClient" "StructureClient" "SpotlightClient" "SpotlightServer" "LeviathanClient" "LeviathanServer")
COMMAND=test_battery/test_battery
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
			echo "##################"
			echo "#### ensure script dir exists"
			echo "##################"
			#pssh -h clients_${GRP}.txt -o out_dir -e err_dir -I < createScriptDir.txt
			echo "##################"
			echo "#### Copy powershell script over"
			echo "##################"
			#pscp -h clients_${GRP}.txt -o out_dir -e err_dir -r test_battery /cygdrive/c/Users/lab/Downloads/scripts/
			echo "##################"
			echo "#### run powershell & report"
			echo "##################"
			pssh -h clients_${GRP}.txt -o out_dir -e err_dir -t 20 -i "powershell C:\\\\Users\\\\lab\\\\Downloads\\\\scripts\\\\test_battery\\\\test_battery.ps1; powershell C:\\\\Users\\\\lab\\\\Downloads\\\\scripts\\\\test_ac\\\\test_ac.ps1;"
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