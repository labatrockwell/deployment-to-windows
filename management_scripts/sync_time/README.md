references for setting up ntp server and synching with clients: 
* http://support.microsoft.com/kb/314054
* http://support.microsoft.com/kb/307897
* http://blog.roozbehk.com/post/67415274133/sync-windows-time-server-w32time-with-external-source
possible investigation:
* http://www.pretentiousname.com/timesync/
* http://en.wikipedia.org/wiki/List_of_PTP_implementations#Software


NTP has a number of behaviors which make it difficult to update clients with extremely disparate times. Because of this,  I created a set of scripts that force the time explicitly:
* running `sync_time/force_time.sh` will start the force time sync process which generally
	- sets the same timezone for all clients
	- gets the time from the server
	- sets the clients to that same time

When setting up the NTP server to auto-start, the LogOn account cannot be the Local System account (top radio button). See instructions here: http://support.microsoft.com/kb/2478117

There is also a script `sync_time/check_time.sh` which will collect the times from all clients and provide some simple statistics about time differences.