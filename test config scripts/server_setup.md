1. connect to switch
2. set network preferences for Ethernet adapter to use:
	* ip: 10.250.165.254
	* mask: 255.255.255.0
	* gateway/dns: 10.250.165.1
3. enable ping
	* in windows firewall, go to Advanced settings, click 'Inbound Rules' and enable the two "File and Printer Sharing (Echo Request - ICMPv4-In)" rules
4. install cygwin
5. copy rsa key to server
6. run copy_ssh_key.sh on server

**Note:** The server setup was a separate process from the other computers because the servers had logins which we did not know. We relied on auto-login to unlock the server computers when they started up.

In retrospect, we should have set up the same username/password account on the servers as we had for all other computers, it would have simplified our scripts and made initial setup more consistent.
