# Objective — P4-DISC-02

Validate visibility for network configuration and active-connection discovery across local output, endpoint telemetry, EDR, and Wazuh. The test should also demonstrate accurate analyst mapping between `T1016` and `T1049`.

### Success conditions

- Configuration and connection discovery commands complete successfully.
- Full command lines are retained.
- LimaCharlie or equivalent endpoint telemetry shows the process sequence.
- Wazuh rule `100140` is observed.
- The documentation separates tool-provided mapping from analyst-reviewed mapping.

## Scope

- Authorized source: WIN-ENDPOINT (`192.168.10.10`)
- Authorized target: Local Windows endpoint
- Test category: Discovery
- Recorded status: **Validated**

## Evidence Entry Points

- [Full test README and image gallery](README.md)
- [Complete screenshot folder](../../../screenshots/03-discovery/)
- [Evidence manifest](../../../screenshots/evidence-manifest.csv)
