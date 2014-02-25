#!/usr/bin/env bash
tty -echo;
read -s -p "Input password:" A;
stty echo;
echo;

while test $# -gt 0
	do
	#a space-separated list of ip addresses
	ip_address_list=$1
	shift

	for HOST in `cat $ip_address_list`
	do
		if [[ $HOST == \#* ]] || [ ${#HOST} -eq 0 ]
		then
			: # ignore line
		else
	echo "Connecting to $HOST"

	expect -c "set timeout -1;\
	spawn ssh -o StrictHostKeyChecking=no $HOST \"mkdir -p ~/.ssh\";\
	match_max 100000;\
	expect *assword:*;\
	send $A;\
	send \n;\
	interact;"

	expect -c "set timeout -1;\
	spawn scp -o StrictHostKeyChecking=no $HOME/.ssh/id_rsa.pub $HOST:~/.ssh/temp.pub;\
	match_max 100000;\
	expect *assword:*;\
	send $A;\
	send \n;\
	interact;"

	expect -c "set timeout -1;\
	spawn ssh -o StrictHostKeyChecking=no $HOST \"cat ~/.ssh/temp.pub >> ~/.ssh/authorized_keys\";\
	match_max 100000;\
	expect *assword:*;\
	send $A;\
	send \n;\
	interact;"

	echo "Finished job on $HOST"
		fi
	done
done