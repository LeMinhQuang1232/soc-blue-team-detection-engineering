# Expected and Observed Telemetry Matrix

| Activity | Expected telemetry | Observed telemetry | Result |
|---|---|---|---|
| Failed authentication | Windows Security, Wazuh | Event ID 4625 was captured; a dedicated expanded Wazuh authentication screenshot was not part of the final evidence set. | Passed for endpoint; SIEM evidence not separately expanded |
| Encoded PowerShell | Sysmon, Wazuh, LimaCharlie | Sysmon Event ID 1 query, Wazuh rule 92057, and LimaCharlie process telemetry. | Passed |
| System/account discovery | Process telemetry, Wazuh, LimaCharlie | Native command output and Wazuh rule 100132. | Passed |
| Network discovery | Process telemetry, Wazuh, LimaCharlie | ipconfig, route, arp, netstat, Get-NetTCPConnection, and Wazuh rule 100140. | Passed |
| Bounded service probe | PCAP, Zeek, Suricata, Python, pfSense | Execution transcript proves twelve ports; initial Zeek/Python artifacts observed only part of the activity; Suricata attribution was noisy. | Partial |
| Benign HTTP download | Curl, Nginx, Zeek HTTP, Wazuh | 43-byte file download, Nginx log, Zeek HTTP entry, and Wazuh rule 100154. | Passed |
| SQLi-like URI | Nginx, Zeek HTTP, Suricata/Wazuh where configured | Nginx returned 404; Zeek HTTP recorded the URI; Wazuh rule 100130 alerted. | Passed |
| Endpoint isolation | LimaCharlie task and failed normal connectivity | `segregate_network` succeeded; normal tested connectivity stopped. | Passed |
| Sensor continuity | LimaCharlie management response | Sensor returned system information during isolation. | Passed |
| Recovery | LimaCharlie rejoin, Wazuh agent/network validation | `rejoin_network` succeeded and normal connectivity returned. | Passed |
| Retest | Repeated endpoint/SIEM/EDR/application evidence | Wazuh and LimaCharlie evidence repeated; network behavioral attribution remained partial. | Passed with limitation |
