#constants
$UUID_I = 0
$INDEX_I = 1
$NAME_I = 2
$IP_I = 3
$MAN_KEY_I = 4
$filename = resolve-path "machine_names.txt"

#generate machine uuid
$p = get-wmiobject win32_diskdrive | where {$_.model -ne "SanDisk Cruzer USB Device"}
$ddid = $p.serialnumber
$p = get-wmiobject win32_bios
$biosid = $p.serialnumber
$p = get-wmiobject win32_physicalmemory
$memid = $p.serialnumber
$uuid = "$ddid$biosid$memid"
$index = 0

$machine_names = get-content $filename
$maxIndex = 0
$myIndex = 0

#check that hardware id is actually unique
foreach ($machine_name in $machine_names){
    $split_name = $machine_name.split(",")
    if($split_name[$UUID_I] -eq $uuid){
        $maxIndex =  [math]::max($maxIndex, $split_name[$INDEX_I])
    }
}

#get index if required
if ($maxIndex -ne 0){
    while($True){
        ""
        $myIndex = Read-Host -Prompt "Please enter this computer's index`n(it is 0 if you were not given an index earlier)`n"
        if ($myIndex -le $maxIndex -and $myIndex -ge 0){
            break
        } else {
            "*** Invalid index, must be between 0 and %maxIndex (inclusive)"
            ""
            continue
        }
    }
}

#retrieve my data
foreach ($machine_name in $machine_names){
    $split_name = $machine_name.split(",")
    if($split_name[$UUID_I] -eq $uuid -and $split_name[$INDEX_I] -eq $myIndex){
        break
    }
}

"Make sure you are connected to wifi, then click 'activate'"
slui.exe
$success = Read-Host -Prompt "Did it work? (y/n)"
if ($success -eq "n"){
    "Enter this number in the the windows key dialog:"
    $split_name[$MAN_KEY_I]
    slui.exe 3
    "press any key to continue ..."
    $unimportant = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyUp")
}

$submask = "255.0.0.0"


#now that we have a valid and confirmed hostname...
$computername = Get-WmiObject Win32_ComputerSystem
# this renames the machine
$computername.rename($split_name[$NAME_I])

$gateway = "0.0.0.0"
$dns1 = " . . . "
$dns2 = " . . . "
$registerDns = "FALSE"

$networkinterface = "Local Area Connection"
 
$dns = $dns1
if($dns2){$dns ="$dns1,$dns2"}
# this somehow finds the connected named "Local Area Connection", or $networkinterface content
#$index = (gwmi Win32_NetworkAdapter | where {$_.netconnectionid -eq $networkinterface}).InterfaceIndex
#$NetInterface = Get-WmiObject Win32_NetworkAdapterConfiguration | where {$_.InterfaceIndex -eq $index}
$all_nets = get-wmiObject Win32_networkadapterconfiguration

#we will set the same static IP on all interfaces, some are wifi, some are ethernet, and I don't know
# how to tell reliably which adapter is for which purpose. Also, using "ipenabled" doesn't help with the
# wifi since we don't want to set up wifi before running this step.
foreach ($NetInterface in $all_nets){
#$NetInterface = get-wmiobject Win32_networkadapterconfiguration -filter "ipenabled = 'true'"
#$NetInterface

#"setting static"
$unimportant = $NetInterface.EnableStatic($split_name[$IP_I], $submask)
#"setting gateway"
# we actually set the gateway to the ip to remove it (silly windows trick)
$unimportant = $NetInterface.SetGateways($split_name[$IP_I])
#"setting dns"
#$NetInterface.SetDNSServerSearchOrder($dns)
#"setting dns registration"
$unimportant = $NetInterface.SetDynamicDNSRegistration($registerDns)
}
""
"finished!"
"press any key to restart ..."
$unimportant = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyUp")
Restart-Computer