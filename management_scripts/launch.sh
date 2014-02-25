#!/usr/bin/env bash
#constants
VALID_EXES=("FramesServer" "TabletClient" "StructureClient" "SpotlightClient" "SpotlightServer" "LeviathanClient" "LeviathanServer")
COMMAND=launch
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
		if [ $EXE == "TabletClient" -o $EXE == "StructureClient" ]
			then
			pssh -h clients_${GRP}.txt -o out_dir -e err_dir "cd /cygdrive/c/Users/$USER/Downloads/build/$EXE/; nohup ./$EXE -force-opengl >>nohup.out 2>&1 &"
			#pssh -h clients_${GRP}.txt -o out_dir -e err_dir "cd /cygdrive/c/Users/$USER/Downloads/; touch scripts/keep_alive/do_${EXE}_restart.txt; nohup scripts/keep_alive/keep_${EXE}_alive.bat >>nohup.out 2>&1 &"
		else
			pssh -h clients_${GRP}.txt -o out_dir -e err_dir "cd /cygdrive/c/Users/$USER/Downloads/build/$EXE/; nohup ./$EXE -force-opengl >>nohup.out 2>&1 &"
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
