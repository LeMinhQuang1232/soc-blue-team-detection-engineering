# Expected Telemetry — P4-AUTH-01

| Source | Expected evidence | Validation question |
|---|---|---|
| Windows Security | Failed logon events with target account, logon type/context, status, and source information. | Can the event be attributed to `P4-AUTH-01` by host and time? |
| Wazuh | Multiple centralized failed-authentication events for `P4-LabUser`. | Can the event be attributed to `P4-AUTH-01` by host and time? |
| Success comparison | A controlled successful event that can be distinguished from the failures. | Can the event be attributed to `P4-AUTH-01` by host and time? |
| Cleanup | Network session removed and temporary user absent. | Can the event be attributed to `P4-AUTH-01` by host and time? |

## Collection Quality Checks

- Confirm hostname, source/target, timestamp, process or protocol, and user context where available.
- Separate raw telemetry from alert/detection output.
- Record missing fields or collection errors as a limitation.
- Do not substitute historical events for current-run evidence.
- Link the final observation to the image gallery in [README.md](README.md).

## Evidence Folder

[Open the relevant screenshot folder](../../../screenshots/04-authentication/)
