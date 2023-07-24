
# global

$msiExec = "$env:SystemRoot\system32\msiexec.exe"


$string = [Parameter(Mandatory = $true)][string]

is64 = [System.Environment]::Is64BitOperatingSystem
$arch = if (is64) { "x64" } else { "x86" }
# global


function Install-GLPI-Agent {
    [alias('Install-GLPIAgent')]

    
    param (
        [Parameter(Mandatory = $true)][string] $InstalledVersion, 
        [Parameter(Mandatory = $true)][string] $SetupVersion,
        [Parameter(Mandatory = $true)][string] $SetupOptions,
        [Parameter(Mandatory = $true)][string] $InstallServerPath,
        [Parameter(Mandatory = $true)][string] $SetupTAG
  )
  
  if ([string]::IsNullOrEmpty($InstalledVersion) -or ($InstalledVersion -ne $SetupVersion)) {

  
    $OperatingSystemArchitecture = if ([System.Environment]::Is64BitOperatingSystem) {
        "x64"
      } else {
        "x86"
      }

      
    $installerPath = Join-Path -Path $InstallServerPath -ChildPath "GLPI-Agent-$SetupVersion-$OperatingSystemArchitecture.msi"

    $msiExecArgs = "/i $installerPath $SetupOptions TAG=$SetupTAG"

    Start-Process -FilePath $msiExec -ArgumentList $msiExecArgs -Wait | Out-Null
    
    $InstalledVersion = Get-InstalledVersion

    $isNotInstalled = [string]::IsNullOrEmpty($InstalledVersion)
    
    if ([string]::IsNullOrEmpty($InstalledVersion) -or ($InstalledVersion -ne $SetupVersion)) {
      Uninstall-GLPI-Agent
      Start-Process -FilePath "$env:SystemRoot\system32\msiexec.exe" -ArgumentList $msiExecArgs -Wait | Out-Null
    }
  }
}
