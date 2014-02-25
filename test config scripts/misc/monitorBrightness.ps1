$monitors = Get-WmiObject -Namespace root\wmi -Class WmiMonitorBrightnessMethods

foreach ($monitor in $monitors){ 
  $monitor.WmiSetBrightness(1, 100)   
}     
