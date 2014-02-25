#!/bin/expect -f

# required on Win2k3
#exec chmod +r /etc/passwd
#exec chmod +r /etc/group
#exec chmod +x /var

spawn ssh-host-config

# Host keys generation is lengthy procedure
set timeout 20

expect {
  "Overwrite existing /etc/ssh_config file? (yes/no)" {send "yes\r"; exp_continue}
  "Overwrite existing /etc/sshd_config file? (yes/no)" {send "yes\r"; exp_continue}
  "required privileges) (yes/no)" {send "yes\r"; exp_continue}
  "Should privilege separation be used? (yes/no)" { send "yes\r" }
}

set timeout 5

expect {
  "new local account 'sshd'? (yes/no)" {
send "yes\r";
exp_continue }
  "Do you want to install sshd as a service?" { send "no\r";
exp_continue }
  "Enter the value of CYGWIN for the daemon:" { send " \r"; }
}

set timeout 5

expect {
 "Do you want to use a different name? (yes/no)" { send "no\r"; 
exp_continue }
 "Create new privileged user account" { send "yes\r"; 
exp_continue }
 "Please enter" { send "PASSWORD\r";
exp_continue }
 "Reenter:" {send "PASSWORD\r";
exp_continue }
}