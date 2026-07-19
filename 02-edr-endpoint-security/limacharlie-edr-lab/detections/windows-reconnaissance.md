# Detection — Windows Reconnaissance Commands

## Goal

Detect clusters of Windows native commands commonly used to discover users, groups, privileges, and network configuration.

## Data Sources

- LimaCharlie `NEW_PROCESS`
- Sysmon Event ID 1

## Detection Logic

```text
whoami /priv
net user
net localgroup administrators
ipconfig /all
nltest /domain_trusts
```

## Observed Result

Four LimaCharlie detections were captured for:

- `whoami /priv`
- `net user`
- `net localgroup administrators`
- `ipconfig /all`

`nltest /domain_trusts` remains `Pending Evidence`.

## MITRE ATT&CK

| Command | Technique | ID |
|---|---|---|
| `whoami /priv` | System Owner/User Discovery | T1033 |
| `net user` | Local Account | T1087.001 |
| `net localgroup administrators` | Local Groups | T1069.001 |
| `ipconfig /all` | System Network Configuration Discovery | T1016 |

## False Positive Notes

These commands are frequently used by administrators. Higher-confidence alerting should consider command clustering, unusual user context, suspicious parent process, remote logon activity, and activity outside maintenance windows.

## Evidence

- `screenshots/03-reconnaissance/01-recon-rule.png`
- `screenshots/03-reconnaissance/02-rule-unit-tests.png`
- `screenshots/03-reconnaissance/03-detections-overview.png`
- `screenshots/03-reconnaissance/04-detection-event-context.png`
- Sysmon screenshots in the same folder
