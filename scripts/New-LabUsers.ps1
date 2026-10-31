<#
.SYNOPSIS
  Creates lab users in Active Directory from a CSV file.
.DESCRIPTION
  Reads First, Last and Dept from users.csv, builds a username (first initial + last name),
  creates the account in OU=<Dept>,OU=_Users,DC=lab,DC=local, adds it to GG_<Dept>,
  and forces a password change at first sign-in.
  Safe to rerun: accounts that already exist are skipped, so onboarding a new hire is
  just adding one CSV row and running the script again.
.NOTES
  Lab use only. The temporary password below is hardcoded for convenience in an isolated lab.
  In production, prompt for it instead: Read-Host -AsSecureString
#>
Import-Module ActiveDirectory

$csvPath = "C:\Lab\users.csv"
$tempPassword = ConvertTo-SecureString "Welcome!2026" -AsPlainText -Force   # Lab-only temp password

$users = Import-Csv $csvPath
foreach ($u in $users) {
  $sam = ($u.First.Substring(0,1) + $u.Last).ToLower()      # e.g. mlopez

  if (Get-ADUser -Filter "SamAccountName -eq '$sam'") {
    Write-Output "Skipped $sam (already exists)"
    continue
  }

  New-ADUser -Name "$($u.First) $($u.Last)" -GivenName $u.First -Surname $u.Last `
    -SamAccountName $sam -UserPrincipalName "$sam@lab.local" -Department $u.Dept `
    -Path "OU=$($u.Dept),OU=_Users,DC=lab,DC=local" `
    -AccountPassword $tempPassword -ChangePasswordAtLogon $true -Enabled $true

  Add-ADGroupMember -Identity "GG_$($u.Dept)" -Members $sam
  Write-Output "Created $sam in $($u.Dept)"
}
