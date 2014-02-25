$Message = "Error on AC test script for laptop $Cname"

$charging = [BOOL](Get-WmiObject -Class BatteryStatus -Namespace root\wmi -ComputerName "localhost").PowerOnLine 

if( $charging -eq $false ) {
	$Message = "NOT ON AC."
	$Message
} else {
	$Message = "IS ON AC."
	$Message
}