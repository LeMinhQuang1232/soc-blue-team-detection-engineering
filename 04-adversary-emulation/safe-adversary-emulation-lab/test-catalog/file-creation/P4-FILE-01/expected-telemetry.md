# Expected Telemetry — P4-FILE-01

| Source | Expected evidence | Validation question |
|---|---|---|
| Endpoint process | `curl.exe` command line with internal HTTP URL and output path. | Can the event be attributed to `P4-FILE-01` by host and time? |
| Sysmon | Event ID 11 or equivalent file-creation telemetry for `C:\AtomicLab\p4-safe.txt`. | Can the event be attributed to `P4-FILE-01` by host and time? |
| Wazuh | Centralized process/file telemetry and custom rule `100150`. | Can the event be attributed to `P4-FILE-01` by host and time? |
| Nginx | Access-log request for `/p4-safe.txt` from `192.168.10.10`. | Can the event be attributed to `P4-FILE-01` by host and time? |
| Zeek | Connection metadata and HTTP URI/host information. | Can the event be attributed to `P4-FILE-01` by host and time? |
| Cleanup | Both client and server files absent. | Can the event be attributed to `P4-FILE-01` by host and time? |

## Collection Quality Checks

- Confirm hostname, source/target, timestamp, process or protocol, and user context where available.
- Separate raw telemetry from alert/detection output.
- Record missing fields or collection errors as a limitation.
- Do not substitute historical events for current-run evidence.
- Link the final observation to the image gallery in [README.md](README.md).

## Evidence Folder

[Open the relevant screenshot folder](../../../screenshots/05-file-transfer/)
