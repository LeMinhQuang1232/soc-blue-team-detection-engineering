# Expected Telemetry — P4-NET-01

| Source | Expected evidence | Validation question |
|---|---|---|
| pfSense | Allow decisions for approved web services and block decisions for restricted administrative services. | Can the event be attributed to `P4-NET-01` by host and time? |
| Packet capture | Traffic limited to the authorized source/target and test window. | Can the event be attributed to `P4-NET-01` by host and time? |
| Zeek | Connection records showing destination services and connection states. | Can the event be attributed to `P4-NET-01` by host and time? |
| Python detector | Low-volume run below scan threshold; replay dataset produces high unique-port and failed-connection counts. | Can the event be attributed to `P4-NET-01` by host and time? |
| Wazuh | Ingestion of structured detector output and rule `100201` for the replay. | Can the event be attributed to `P4-NET-01` by host and time? |
| Suricata | A current alert only if the isolated traffic matches an enabled rule; otherwise a documented coverage gap. | Can the event be attributed to `P4-NET-01` by host and time? |

## Collection Quality Checks

- Confirm hostname, source/target, timestamp, process or protocol, and user context where available.
- Separate raw telemetry from alert/detection output.
- Record missing fields or collection errors as a limitation.
- Do not substitute historical events for current-run evidence.
- Link the final observation to the image gallery in [README.md](README.md).

## Evidence Folder

[Open the relevant screenshot folder](../../../screenshots/06-network-validation/)
