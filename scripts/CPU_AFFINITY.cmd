:: DAYZ SERVER SET PROCESSOR AFFINITY SCRIPT
:: Run As Administrator
powershell.exe "$p = Get-Process DayZServer_x64; $p.ProcessorAffinity = 65535"

