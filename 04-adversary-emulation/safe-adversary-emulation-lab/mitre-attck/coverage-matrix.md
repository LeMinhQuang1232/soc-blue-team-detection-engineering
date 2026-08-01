# ATT&CK Coverage Matrix

| Technique | Telemetry | Detection | Cleanup | Coverage |
|---|---|---|---|---|
| T1059.001 | Sysmon, LimaCharlie, Wazuh | Wazuh 92057 | Process check | Validated |
| T1082 | Sysmon, LimaCharlie, Wazuh | Searchable endpoint/SIEM events | No persistent artifact | Validated |
| T1016 | Sysmon, LimaCharlie, Wazuh | Wazuh 100140 | Transcript/result cleanup | Validated |
| T1087 | Sysmon, Wazuh | Wazuh 92032 | No persistent artifact | Validated |
| T1110 | Security 4625, Wazuh | Repeated failed-logon events | User/session removed | Validated |
| T1105 | Sysmon 11, Wazuh, Nginx, Zeek | Wazuh 100150 | Client/server file removed | Validated |
| T1046 | pfSense, Zeek, Python, Wazuh, Suricata review | Wazuh 100201; Suricata attribution partial | Result files removed | Partial |
