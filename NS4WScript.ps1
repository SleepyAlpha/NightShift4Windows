#Original code from u/rmrbpt over at reddit

$LightTime = "7"
$DarkTime = "19"
$reg = 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize'

if ((Get-Date).Hour -in $LightTime..$DarkTime)
	{
if ((Get-ItemProperty -Path $reg).SystemUsesLightTheme -eq '1' -And (Get-ItemProperty -Path $reg).AppsUseLightTheme -eq '1')
		{
		exit
		}
		Set-ItemProperty -Path $reg -Name SystemUsesLightTheme -Value 1 -Type Dword -Force
		Set-ItemProperty -Path $reg -Name AppsUseLightTheme -Value 1 -Type Dword -Force
		Stop-Process -ProcessName Explorer
	}

else {

if ((Get-ItemProperty -Path $reg).SystemUsesLightTheme -eq '0' -And (Get-ItemProperty -Path $reg).AppsUseLightTheme -eq '0')
		{
		exit
		}
		Set-ItemProperty -Path $reg -Name SystemUsesLightTheme -Value 0 -Type Dword -Force
		Set-ItemProperty -Path $reg -Name AppsUseLightTheme -Value 0 -Type Dword -Force
		Stop-Process -ProcessName Explorer
	}