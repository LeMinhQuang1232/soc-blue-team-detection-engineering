# Objective — P4-EXEC-01

Validate that a harmless encoded PowerShell command produces sufficient endpoint and centralized telemetry for investigation. The test should prove process creation visibility, full command-line collection, LimaCharlie visibility, Wazuh ingestion, and the expected ATT&CK-aligned alert without creating persistence or downloading content.

### Success conditions

- The PowerShell process and encoded argument are visible.
- The endpoint identity and execution time can be correlated across tools.
- Wazuh rule `92057` is present at level 12.
- `T1059.001` is displayed in the detection metadata.
- No unexpected process, file, task, service, or network connection is created.

## Scope

- Authorized source: WIN-ENDPOINT (`192.168.10.10`)
- Authorized target: Local Windows endpoint
- Test category: Endpoint execution
- Recorded status: **Validated**

## Evidence Entry Points

- [Full test README and image gallery](README.md)
- [Complete screenshot folder](../../../screenshots/02-endpoint-execution/)
- [Evidence manifest](../../../screenshots/evidence-manifest.csv)
