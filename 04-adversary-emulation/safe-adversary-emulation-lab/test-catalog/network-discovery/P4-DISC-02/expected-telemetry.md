# Expected Telemetry — P4-DISC-02

| Source | Expected evidence | Validation question |
|---|---|---|
| Windows/Sysmon | Process creation for native utilities and PowerShell, including command lines and parents. | Can the event be attributed to `P4-DISC-02` by host and time? |
| PowerShell | Script-block or transcript evidence for PowerShell-based discovery where enabled. | Can the event be attributed to `P4-DISC-02` by host and time? |
| LimaCharlie | Repeated discovery processes in the endpoint timeline. | Can the event be attributed to `P4-DISC-02` by host and time? |
| Wazuh | Centralized events and custom rule `100140` for network-discovery indicators. | Can the event be attributed to `P4-DISC-02` by host and time? |
| Analyst mapping | Configuration commands mapped to `T1016`; active-connection commands also mapped to `T1049`. | Can the event be attributed to `P4-DISC-02` by host and time? |

## Collection Quality Checks

- Confirm hostname, source/target, timestamp, process or protocol, and user context where available.
- Separate raw telemetry from alert/detection output.
- Record missing fields or collection errors as a limitation.
- Do not substitute historical events for current-run evidence.
- Link the final observation to the image gallery in [README.md](README.md).

## Evidence Folder

[Open the relevant screenshot folder](../../../screenshots/03-discovery/)
