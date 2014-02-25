#constants
$UUID_I = 0
$INDEX_I = 1
$NAME_I = 2
$IP_I = 3
$MAN_KEY_I = 4
$filename = resolve-path "machine_names.txt"

$run = resolve-path "_01_2_advisorinstaller.exe"
Start-Process $run
while ($True){
    $man_key = Read-Host -Prompt "Please enter the windows key from the resulting screen.`nLook under 'Software Licenses' -> 'Microsoft - Windows 8 (x64)'`n"
    #we should check basic format validity
    $split_key = $man_key.split("-")
    $valid = $True
    if ($split_key.Length -ne 5){
        $valid = $False
    }
    foreach ($key_entry in $split_key){
        if ($key_entry.Length -ne 5){
            $valid = $False
            break
        }
    }
    if ($valid){
        break
    } else {
        ""
        "INVALID WINDOWS KEY FORMAT, PLEASE DOUBLE-CHECK"
        ""
        continue
    }
}

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

#check that hardware id is actually unique
#and check that the Windows Key is unique
foreach ($machine_name in $machine_names){
    $split_name = $machine_name.split(",")
    if($split_name[$UUID_I] -eq $uuid){
        $index++
    }
    if($split_name[$MAN_KEY_I] -eq $man_key){
        ""
        " DUPLICATE MANUAL KEY ENTERED!!!"
        " WE HAVE A BIG PROBLEM!!!"
        $unimportant = Read-Host -Prompt "(enter a value to continue)"
    }
}

if ($index -ne 0){
    ""
    "THIS COMPUTER'S ID IS NOT UNIQUE"
    "ATTACH A POST-IT TO THE COMPUTER WITH THE FOLLOWING INDEX:"
    $index
    ""
    "press any key to continue ..."
    $unimportant = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyUp")
}

while($True){
    while($True){
        ""
        $name = Read-Host -Prompt "Please enter computer name, format [make]-[model_id]-[sequence_id],`nie Toshiba-1-2 for Toshiba model 1 laptop 2`n"
    
        $splits = $name.split("-")
        $make = $splits[0]
        $model = 0+$splits[1]
        $laptop = 0+$splits[2]

        if ($make -eq "Asus" -and ($model -ne 1)){
            "*** '1' is the only valid Asus model_id"
            ""
            continue
        } elseif ($make -eq "Lenovo" -and ($model -ne 2 -and $model -ne 3)){
            "*** '2' and '3' are the only valid Lenovo model_ids"
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
            
            #check that ip is unique
            $validIP = $True
            $ip = [string]::Format("10.0.{0}.{1}", $model, $laptop)
            foreach ($machine_name in $machine_names){
                $split_name = $machine_name.split(",")
                if($split_name[$IP_I] -eq $ip){
                    "*** Duplicate IP found, please select a different sequence_id"
                    ""
                    $validIP = $False
                    break
                }
            }

            if ($validIP){
                break
            } else {
                continue
            }
        }
    }

    if ($name){
        ""
        "setting name as $name, ip as $ip"
        if ($laptop -gt 10){
            $type = "hand"
        } else {
            $type = "frame"
        }
        "this is a $type model"
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

add-content $filename "$uuid,$index,$name,$ip,$man_key"
"press any key to continue ..."
$unimportant = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyUp")
