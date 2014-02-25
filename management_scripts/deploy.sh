#!/usr/bin/env bash
#constants
VALID_EXES=("FramesServer" "TabletClient" "StructureClient" "SpotlightClient" "SpotlightServer" "LeviathanClient" "LeviathanServer")
COMMAND=test
##get the directory that the script is located
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

DID_ONE=false
DO_LAUNCH=false
DO_COPY=true
DONE_APPS=()
I=0
while test $# -gt 0
	do
	VALID=false
	DID_ONE=true
	GRP=$1
	shift
	if [ $GRP == "-l" ]
		then
		DO_LAUNCH=true
	elif [ $GRP == "-C" ]
		then
		DO_COPY=false
	else
		EXE=${GRP%%_*}
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
			DONE_APPS[$I]=$GRP
			I=`expr $I + 1`
			chmod -R +x "$DIR/../../CES2014_Builds/$EXE/"
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
			echo "#################"
			echo "#### ensuring directory exists"
			echo "#################"
			pssh -p 100 -h clients_${GRP}.txt -o out_dir -e err_dir "mkdir -p /cygdrive/c/Users/$USER/Downloads/build/$EXE;"
			#TODO: convert to rsync (need to install on all clients)
			#rsync note to self -a for archive mode (use source permissions) --delete for removing extraneous files
			echo "#################"
			echo "#### copying over files"
			echo "#################"
			prsync -rav -p 100 -h clients_${GRP}.txt -o out_dir -e err_dir $DIR/../../CES2014_Builds/$EXE /cygdrive/c/Users/$USER/Downloads/build/

			if [ $DO_COPY == true ]
				then
				if [ $EXE == "StructureClient" ]
					then
					echo "#################"
					echo "#### replacing structure_client.txt"
					echo "#################"
					pssh -p 100 -h clients_${GRP}.txt -o out_dir -e err_dir cp /cygdrive/c/Users/$USER/Downloads/structure_client.txt /cygdrive/c/Users/$USER/Downloads/build/$EXE/
				elif [ $EXE == "TabletClient" ]
					then
					echo "#################"
					echo "#### replacing tablet_client.txt"
					echo "#################"
					pssh -p 100 -h clients_${GRP}.txt -o out_dir -e err_dir cp /cygdrive/c/Users/$USER/Downloads/structure_client.txt /cygdrive/c/Users/$USER/Downloads/build/$EXE/tablet_client.txt
				fi
			fi
			###############
			###############
		fi
	fi
done

if [ $DID_ONE == false ]
	then
	echo "command format: ./${COMMAND}.sh [-l] [-C] [APP_NAME](, [APP_NAME])*"
	echo "supported app names: ${VALID_APPS[*]}"
	echo "-l will cause the launch command to be run with the same arguments immediately following deploy"
	echo "-C (capital C) disables copying config files"
fi

if [ $DO_LAUNCH == true ]
	then
	echo "#################"
	echo "#### launching!"
	echo "#################"
	./launch.sh ${DONE_APPS[@]}
fi