#constants
$TEST = $False

if ($TEST){
    $OldIP = Read-Host -Prompt "Enter test IP"

} else {
    $Ethernet = Get-WmiObject Win32_NetworkAdapterConfiguration -filter "ipenabled = 'true'"
    $OldIP = $Ethernet.IPAddress[0]
}
$Model = [int]$OldIP.split(".")[2]
$Unit = [int]$OldIP.split(".")[3]

$NewModel = $False
if ($Model -eq 13){
    $Model --
}
if ($Model -gt 8){
    $Model --
}
$Model --
$NewModel = $Model * 10 + 100

if ($Unit -eq 13){
    $Unit = 5
} elseif ($Unit -gt 5){
    $Unit -= 5
}

$FinalOctet = $NewModel + $Unit - 1

#this conditional is used for testing
if ($FinalOctet -gt 255){
    $FinalOctet = 99
}
$NewIP = "10.250.165.$FinalOctet"

if ($TEST){
    $NewIP
    "finished"

} else {
    $gateway = "10.250.165.1"
    $dns1 = "10.250.165.1"
    $submask = "255.255.255.0"
    $registerDns = "TRUE"

    $networkinterface = "Local Area Connection"

    #"setting gateway"
    # you can set the gateway to the ip to remove it (silly windows trick)
    $Ethernet.SetGateways($gateway)
    #"setting dns"
    $Ethernet.SetDNSServerSearchOrder($dns1)
    #"setting dns registration"
    $Ethernet.SetDynamicDNSRegistration($registerDns)
    #"setting static"
    $Ethernet.EnableStatic($NewIP, $submask)
}
