net user administrator PASSWORD
net user administrator /active:yes
runas /user:administrator /savecred "whoami"
