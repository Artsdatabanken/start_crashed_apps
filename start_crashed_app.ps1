#Defining an array of stopped application pools
$apppools = @(c:\windows\system32\inetsrv\appcmd list apppool /state:Stopped)
#Path of loggfile
$logging = 'D:\logs\pools\pools.txt'
#Exceptions: list of exceptions
$exceptions = @()
$tobeexcempt = 0


forEach ($apppool in $apppools) {
    
    $test = $apppool -Match '"([^"]+)"'
    $apppool = $Matches[1]
    forEach ($exception in $exceptions) {
        $dump = $exception -Match '"([^"]+)"'
        $exception = $Matches[1]
        
        if ($exception -eq $apppool) {
            #Do nothing
            $tobeexcempt = 1
        } else {
            #Do everything
            $tobeexcempt = 0

        }
    }

    if ($tobeexcempt -eq 0) {
        Start-WebAppPool -Name $apppool
	    (Get-date).ToString() + " , " + $apppool + " was started because it had stopped!" | Out-File -Append $logging
    } else {
        #Do nothing
        $tobeexcempt = 0
    }
    
}