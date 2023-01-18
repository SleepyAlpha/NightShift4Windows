$TaskName = "NightShift4Windows"
$LightTime = "07:00"
$DarkTime = "19:00"

$Trigger = @(
    $(New-ScheduledTaskTrigger -At $LightTime -Daily),
    $(New-ScheduledTaskTrigger -At $DarkTime -Daily),
    $(New-ScheduledTaskTrigger -AtLogon)
)

$User= $env:UserName
$nolimit = New-TimeSpan -Minutes 0
$Action= New-ScheduledTaskAction -Execute "cmd.exe" -Argument '/c start /min "" powershell.exe -WindowStyle Hidden -ExecutionPolicy Bypass -File C:\Scripts\NS4WScript.ps1' 
$TaskSettings = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries -ExecutionTimeLimit $nolimit


Register-ScheduledTask -TaskName $TaskName -Trigger $Trigger -User $User -Action $Action -RunLevel Highest –Force

Start-ScheduledTask -TaskName $TaskName

Set-ScheduledTask -TaskName $TaskName -Settings $TaskSettings