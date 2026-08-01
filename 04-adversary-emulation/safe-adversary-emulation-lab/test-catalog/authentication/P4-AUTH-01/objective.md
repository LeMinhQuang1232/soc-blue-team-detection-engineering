# Objective — P4-AUTH-01

Validate that a bounded series of failed authentication attempts against a temporary local account is recorded in Windows Security telemetry and Wazuh, and prove that the test account and network session are removed afterward.

### Success conditions

- Multiple failures for `P4-LabUser` are visible.
- Failure and success outcomes can be distinguished.
- The events are centralized in Wazuh.
- The IPC session and temporary account are removed.
- No password is exposed in the public evidence links.

## Scope

- Authorized source: WIN-ENDPOINT (`192.168.10.10`)
- Authorized target: Local IPC share (`127.0.0.1`)
- Test category: Authentication
- Recorded status: **Validated**

## Evidence Entry Points

- [Full test README and image gallery](README.md)
- [Complete screenshot folder](../../../screenshots/04-authentication/)
- [Evidence manifest](../../../screenshots/evidence-manifest.csv)
