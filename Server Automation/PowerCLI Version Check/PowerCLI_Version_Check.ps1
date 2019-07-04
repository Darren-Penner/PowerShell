$OnlineVersion = (@(Invoke-WebRequest https://www.powershellgallery.com/packages/VMware.PowerCLI/ -UseBasicParsing | Select-Object -expand Links | Where-Object outerHTML -Like "*(Current Version)*" | Select-Object -expand outerHTML) -split "\n" | Select-Object -Index 2).Trim()

$CurrentVersion =  (Find-Module VMware.PowerCLI).Version.ToString()

If ($CurrentVersion -like $null)
    {
      $MissingInstall = Read-Host "PowerCLI is not installed, would you like to install it? ( Y / N )"
     }
            Elseif($CurrentVersion -notlike $null)
                {
                    Break
                 }
                Switch($MissingInstall)
                    {
                        Y {Install-Module -Name VMware.PowerCLI}
                        N {Write-Host "Please follow https://www.powershellgallery.com/packages/VMware.PowerCLI to install"}
                     }

If ($OnlineVersion -like $CurrentVersion) 
    {
        Break
     }
Elseif ($OnlineVersion -notlike $CurrentVersion)
    {
        $ReadHost = Read-Host "PowerCLI Current Version is $CurrentVersion.version, newest is $OnlineVersion. Do you want to update ( Y / N )"
            Switch($ReadHost)
                {
                    Y {Update-Module -Name VMware.PowerCLI}
                    N {Write-Host "Please follow https://www.powershellgallery.com/packages/VMware.PowerCLI to update"}
                 }
     }
