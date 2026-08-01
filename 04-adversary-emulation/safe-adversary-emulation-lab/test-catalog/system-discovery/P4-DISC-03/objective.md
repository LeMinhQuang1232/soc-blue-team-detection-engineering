# Objective — P4-DISC-03

Validate that a read-only password-policy discovery command is visible in endpoint and Wazuh telemetry, and demonstrate analyst review of ATT&CK mapping quality.

### Success conditions

- `net accounts` output is captured.
- The process and command line are visible centrally.
- Wazuh rule `92032` is recorded.
- Tool-provided mappings and the analyst-reviewed `T1201` mapping are clearly distinguished.
- No policy setting is modified.

## Scope

- Authorized source: WIN-ENDPOINT (`192.168.10.10`)
- Authorized target: Local Windows endpoint
- Test category: Discovery
- Recorded status: **Validated**

## Evidence Entry Points

- [Full test README and image gallery](README.md)
- [Complete screenshot folder](../../../screenshots/03-discovery/)
- [Evidence manifest](../../../screenshots/evidence-manifest.csv)
