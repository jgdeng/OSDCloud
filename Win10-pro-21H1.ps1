
Write-Host  -ForegroundColor Green "Starting OSDCloud ZTI"
Start-Sleep -Seconds 5

#Change Display Resolution for Virtual Machine
if ((Get-MyComputerModel) -match 'Virtual') {
    Write-Host  -ForegroundColor Green "Setting Display Resolution to 1600x"
    Set-DisRes 1600
}

#Make sure I have the latest OSD Content
Write-Host  -ForegroundColor Green "Updating OSD PowerShell Module"
Install-Module OSD -Force

Write-Host  -ForegroundColor Green "Importing OSD PowerShell Module"
Import-Module OSD -Force

#Start OSDCloud ZTI the RIGHT way
Write-Host  -ForegroundColor Green "Start OSDCloud"
Start-OSDCloud -OSLanguage en-us -OSBuild "21H1" -OSEdition Pro -ZTI
#Set-WindowsProductKey -Path "C:\OSDCLoud\OS" -ProductKey ""
#Start-OSDCloud -ImageFileUrl "https://www.bergeysparts.com/osdcloud/WIN10.wim" -ImageIndex 3
#Restart from WinPE
Write-Host  -ForegroundColor Green "Restarting in 20 seconds!"
Start-Sleep -Seconds 20
wpeutil reboot

