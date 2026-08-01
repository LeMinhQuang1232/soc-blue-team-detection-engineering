# Objective — P4-FILE-01

Validate a harmless internal HTTP file transfer across endpoint, SIEM, web-server, and network telemetry. The test should prove artifact identity, file creation, Wazuh detection, request logging, Zeek metadata, and complete cleanup.

### Success conditions

- The file is downloaded from the authorized DMZ server.
- SHA-256 is recorded.
- Sysmon Event ID 11 and Wazuh rule `100150` are visible.
- Nginx and Zeek evidence correlates to the same request.
- Both client and server artifacts are removed.

## Scope

- Authorized source: WIN-ENDPOINT (`192.168.10.10`)
- Authorized target: Ubuntu DMZ Nginx (`192.168.20.10:80`)
- Test category: File and network activity
- Recorded status: **Validated**

## Evidence Entry Points

- [Full test README and image gallery](README.md)
- [Complete screenshot folder](../../../screenshots/05-file-transfer/)
- [Evidence manifest](../../../screenshots/evidence-manifest.csv)
