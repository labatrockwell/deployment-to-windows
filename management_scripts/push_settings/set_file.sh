#so useful: http://tldp.org/LDP/abs/html/string-manipulation.html
cd /cygdrive/c/Users/lab/Downloads/
FRAME="NA"
SIDE="NA"
UNIT="NA"
CAM_NUM=1
PART=${PSSH_HOST:11}
echo $PART
MODEL=`expr $PART / 10`
UNIT=`expr $PART % 10`
UNIT=`expr $UNIT + 1`
PLACE=0
echo $MODEL:$UNIT

if [ $MODEL == 10 ]
	then
	#verified
	FRAME="H"
	SIDE="2"
	CAM_NUM=0
	PLACE=$UNIT
elif [ $MODEL == 11 ]
	then
	#verified
	FRAME="N"
	SIDE="0"
	CAM_NUM=0
	PLACE=$UNIT
elif [ $MODEL == 12 ]
	then
	#verified
	FRAME="H"
	SIDE="2"
	PLACE=`expr $UNIT + 4`
elif [ $MODEL == 13 ]
	then
	#verified
	FRAME="N"
	SIDE="0"
	CAM_NUM=0
	PLACE=$UNIT
elif [ $MODEL == 14 ]
	then
	#verified
	if [ $UNIT -le 4 ]
		then
		FRAME="V"
		SIDE="1"
		PLACE=`expr $UNIT + 4`
	else
		FRAME="H"
		SIDE="2"
		PLACE=`expr $UNIT - 4`
	fi
	CAM_NUM=0
elif [ $MODEL == 15 ]
	then
	#verified
	FRAME="N"
	SIDE="0"
	CAM_NUM=1
	PLACE=$UNIT
elif [ $MODEL == 16 ]
	then
	#verified
	FRAME="H"
	SIDE="1"
	PLACE=`expr $UNIT + 4`
elif [ $MODEL == 17 ]
	then
	#verified
	FRAME="H"
	SIDE="1"
	PLACE=$UNIT
elif [ $MODEL == 18 ]
	then
	#verified
	FRAME="V"
	SIDE="2"
	PLACE=`expr $UNIT + 4`
	CAM_NUM=1
elif [ $MODEL == 19 ]
	then
	#verified
	FRAME="V"
	SIDE="2"
	PLACE=$UNIT
elif [ $MODEL == 20 ]
	then
	#verified
	FRAME="V"
	SIDE="1"
	PLACE=$UNIT
elif [ $MODEL == 21 ]
	then
	#verified
	FRAME="N"
	SIDE="0"
	PLACE=0
	CAM_NUM=0
fi

if [ $UNIT -gt 4 ]
	then
	if [ $Model != 14 ]
		then
		FRAME="N"
		SIDE="0"
		PLACE=0
	fi
fi

echo -en '10.250.165.254\r\n' > structure_client.txt
echo -n $FRAME,$SIDE,$PLACE,1,white >> structure_client.txt
echo -en '\r\nfalse\r\nfalse\r\n' >> structure_client.txt
echo -n $CAM_NUM >> structure_client.txt

mkdir -p build/StructureClient
mkdir -p build/TabletClient
cp structure_client.txt build/StructureClient
cp structure_client.txt build/TabletClient/tablet_client.txt