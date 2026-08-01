# Safe Test Catalog

| Test ID | Test | Primary telemetry | Status |
|---|---|---|---|
| [P4-EXEC-01](endpoint-execution/P4-EXEC-01/README.md) | Benign encoded PowerShell | Sysmon, LimaCharlie, Wazuh | Validated |
| [P4-DISC-01](system-discovery/P4-DISC-01/README.md) | System information discovery | Sysmon, LimaCharlie, Wazuh | Validated |
| [P4-DISC-02](network-discovery/P4-DISC-02/README.md) | Network configuration and connection discovery | Sysmon, LimaCharlie, Wazuh | Validated |
| [P4-DISC-03](system-discovery/P4-DISC-03/README.md) | Account and policy discovery | Sysmon, Wazuh | Validated |
| [P4-AUTH-01](authentication/P4-AUTH-01/README.md) | Controlled failed authentication | Windows Security, Wazuh | Validated |
| [P4-FILE-01](file-creation/P4-FILE-01/README.md) | Controlled HTTP file transfer | Sysmon, Wazuh, Nginx, Zeek | Validated |
| [P4-NET-01](controlled-network-traffic/P4-NET-01/README.md) | Service probing and detector replay | pfSense, Zeek, Python, Wazuh, Suricata review | Partial |
| [P4-EICAR-01](eicar-validation/P4-EICAR-01/README.md) | Antivirus detection and quarantine | Defender, Wazuh | Validated |
