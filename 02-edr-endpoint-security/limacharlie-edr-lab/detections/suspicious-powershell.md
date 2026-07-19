# Detection — Suspicious Encoded PowerShell

## Goal

Identify PowerShell processes using encoded or commonly obfuscated command-line indicators.

## Data Sources

- LimaCharlie `NEW_PROCESS`
- Sysmon Event ID 1
- Wazuh Sysmon alert

## Detection Logic

Match `powershell.exe` or `pwsh.exe` when the command line contains:

```text
-EncodedCommand
-enc
FromBase64String
DownloadString
IEX
```

## Safe Test

```powershell
$PlainText = 'Write-Output "Week4-EDR-Test"'
$Encoded = [Convert]::ToBase64String(
    [Text.Encoding]::Unicode.GetBytes($PlainText)
)
powershell.exe -NoProfile -EncodedCommand $Encoded
```

## Observed Result

| Source | Result |
|---|---|
| LimaCharlie Timeline | Process telemetry recorded |
| Sysmon | Event ID 1 recorded |
| Wazuh | Rule `92057`, level 12 |
| LimaCharlie Detections page | Pending Evidence |

## MITRE ATT&CK

- T1059.001 — PowerShell

## False Positive Notes

Encoded PowerShell can appear in legitimate administration and deployment tooling. Validate the user, parent process, script origin, decoded content, signature, and expected execution path before escalating.

## Evidence

- `screenshots/02-suspicious-powershell/01-safe-test-command.png`
- `screenshots/02-suspicious-powershell/02-limacharlie-process-telemetry.png`
- `screenshots/02-suspicious-powershell/03-wazuh-powershell-hunt.png`
- `screenshots/02-suspicious-powershell/04-wazuh-encoded-alert.png`
- `screenshots/02-suspicious-powershell/05-benign-powershell-comparison.png`
