# Incident Report — Windows Reconnaissance Commands

## 1. Executive Summary

LimaCharlie generated four detections on `win-endpoint.lan` after a sequence of native Windows discovery commands. Sysmon confirmed the corresponding process creation and PowerShell parent context. The activity was an authorized lab simulation.

## 2. Alert Details

| Field | Value |
|---|---|
| Detection | `windows-reconnaissance-commands` |
| Host | `WIN-ENDPOINT` / `win-endpoint.lan` |
| User | `WIN-ENDPOINT\Administrator` |
| Priority | 3 |
| Commands detected | `whoami /priv`, `net user`, `net localgroup administrators`, `ipconfig /all` |
| Data sources | LimaCharlie and Sysmon |

## 3. Timeline

| UTC Time | Activity |
|---|---|
| 14:41:01 | `whoami.exe /priv` |
| 14:41:06 | `net.exe user` |
| 14:41:15 | `net.exe localgroup administrators` |
| 14:41:24 | `ipconfig.exe /all` |

## 4. MITRE ATT&CK

| Technique | ID |
|---|---|
| System Owner/User Discovery | T1033 |
| Local Account | T1087.001 |
| Local Groups | T1069.001 |
| System Network Configuration Discovery | T1016 |

## 5. Analysis

Each command is legitimate on its own. The short sequence, common parent process, same user context, and endpoint proximity increase detection value. In production, analysts should determine whether the activity aligns with approved administration or follows a suspicious logon or process execution.

## 6. Impact

No compromise or data loss occurred in the lab. The commands only enumerated local endpoint information.

## 7. Recommended Production Response

- Review the parent process and user session.
- Correlate with recent logons and remote access events.
- Search for subsequent credential access, lateral movement, or persistence.
- Tune the rule using trusted users, scripts, paths, and maintenance windows.

## 8. Evidence Gap

`nltest /domain_trusts` was included in the rule but was not captured in the supplied evidence.
