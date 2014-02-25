#!/usr/bin/env bash
#constants
VALID_EXES=("FramesServer" "TabletClient" "StructureClient" "SpotlightClient" "SpotlightServer" "LeviathanClient" "LeviathanServer")
COMMAND=activateAdminAcct
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
			pscp -h clients_${GRP}.txt -o out_dir -e err_dir runas-admin.bat /cygdrive/c/Users/lab/Downloads/
			pscp -h clients_${GRP}.txt -o out_dir -e err_dir activateAdminAcct.bat /cygdrive/c/Users/lab/Downloads/
			pssh -h clients_${GRP}.txt -o out_dir -e err_dir -t 120 "/cygdrive/c/Users/lab/Downloads/runas-admin.bat \"C:\\Users\\lab\\Downloads\\activateAdminAcct.bat\""
			####
			# This will give you 2 minutes to click "yes" on all the computers, they prompt for admin priveleges, 
			# but from now on you should be able to run as admin without user interaction
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
