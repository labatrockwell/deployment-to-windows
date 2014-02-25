$shell = new-object -com "Shell.Application"
$folder = $shell.Namespace('C:\Windows')
$item = $folder.Parsename('notepad.exe')
$verb = $item.Verbs() | ? {$_.Name -eq 'Pin to Tas&kbar'}
if ($verb){ $verb.DoIt() }

$folder = $shell.Namespace('C:\Windows\System32\WindowsPowershell\v1.0')
$item = $folder.Parsename('powershell.exe')
$verb = $item.Verbs() | ? {$_.Name -eq 'Pin to Tas&kbar'}
if ($verb){ $verb.DoIt() }

$item = $folder.Parsename('powershell_ise.exe')
$verb = $item.Verbs() | ? {$_.Name -eq 'Pin to Tas&kbar'}
if ($verb){ $verb.DoIt() }

$folder = $shell.Namespace('C:\Windows\System32')
$item = $folder.Parsename('cmd.exe')
$verb = $item.Verbs() | ? {$_.Name -eq 'Pin to Tas&kbar'}
if ($verb){ $verb.DoIt() }

$item = $folder.Parsename('control.exe')
$verb = $item.Verbs() | ? {$_.Name -eq 'Pin to Tas&kbar'}
if ($verb){ $verb.DoIt() }

$folder = $shell.Namespace('C:\Users\lab\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\System Tools')
$item = $folder.Parsename('Run.lnk')
$verb = $item.Verbs() | ? {$_.Name -eq 'Pin to Tas&kbar'}
if ($verb){ $verb.DoIt() }