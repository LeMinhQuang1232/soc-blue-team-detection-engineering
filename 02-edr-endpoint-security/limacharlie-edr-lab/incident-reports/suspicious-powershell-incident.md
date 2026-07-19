# Incident Report — Suspicious Encoded PowerShell

## 1. Executive Summary

A PowerShell process was executed with the `-EncodedCommand` argument on `WIN-ENDPOINT`. LimaCharlie recorded the process telemetry, Sysmon recorded Event ID 1, and Wazuh generated rule `92057` at level 12. The command was an authorized lab simulation that only printed a test string.

## 2. Alert Details

| Field | Value |
|---|---|
| Alert | Encoded PowerShell execution |
| Host | `WIN-ENDPOINT` / `win-endpoint.lan` |
| User | `WIN-ENDPOINT\Administrator` |
| Process | `powershell.exe` |
| Process ID | `4972` |
| Parent process ID | `5308` |
| Wazuh rule | `92057` |
| Severity | High detection severity; low actual lab impact |
| Data sources | LimaCharlie, Sysmon, Wazuh |

## 3. Evidence

| Evidence | Meaning |
|---|---|
| Safe command screenshot | Confirms harmless test content |
| LimaCharlie Timeline | Confirms process, command line, user, and parent context |
| Sysmon/Wazuh event | Confirms process creation and SIEM alert |
| Benign comparison | Shows lower severity for normal PowerShell activity |

## 4. MITRE ATT&CK

| Tactic | Technique | ID |
|---|---|---|
| Execution | PowerShell | T1059.001 |

## 5. Analysis

The activity was a true-positive match to the detection logic but was not a security compromise. No malicious download, persistence, credential access, or destructive behavior was observed.

## 6. Recommended Production Response

- Decode and review the command safely.
- Investigate the parent process and initiating user.
- Search for network connections, file creation, and child processes.
- Compare against approved scripts and management tools.
- Isolate the host when malicious behavior is confirmed.

## 7. Evidence Gap

A LimaCharlie custom detection card for this rule was not included in the supplied screenshots and remains `Pending Evidence`.
