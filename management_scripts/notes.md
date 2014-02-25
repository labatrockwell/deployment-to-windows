TODO:
* migrate ips from old to new
* create txt file for structure clients
* set ips for wireless adapter



1. set a password for the admin account: `net user administrator *`
2. make the admin account accessible `net user administrator /active:yes`
	* must be run as admin, can use runas-admin.bat for this
3. run any command locally with /savecred
	* `runas /user:administrator /savecred "whoami"
4. now you can run remotely as administrator using the /savecred flag
5. if that doesn't work and you need to run something as admin, run it via `runas-admin.bat` and click 'yes' on all the screens

./activateAdminAcct.sh
#requires hitting "yes" on all computers
./changeip/changeip.sh
#should change ip on all computers