#!/usr/bin/env bash
USER=`whoami`
SCRIPT_DIR=/cygdrive/c/Users/$USER/Downloads/scripts/trigger_lighting
IMAGE_DIR=/cygdrive/c/Users/$USER/Desktop/drawings
#not a perfect lock, but hopefully good enough
if [ ! -f $SCRIPT_DIR/lock ]
	then
	touch $SCRIPT_DIR/lock

	echo 'starting'
	#COUNT=`powershell '( Get-ChildItem c:\MyFolder | Measure-Object ).Count'`
	powershell C:\\Users\\$USER\\Downloads\\scripts\\trigger_lighting\\trigger_lighting.ps1
	echo 'ending'
	#wait for animation to finish before unlocking
	sleep 3
	echo 'slept'
	rm $SCRIPT_DIR/lock
fi
echo 'done'
