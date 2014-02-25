net start w32time
w32tm /config /syncfromflags:manual /manualpeerlist:10.250.165.253 /largephaseoffset:120000
w32tm /config /update
REM w32tm /resync /rediscover
w32tm /resync