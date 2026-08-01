# Objective — P4-DISC-01

Validate that native system-information discovery is visible as endpoint process telemetry and can be located in centralized monitoring. The test is successful when the command, endpoint, user context, and execution time are recoverable without relying only on the console screenshot.

### Success conditions

- `systeminfo.exe` execution is visible.
- The command can be correlated to WIN-ENDPOINT.
- The event is searchable in Wazuh and, when available, LimaCharlie.
- No persistent system change is made.

## Scope

- Authorized source: WIN-ENDPOINT (`192.168.10.10`)
- Authorized target: Local Windows endpoint
- Test category: Discovery
- Recorded status: **Validated**

## Evidence Entry Points

- [Full test README and image gallery](README.md)
- [Complete screenshot folder](../../../screenshots/03-discovery/)
- [Evidence manifest](../../../screenshots/evidence-manifest.csv)
