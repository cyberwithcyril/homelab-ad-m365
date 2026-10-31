# Ticket: "I forgot my password"

**Symptoms:** User can't remember their password.

**First checks:** Verify the caller's identity before resetting (callback to the number on file, employee ID, or the company's process). Password resets are a common social engineering target.

**Cause:** Forgotten password. The Reset Password dialog showed lockout status **Unlocked**, so only a reset was needed.

**Fix:**
- GUI: ADUC > right-click user > **Reset Password** > temp password > check **User must change password at next logon** (and **Unlock the user's account** if locked).
- PowerShell:
  ```powershell
  Set-ADAccountPassword mlopez -Reset -NewPassword (Read-Host -AsSecureString "Temp password")
  Set-ADUser mlopez -ChangePasswordAtLogon $true
  ```

**Verify:** `pwdLastSet` = 0 (forced change pending); at sign-in the user sees "The user's password must be changed before signing in" and sets a new one.

**Escalate if:** Identity can't be verified, or the request is for a privileged account.

**Notes:** This reset can be done by the help desk without Domain Admin rights: `GG_Helpdesk` has delegated "Reset user passwords and force password change at next logon" on `_Users`. Tested as `cthomas.hd`: the reset succeeded and `Set-ADUser -Title` was denied with "Insufficient access rights."

## Screenshots

<p align="center">
  <img src="../screenshots/02-reset-gui.png" width="650" alt="ADUC Reset Password with forced change at next logon"><br>
  <em>ADUC Reset Password with forced change at next logon</em>
</p>
<p align="center">
  <img src="../screenshots/02-reset-must-change.png" width="650" alt="User is prompted to set a new password"><br>
  <em>User is prompted to set a new password</em>
</p>
<p align="center">
  <img src="../screenshots/02-reset-powershell.png" width="650" alt="PowerShell reset; pwdLastSet 0 confirms the forced change"><br>
  <em>PowerShell reset; pwdLastSet 0 confirms the forced change</em>
</p>
<p align="center">
  <img src="../screenshots/02-helpdesk-delegation.png" width="650" alt="Password reset delegated to GG_Helpdesk on _Users"><br>
  <em>Password reset delegated to GG_Helpdesk on _Users</em>
</p>
<p align="center">
  <img src="../screenshots/02-helpdesk-reset-vs-denied.png" width="650" alt="Help desk account: reset allowed, other edits denied"><br>
  <em>Help desk account: reset allowed, other edits denied</em>
</p>
