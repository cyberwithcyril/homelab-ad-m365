# Runbook: "My mailbox is full" / "Outlook won't open"

Written from Microsoft documentation; these issues can't easily be reproduced in a lab. First question for either complaint: classic Outlook or new Outlook? Safe mode and profiles apply to classic Outlook.

## A. "I can't send email, it says my mailbox is full"

**Symptoms:** Quota warning email, or "Your mailbox can no longer send messages."

**First checks:** Check mailbox usage (admin center > user > Mail tab, or Outlook on the web > Settings > storage).

**Cause:** Mailbox reached its quota. Business Premium mailboxes are 50 GB: warning at 49 GB, sending blocked at 49.5 GB, sending and receiving blocked at 50 GB. The primary mailbox quota can't be raised.

**Fix:**
1. Empty Deleted Items and Junk; remove or save off large attachments (sort by size); clear old Sent Items.
2. Longer term: enable the online archive (included with Business Premium) with an archive policy.

**Verify:** Size below the warning level; user sends a test email.

**Escalate if:** The archive is also near its limit, or licensing changes are needed.

## B. "Outlook won't open"

**First checks:** Can the user open Outlook on the web? If yes, the mailbox is fine and the problem is the desktop app. If no, check service health.

**Fix, in order:**
1. **Safe mode:** close Outlook, Win + R > `Outlook.exe /safe` (or hold Ctrl while opening). If Windows can't find it, use the full path under `C:\Program Files\Microsoft Office\root\Office16\`.
2. **If safe mode works:** an add-in is likely the cause. File > Options > Add-ins > COM Add-ins > Go; disable add-ins, then re-enable one at a time.
3. **If safe mode fails:** new profile. Control Panel > Mail > Show Profiles > Add; choose "Prompt for a profile," open Outlook, pick the new profile and sign in through Outlook (the Mail applet can't add Microsoft 365 accounts that need modern authentication). Remove the old profile once the new one works.
4. **Still failing:** repair Office (Quick Repair, then Online Repair).

**Verify:** Outlook opens, mail syncs, test message sends and arrives.

**Escalate if:** Multiple users are affected, or it fails after a profile rebuild and Office repair.

**Sources:** [Open Outlook in safe mode](https://support.microsoft.com/en-us/office/open-outlook-in-safe-mode-f394c2ee-b2af-e97a-64ee-35cd24414811) - [Create a new Outlook profile](https://support.microsoft.com/en-gb/office/create-a-new-outlook-profile-7ff8e02a-7403-46be-ae39-166f395370a6) - [Edit an Outlook profile](https://support.microsoft.com/en-au/outlook/edit-an-outlook-profile) - [Exchange Online storage quotas](https://learn.microsoft.com/en-us/exchange/recipients/user-mailboxes/storage-quotas)
