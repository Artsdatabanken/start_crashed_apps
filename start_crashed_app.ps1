$apppools = @(c:\windows\system32\inetsrv\appcmd list apppool /state:Stopped)

forEach ($apppool in $apppools) {

#$name = Select-String -InputObject $apppool -Pattern '"([^"]+)"'

$test = $apppool -Match '"([^"]+)"'
$app = $Matches[1]
Start-WebAppPool -Name $app
}