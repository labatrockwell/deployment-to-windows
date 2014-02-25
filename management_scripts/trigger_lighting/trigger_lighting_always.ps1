Add-Type -AssemblyName System.Windows.Forms
while($true){
        [System.Windows.Forms.SendKeys]::SendWait("z")
        Start-Sleep -milliseconds 2000
}