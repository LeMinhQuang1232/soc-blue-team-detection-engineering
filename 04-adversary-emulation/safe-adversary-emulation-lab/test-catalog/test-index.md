# Safe Test Catalog Index

This index provides a reviewer-oriented summary of every controlled test. Select a test ID to open the full execution narrative, evidence gallery, telemetry analysis, limitations, and cleanup procedure.

| Test ID | Test | ATT&CK / control focus | Primary telemetry | Detection | Status |
|---|---|---|---|---|---|
| [P4-EXEC-01](endpoint-execution/P4-EXEC-01/README.md) | Benign Encoded PowerShell Execution | T1059.001 — PowerShell | Sysmon process creation, LimaCharlie process telemetry, Wazuh event ingestion | Wazuh rule `92057`, level 12 | **Validated** |
| [P4-DISC-01](system-discovery/P4-DISC-01/README.md) | System Information Discovery | T1082 — System Information Discovery | Process creation, command line, endpoint and Wazuh events | Searchable discovery telemetry | **Validated** |
| [P4-DISC-02](network-discovery/P4-DISC-02/README.md) | Network Configuration and Connection Discovery | T1016 — System Network Configuration Discovery; T1049 — System Network Connections Discovery; T1059.001/T1059.003 — command interpreters | Sysmon, LimaCharlie, Wazuh, PowerShell transcript and native output | Wazuh custom rule `100140`, level 8 | **Validated** |
| [P4-DISC-03](system-discovery/P4-DISC-03/README.md) | Password Policy and Account Context Discovery | Analyst mapping: T1201 — Password Policy Discovery; observed Wazuh metadata: T1087 and T1059.003 | Sysmon process creation and Wazuh events | Wazuh rule `92032` | **Validated** |
| [P4-AUTH-01](authentication/P4-AUTH-01/README.md) | Controlled Failed Authentication | T1110.001 — Password Guessing (controlled validation) | Windows Security log and Wazuh authentication events | Repeated failed-logon events and centralized investigation | **Validated** |
| [P4-FILE-01](file-creation/P4-FILE-01/README.md) | Controlled HTTP File Transfer and File Creation | T1105 — Ingress Tool Transfer (harmless laboratory artifact) | Sysmon Event ID 11, Wazuh, Nginx access log, Zeek conn.log/http.log | Wazuh custom rule `100150`, level 8 | **Validated** |
| [P4-NET-01](controlled-network-traffic/P4-NET-01/README.md) | Controlled Service Probing and Detector Replay | T1046 — Network Service Discovery | pfSense, packet capture, Zeek, Python detector, Wazuh, Suricata review | Python result and Wazuh rule `100201`; run-specific Suricata attribution incomplete | **Partial** |
| [P4-EICAR-01](eicar-validation/P4-EICAR-01/README.md) | Microsoft Defender EICAR Detection and Quarantine | Defensive control validation; no malware technique claimed | Microsoft Defender Operational log and Wazuh | Defender Event IDs `1116`/`1117`; Wazuh rules `62123`/`62124` | **Validated** |

## Validation Summary

- **Validated:** 7 tests
- **Partial:** 1 test (`P4-NET-01`)
- **Total evidence set:** 164 screenshots
- **Public evidence hygiene:** password-bearing and literal-EICAR screenshots are not embedded in the expanded catalog

## Quick Evidence Links

- [Endpoint execution screenshots](../screenshots/02-endpoint-execution/)
- [Discovery screenshots](../screenshots/03-discovery/)
- [Authentication screenshots](../screenshots/04-authentication/)
- [File-transfer screenshots](../screenshots/05-file-transfer/)
- [Network-validation screenshots](../screenshots/06-network-validation/)
- [EICAR-validation screenshots](../screenshots/07-eicar-validation/)
- [Cleanup and recovery screenshots](../screenshots/08-cleanup-and-recovery/)
- [Complete evidence index](../screenshots/evidence-index.md)
- [Evidence manifest with hashes](../screenshots/evidence-manifest.csv)

## Review Guidance

1. Treat telemetry availability and detection coverage as separate outcomes.
2. Preserve the difference between tool-provided ATT&CK metadata and analyst-reviewed mappings.
3. Do not promote historical Suricata records as current-run evidence.
4. Keep `P4-NET-01` partial until Suricata is validated with isolated output.
5. Confirm cleanup evidence before reusing a snapshot for another test.
