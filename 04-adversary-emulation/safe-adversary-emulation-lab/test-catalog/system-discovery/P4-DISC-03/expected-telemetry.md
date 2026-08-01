# Expected Telemetry — P4-DISC-03

| Source | Expected evidence | Validation question |
|---|---|---|
| Windows/Sysmon | Process creation for `net.exe`/`net1.exe` and the command line. | Can the event be attributed to `P4-DISC-03` by host and time? |
| Wazuh | A centralized command-shell event and rule `92032` when its conditions match. | Can the event be attributed to `P4-DISC-03` by host and time? |
| Tool mapping | Observed metadata may display `T1087` and `T1059.003`. | Can the event be attributed to `P4-DISC-03` by host and time? |
| Analyst mapping | `T1201` is the primary behavior mapping for password-policy discovery through `net accounts`. | Can the event be attributed to `P4-DISC-03` by host and time? |

## Collection Quality Checks

- Confirm hostname, source/target, timestamp, process or protocol, and user context where available.
- Separate raw telemetry from alert/detection output.
- Record missing fields or collection errors as a limitation.
- Do not substitute historical events for current-run evidence.
- Link the final observation to the image gallery in [README.md](README.md).

## Evidence Folder

[Open the relevant screenshot folder](../../../screenshots/03-discovery/)
