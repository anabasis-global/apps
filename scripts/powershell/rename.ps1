$cred = Get-Credential
Rename-Computer -DomainCredential $cred -NewName $newName -ComputerName $currentName
