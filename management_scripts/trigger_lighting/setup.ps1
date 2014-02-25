#unregister event if it exists
Unregister-Event -SourceIdentifier FileCreated

#create new event
$folder = 'C:\Users\CD004724\Desktop\drawings'
$filter = '*.*'
$fsw = New-Object IO.FileSystemWatcher $folder, $filter
$fsw.IncludeSubdirectories = $true
#$fsw.NotifyFilter = [IO.NotifyFilters]'DirectoryName' # just notify directory name events
$onCreated = Register-ObjectEvent $fsw Created -SourceIdentifier FileCreated -Action {  invoke-expression -Command C:\Users\CD004724\Downloads\scripts\trigger_lighting\trigger_lighting.ps1 }