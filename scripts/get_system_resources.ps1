# PERIODIC CHECK SYSTEM RESOURCES
# CONFIGURE THESE VARIABLES AS APPROPRIATE
$secondsWait = 300
$webhookurl = "https://discord.com/api/webhooks/blablabla"

while($true) {
    $date = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $cpuTime = Get-Counter '\Processor(_Total)\% Processor Time' | Select-Object -ExpandProperty CounterSamples | Select-Object CookedValue
	$performance_counter = Get-Counter '\Memory\% Committed Bytes In Use'
	$usedMemoryPercentage = $performance_counter.CounterSamples[0].CookedValue	
	
	$output = '[' + $date + '] CPU: ' + $cpuTime.CookedValue.ToString("#,0.00") + ' %, RAM: ' + $usedMemoryPercentage.ToString("#,0.00") + ' % '

    $content = $output.ToString()
	
	$content
	
        $body = @{
        content = $content
    } | ConvertTo-Json
	
    Invoke-RestMethod -Uri $webhookurl -Method Post -Body $body -ContentType 'application/json'

    Start-Sleep -s $secondsWait
}