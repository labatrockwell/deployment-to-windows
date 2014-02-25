$DisconnectedCount=0
while(test-path C:\Users\lab\Downloads\scripts\wifi_reconnect\do_reconnect.txt){
    $WifiAdapter=Get-WmiObject -Class Win32_NetworkAdapter | Where-Object {$_.name -like "*wireless*" -or $_.name -like "*advanced-n*"}
    if ( $WifiAdapter.NetConnectionStatus -ne 2 ){
        $DisconnectedCount++
        if ( $DisconnectedCount -ge 5 ){
            $WifiAdapter.Disable()
            Start-Sleep -milliseconds 5000
            $WifiAdapter.Enable()
            $DisconnectedCount=0
        }
    } else {
        $DisconnectedCount=0
    }
    Start-Sleep -milliseconds 5000
}