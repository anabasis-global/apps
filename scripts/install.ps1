$computername = Get-Content 'C:\Setup\clients.txt'
$sourcefile = "package.msi"
$serviceName = ""
$adminUserName = ""
$adminPassword = ""
#This section will install the software 

$config = @{
  devices = ""
  packages = ""
  
}

foreach ($computer in $computername) 
{
    #First uninstall the existing service, if any
    C:\PSTools\psexec.exe \\$computer -s -u $adminUserName -p $adminPassword msiexec.exe /x C:\SetupFiles\MySyncSvcSetup.msi /qb
    Write-Host "Uninstalling Service"
    $destinationFolder = "\\$computer\C$\SetupFiles"
    #This section will copy the $sourcefile to the $destinationfolder. If the Folder does not exist it will create it.
    if (!(Test-Path -path $destinationFolder))
    {
        New-Item $destinationFolder -Type Directory
    }
    Copy-Item -Path $sourcefile -Destination $destinationFolder
    Write-Host "Files Copied Successfully"
    C:\PSTools\psexec.exe \\$computer -s -u $adminUserName -p $adminPassword msiexec.exe /i C:\SetupFiles\MySyncSvcSetup.msi /qb /l* out.txt
    Write-Host "Installed Successfully"
    C:\PSTools\psexec.exe \\$computer -s -u $adminUserName -p $adminPassword sc.exe start $serviceName
    Write-Host "Starting the Service"
}
