#append this to the beginning of your ssh config file, probably located at ~/.ssh/config


 Host intel-server
   User CD004931
   HostName 10.250.165.254

 Host intel-server2
   User CD004724
   HostName 10.250.165.253

 Host *
   CheckHostIP no
   StrictHostKeyChecking no