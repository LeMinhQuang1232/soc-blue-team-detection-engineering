# Expected Telemetry — P4-EXEC-01

| Source | Expected evidence | Validation question |
|---|---|---|
| Windows/Sysmon | A new `powershell.exe` process with the full encoded command line and parent-process context. | Can the event be attributed to `P4-EXEC-01` by host and time? |
| LimaCharlie | A process event or timeline entry showing the executable, command line, user, and sensor. | Can the event be attributed to `P4-EXEC-01` by host and time? |
| Wazuh | A centralized process event and an encoded-PowerShell detection. | Can the event be attributed to `P4-EXEC-01` by host and time? |
| Analyst context | No network connection, dropped payload, persistence, or follow-on malicious behavior. | Can the event be attributed to `P4-EXEC-01` by host and time? |

## Collection Quality Checks

- Confirm hostname, source/target, timestamp, process or protocol, and user context where available.
- Separate raw telemetry from alert/detection output.
- Record missing fields or collection errors as a limitation.
- Do not substitute historical events for current-run evidence.
- Link the final observation to the image gallery in [README.md](README.md).

## Evidence Folder

[Open the relevant screenshot folder](../../../screenshots/02-endpoint-execution/)
