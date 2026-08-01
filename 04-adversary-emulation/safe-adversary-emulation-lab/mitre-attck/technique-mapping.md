# MITRE ATT&CK Technique Mapping

| Test | Technique | Evidence interpretation |
|---|---|---|
| P4-EXEC-01 | T1059.001 PowerShell | Encoded PowerShell process; Wazuh 92057 level 12 |
| P4-DISC-01 | T1082 System Information Discovery | `systeminfo` and associated process telemetry |
| P4-DISC-02 | T1016 System Network Configuration Discovery | Windows network commands; Wazuh 100140 level 8 |
| P4-DISC-03 | T1087 Account Discovery; T1059.003 Windows Command Shell | Wazuh 92032 mapping for the account/policy query |
| P4-AUTH-01 | T1110 Brute Force, simulated in a controlled local context | Repeated wrong-password events; no credential compromise |
| P4-FILE-01 | T1105 Ingress Tool Transfer | Harmless curl download; Wazuh 100150 level 8 |
| P4-NET-01 | T1046 Network Service Discovery | Service probe plus replayed scan detector output |
| P4-EICAR-01 | Not assigned as attacker behavior | Defensive antivirus validation only |

ATT&CK mappings describe observed or simulated behavior. They do not prove malicious intent or compromise.
