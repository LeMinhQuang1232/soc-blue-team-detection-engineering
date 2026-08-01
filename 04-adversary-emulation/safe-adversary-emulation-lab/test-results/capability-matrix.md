# Capability Matrix

| Capability | Telemetry available | Detection exists | Response / cleanup | Status |
|---|---|---|---|---|
| Encoded PowerShell | Sysmon, LimaCharlie, Wazuh | Yes: 92057 | Process verification | Validated |
| System information discovery | Sysmon, LimaCharlie, Wazuh | Searchable telemetry | No persistent artifact | Validated |
| Network discovery | Sysmon, LimaCharlie, Wazuh | Yes: 100140 | Output cleanup | Validated |
| Account discovery | Sysmon, Wazuh | Yes: 92032 | No persistent artifact | Validated |
| Failed authentication | Security, Wazuh | Yes: repeated failure events | Session/user removal | Validated |
| Controlled file transfer | Sysmon, Wazuh, Nginx, Zeek | Yes: 100150 | Client/server file removal | Validated |
| Network reconnaissance | pfSense, Zeek, Python, Wazuh, Suricata review | Yes: 100201; IDS attribution incomplete | Result cleanup | Partial |
| Antivirus protection | Defender, Wazuh | Yes: 1116/1117 and 62123/62124 | Quarantine and file absence | Validated |
| Endpoint containment | Foundation LimaCharlie lab only | Existing capability | Not executed in this phase | Reuse in Purple Team |
