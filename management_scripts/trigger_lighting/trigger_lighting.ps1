Add-Type @"
  using System;
  using System.Runtime.InteropServices;
  public class Tricks {
     [DllImport("user32.dll")]
     [return: MarshalAs(UnmanagedType.Bool)]
     public static extern bool SetForegroundWindow(IntPtr hWnd);
  }
"@
Add-Type -AssemblyName System.Windows.Forms
$num_files = 0
$DESKTOP = [environment]::getfolderpath("desktop")
$h = (Get-Process lumidesk_beta).MainWindowHandle
while($true){
    $curr_numFiles = ( Get-ChildItem $DESKTOP\drawings | Measure-Object ).Count
    if ( $curr_numFiles -eq $num_files ){
        #do nothing
    } else {
        [Tricks]::SetForegroundWindow($h)
        [System.Windows.Forms.SendKeys]::SendWait("z")

        #######
        # START send UDP to MIDI program
        #######
        [int] $Port = 4563
        $IP = "10.250.165.252"
        $Address = [system.net.IPAddress]::Parse($IP)
        
        # Create IP Endpoint
        $End = New-Object System.Net.IPEndPoint $address, $port
        
        # Create Socket
        $Saddrf   = [System.Net.Sockets.AddressFamily]::InterNetwork
        $Stype    = [System.Net.Sockets.SocketType]::Dgram
        $Ptype    = [System.Net.Sockets.ProtocolType]::UDP
        $Sock     = New-Object System.Net.Sockets.Socket $saddrf, $stype, $ptype
        $Sock.TTL = 26
        
        # Connect to socket
        $sock.Connect($end)
        
        # Create encoded buffer
        $Enc     = [System.Text.Encoding]::ASCII
        $Message = "particle"
        $Buffer  = $Enc.GetBytes($Message)
        
        # Send the buffer
        $Sent   = $Sock.Send($Buffer)
        #######
        # END send UDP
        #######

        Start-Sleep -milliseconds 2000
        $num_files = ( Get-ChildItem $DESKTOP\drawings | Measure-Object ).Count
    }
    Start-Sleep -milliseconds 100
}