# Objective — P4-EICAR-01

Validate that Microsoft Defender detects and quarantines the EICAR standard test artifact and that both detection and remediation events are ingested into Wazuh.

### Success conditions

- Defender is enabled before and after the test.
- Event IDs `1116` and `1117` are present locally.
- Wazuh rules `62123` and `62124` are present.
- A timestamped retest reproduces the result.
- The artifact is absent and the public catalog does not expose the literal string.

## Scope

- Authorized source: WIN-ENDPOINT (`192.168.10.10`)
- Authorized target: Local endpoint protection
- Test category: Antivirus validation
- Recorded status: **Validated**

## Evidence Entry Points

- [Full test README and image gallery](README.md)
- [Complete screenshot folder](../../../screenshots/07-eicar-validation/)
- [Evidence manifest](../../../screenshots/evidence-manifest.csv)
