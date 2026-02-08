# SCRIPT FOR QUERYING THE DAYZSALAUNCHER API
# CONFIGURE THESE VARIABLES AS APPROPRIATE

$dzsalQryPort = "27019"
$uridiscord01 = "https://discord.com/api/webhooks/blablabla"
$sleepseconds = 60

# :::::::::::: NO MODIFICAR NADA DE ACA PARA ABAJO ::::::::::::
$serverPublicIP = (Invoke-WebRequest -Uri "http://ifconfig.me/ip" -UseBasicParsing).Content 
$uridayzsalauncher = "https://dayzsalauncher.com/api/v1/query/" + $serverPublicIP + "/" + $dzsalQryPort

while ($true) {
   $datetime = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
   $webJSONData = Invoke-WebRequest -Uri $uridayzsalauncher -UseBasicParsing
   $content = ConvertFrom-Json $webJSONData.content

   $payload = @{
    content = "[" + $datetime + "] server=" + $content.result.endpoint.ip + ":" + $content.result.gamePort + "; players=" + $content.result.players + "/" + $content.result.maxPlayers  + "; error=" + $content.status + " (wait: " + $sleepseconds + " seg)"
   }

   Write-Output $content
   Write-Output $content.result.endpoint.ip
   Write-Output $content.result.endpoint.port
   Write-Output $content.result.players

   Invoke-RestMethod -Uri $uridiscord01 -Method Post -Body ($payload | ConvertTo-Json) -ContentType 'application/json' 

   Start-Sleep -Seconds $sleepseconds
}