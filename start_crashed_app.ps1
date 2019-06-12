$apppools = @(c:\windows\system32\inetsrv\appcmd list apppool /state:Stopped)

forEach ($apppool in $apppools) {

    $test = $apppool -Match '"([^"]+)"'
    $app = $Matches[1]
    Start-WebAppPool -Name $app
}