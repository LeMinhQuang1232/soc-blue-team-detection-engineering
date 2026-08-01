# Expected Telemetry — P4-DISC-01

| Source | Expected evidence | Validation question |
|---|---|---|
| Windows/Sysmon | Process creation for `systeminfo.exe`, including the parent process and user. | Can the event be attributed to `P4-DISC-01` by host and time? |
| LimaCharlie | A process timeline record for the discovery command when the sensor is healthy. | Can the event be attributed to `P4-DISC-01` by host and time? |
| Wazuh | Centralized process telemetry searchable by host, executable, command line, and time. | Can the event be attributed to `P4-DISC-01` by host and time? |
| Artifacts | Console output only; no required persistent file or configuration change. | Can the event be attributed to `P4-DISC-01` by host and time? |

## Collection Quality Checks

- Confirm hostname, source/target, timestamp, process or protocol, and user context where available.
- Separate raw telemetry from alert/detection output.
- Record missing fields or collection errors as a limitation.
- Do not substitute historical events for current-run evidence.
- Link the final observation to the image gallery in [README.md](README.md).

## Evidence Folder

[Open the relevant screenshot folder](../../../screenshots/03-discovery/)
