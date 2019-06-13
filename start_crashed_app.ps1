#Defining an array of stopped application pools
$apppools = @(c:\windows\system32\inetsrv\appcmd list apppool /state:Stopped)
#Path of loggfile
$logging = 'D:\logs\pools\pools.txt'

forEach ($apppool in $apppools) {
    
    $test = $apppool -Match '"([^"]+)"'
    $app = $Matches[1]
    echo $app
    Start-WebAppPool -Name $app
	(Get-date).ToString() + " , " + $app + " was started because it had stopped!" | Out-File -Append $logging
}