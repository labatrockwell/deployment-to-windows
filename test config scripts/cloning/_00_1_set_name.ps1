#constants
$UUID_I = 0
$INDEX_I = 1
$NAME_I = 2
$IP_I = 3
$INTEL_LABS = $False

while($True){
    while($True){
        ""
        $name = Read-Host -Prompt "Please enter computer name, format [make]-[model_id]-[sequence_id],`nie Toshiba-1-2 for Toshiba model 1 laptop 2`nFor INTEL LABS you should enter Lenovo-15-X where X is the device number`n"
    
        $splits = $name.split("-")
        $make = $splits[0]
        $model = 0+$splits[1]
        $laptop = 0+$splits[2]

        if ($make -eq "Asus" -and ($model -ne 1)){
            "*** '1' is the only valid Asus model_id"
            ""
            continue
        } elseif ($make -eq "Lenovo" -and ($model -ne 2 -and $model -ne 3 -and $model -ne 15)){
            "*** '2', '3', and '15' are the only valid Lenovo model_ids"
            ""
            continue
        } elseif ($make -eq "Sony" -and ($model -ne 4 -and $model -ne 5)){
            "*** '4' and '5' are the only valid Sony model_ids"
            ""
            continue
        } elseif ($make -eq "Toshiba" -and ($model -ne 6 -and $model -ne 7)){
            "*** '6' and '7' are the only valid Toshiba model_ids"
            ""
            continue
        } elseif ($make -eq "HP" -and ($model -ne 8)){
            "*** '8' is the only valid HP model_id"
            ""
            continue
        } elseif ($make -eq "Samsung" -and ($model -ne 10)){
            "*** '10' is the only valid Samsung model_id"
            ""
            continue
        } elseif ($make -eq "Dell" -and ($model -ne 11 -and $model -ne 12)){
            "*** '11' and '12' are the only valid Dell model_ids"
            ""
            continue
        } elseif ($make -eq "Acer" -and ($model -ne 13)){
            "*** '13' is the only valid Acer model_id"
            ""
            continue
        } else {
            #valid make/model pair
            break
        }
    }

    if ($make -eq "Lenovo" -and $model -eq 15){
        $INTEL_LABS = $True
    }

    if ($INTEL_LABS){
        $sub = 100 + $laptop
        $ip = "10.250.160.$sub"
        $gateway = "10.250.160.1"
        $dns1 = "10.250.160.1"
    } else {
        if ($laptop -gt 9){
            "*** laptop ID must be between 0 and 9 (inclusive)"
            ""
            continue
        }
        $sub = 100 + $model * 10 + $laptop
        $ip = "10.250.165.$sub"
        $gateway = "10.250.165.1"
        $dns1 = "10.250.165.1"
    }

    if ($name){
        ""
        "setting name as $name, ip as $ip"
        $confirm = Read-Host -Prompt "Does the above look correct? (y/n/q)`n"
        $confirm = $confirm.toLower()[0]
        if($confirm -eq 'n'){
            continue
        } elseif ($confirm -eq 'q'){
            Exit
        } else {
            break
        }
    }
}

$submask = "255.255.255.0"


#now that we have a valid and confirmed hostname...
$computername = Get-WmiObject Win32_ComputerSystem
# this renames the machine
$computername.rename($name)

$dns2 = " . . . "
$registerDns = "TRUE"

$networkinterface = "Local Area Connection"
 
$dns = $dns1
if($dns2){$dns ="$dns1,$dns2"}
# this somehow finds the connected named "Local Area Connection", or $networkinterface content
#$index = (gwmi Win32_NetworkAdapter | where {$_.netconnectionid -eq $networkinterface}).InterfaceIndex
#$NetInterface = Get-WmiObject Win32_NetworkAdapterConfiguration | where {$_.InterfaceIndex -eq $index}
$NetInterface = get-wmiobject Win32_networkadapterconfiguration -filter "ipenabled = 'true'"
$NetInterface
#$nets= Get-WmiObject Win32_NetworkAdapterConfiguration
#foreach ($NetInterface in $nets){

    #"setting static"
    $unimportant = $NetInterface.EnableStatic($ip, $submask)
    #"setting gateway"
    # we actually set the gateway to the ip to remove it (silly windows trick)
    $unimportant = $NetInterface.SetGateways($ip)
    #"setting dns"
    #$NetInterface.SetDNSServerSearchOrder($dns)
    #"setting dns registration"
    $unimportant = $NetInterface.SetDynamicDNSRegistration($registerDns)
#}
"finished"
"press any key to continue ..."
$unimportant = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyUp")