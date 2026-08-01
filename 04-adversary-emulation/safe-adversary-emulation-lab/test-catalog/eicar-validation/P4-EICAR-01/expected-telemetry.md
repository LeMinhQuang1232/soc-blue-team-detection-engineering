# Expected Telemetry — P4-EICAR-01

| Source | Expected evidence | Validation question |
|---|---|---|
| Microsoft Defender | Event ID 1116 identifying `Virus:DOS/EICAR_Test_File` and severity information. | Can the event be attributed to `P4-EICAR-01` by host and time? |
| Remediation | Event ID 1117 showing quarantine/remediation and no further action required. | Can the event be attributed to `P4-EICAR-01` by host and time? |
| Wazuh | Rule `62123` for detection and rule `62124` for remediation. | Can the event be attributed to `P4-EICAR-01` by host and time? |
| Cleanup | Artifact absent; Defender and real-time protection still enabled. | Can the event be attributed to `P4-EICAR-01` by host and time? |

## Collection Quality Checks

- Confirm hostname, source/target, timestamp, process or protocol, and user context where available.
- Separate raw telemetry from alert/detection output.
- Record missing fields or collection errors as a limitation.
- Do not substitute historical events for current-run evidence.
- Link the final observation to the image gallery in [README.md](README.md).

## Evidence Folder

[Open the relevant screenshot folder](../../../screenshots/07-eicar-validation/)
