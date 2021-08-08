#=======================================================================
#   PreOS: Update-Module
#=======================================================================
Install-Module OSD -Force
Import-Module OSD -Force
#=======================================================================
#   OS: Params and Start-OSDCloud
#=======================================================================
$Params = @{
    OSBuild = "21H1"
    OSEdition = "Pro"
    OSLanguage = "en-us"
    OSLicense = "Retail"
    SkipAutopilot = $true
    SkipODT = $true
}
Start-OSDCloud @Params
#=======================================================================
#   PostOS: Autuntended Configuration
#=======================================================================
$Autuntended = @'
{
    "Assign":  {
                   "IsPresent":  true
               },
    "GroupTag":  "Enterprise",
    "GroupTagOptions":  [
                            "Development",
                            "Enterprise"
                        ],
    "Hidden":  [
                   "AddToGroup",
                   "AssignedComputerName",
                   "AssignedUser"
               ],
    "PostAction":  "Quit",
    "Run":  "PowerShell",
    "Title":  "OSDCloud Autopilot Registration"
}
'@
$Autuntended | Out-File -FilePath "C:\ProgramData\OSDCloud\DriverPacks\autounattend.xml" -Encoding ascii -Force
#=======================================================================
#   PostOS: OOBEDeploy Configuration
#=======================================================================
$OOBEDeployJson = @'
{
    "Autopilot":  {
                      "IsPresent":  true
                  },
    "RemoveAppx":  [
                       "CommunicationsApps",
                       "OfficeHub",
                       "People",
                       "Skype",
                       "Solitaire",
                       "Xbox",
                       "ZuneMusic",
                       "ZuneVideo"
                   ],
    "UpdateDrivers":  {
                          "IsPresent":  true
                      },
    "UpdateWindows":  {
                          "IsPresent":  true
                      }
}
'@
$OOBEDeployJson | Out-File -FilePath "C:\ProgramData\OSDCloud\DriverPacks\autounattend.xml" -Encoding ascii -Force

#=======================================================================
#   PostOS: AutopilotOOBE CMD Command Line
#=======================================================================
$AutopilotCmd = @'
PowerShell -NoL -Com Set-ExecutionPolicy RemoteSigned -Force
set path=%path%;C:\Program Files\WindowsPowerShell\Scripts
start PowerShell -NoL -W Mi
start /wait PowerShell -NoL -C Install-Module AutopilotOOBE -Force
start /wait PowerShell -NoL -C Start-AutopilotOOBE -Title 'GetModern Autopilot Registration' -GroupTag Enterprise -GroupTagOptions Development,Enterprise -Assign
'@
$AutopilotCmd | Out-File -FilePath "C:\Windows\Autopilot.cmd" -Encoding ascii -Force

#=======================================================================
#   PostOS: Restart-Computer
#=======================================================================
Restart-Computer