$Message = "Error on Battery test script for laptop $Cname"

$capacity = (Get-WmiObject win32_battery).estimatedChargeRemaining
$capacity