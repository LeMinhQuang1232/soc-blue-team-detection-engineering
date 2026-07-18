# Detection: Suspicious PowerShell

## 1. Goal

Identify PowerShell process creation events whose command lines contain encoded or potentially obfuscated execution indicators.

## 2. Data Source

- Log source: Microsoft-Windows-Sysmon/Operational
- Sysmon Event ID: 1 — Process Create
- Relevant fields: `image`, `commandLine`, `parentImage`, `parentCommandLine`, `user`, `processId`, `parentProcessId`, `computer`, and timestamp

## 3. Detection Logic

The rule requires a Sysmon process-creation event for `powershell.exe` and a command-line match for encoded or suspicious execution keywords. The supplied test used `-EncodedCommand` with a harmless token-only value.

## 4. Wazuh Rule

| Item | Value |
|---|---|
| Built-in parent rule | 61603 |
| Custom rule ID | 100120 |
| Custom level | 10 |
| Image condition | Command image ends in `\\powershell.exe` |
| Command-line condition | Matches encoded-command or related suspicious keywords |
| Custom description | `LAB: Suspicious PowerShell command line detected on $(win.system.computer)` |

## 5. Test Procedure

The following safe command was run on the authorized Windows endpoint:

```powershell
powershell -NoProfile -EncodedCommand SQBFAFgA
```

This generated PowerShell process telemetry but did not download, modify, or execute a malicious payload.

## 6. Expected Alert

- Rule ID: 100120
- Wazuh level: 10
- Host: `WIN-ENDPOINT`
- User: `WIN-ENDPOINT\Administrator`
- Image: `C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe`
- Command line contains `-EncodedCommand SQBFAFgA`

## 7. MITRE ATT&CK Mapping

| Tactic | Technique | ID | Reason |
|---|---|---|---|
| Execution | PowerShell | T1059.001 | PowerShell was executed with an encoded-command argument. |

## 8. Validation Result

- Expected result: Rule 100120 is generated for the encoded PowerShell command.
- Actual result: Sysmon Event ID 1 recorded the process and Wazuh generated rule 100120 with level 10 and MITRE T1059.001.
- Status: Passed
- Verdict: True Positive — Authorized Lab Simulation.

## 9. False Positive Considerations

- Enterprise administration tools that encode PowerShell commands.
- Software deployment systems and endpoint-management agents.
- Approved automation scripts.
- Security testing and troubleshooting performed by administrators.

## 10. Limitations

- Encoded PowerShell is suspicious but not automatically malicious.
- The current regular expression begins with a hyphen before the alternatives; it clearly matches `-EncodedCommand`, but standalone tokens such as `IEX` or `DownloadString` should be regression-tested and may require regex restructuring.
- No network, file-creation, or persistence evidence was observed in the supplied screenshots.
- The normal PowerShell negative test is not fully evidenced and remains Pending Evidence.

## 11. Evidence

- [`screenshots/05-suspicious-powershell/01-event-viewer-process-create.png`](../screenshots/05-suspicious-powershell/01-event-viewer-process-create.png)
- [`screenshots/05-suspicious-powershell/02-event-viewer-process-details.png`](../screenshots/05-suspicious-powershell/02-event-viewer-process-details.png)
- [`screenshots/05-suspicious-powershell/03-custom-alert-results.png`](../screenshots/05-suspicious-powershell/03-custom-alert-results.png)
- [`screenshots/05-suspicious-powershell/04-expanded-alert-top.png`](../screenshots/05-suspicious-powershell/04-expanded-alert-top.png)
- [`screenshots/05-suspicious-powershell/05-expanded-alert-bottom.png`](../screenshots/05-suspicious-powershell/05-expanded-alert-bottom.png)
