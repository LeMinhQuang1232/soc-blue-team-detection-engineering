# Lab Environment

| Component | Address / Version | Role |
|---|---|---|
| WIN-ENDPOINT | `192.168.10.10` | Authorized Windows test endpoint |
| Windows OS | Windows Server 2022 Datacenter Evaluation, build 20348 | Security, Sysmon, Defender, PowerShell, Atomic Red Team |
| SOC-WAZUH / Ubuntu DMZ | `192.168.20.10` | Wazuh, Nginx, Suricata, Zeek offline analysis, Python detector |
| Wazuh | Agent/manager evidence shows v4.14.6 | Event collection, custom rules, hunting, alert investigation |
| LimaCharlie | Sensor service `rphcpsvc` | Endpoint process telemetry |
| Sysmon | `Sysmon64` service | Process and file telemetry |
| Atomic Red Team | Invoke-AtomicTest module 2.3.0 | Controlled ATT&CK-aligned tests |
| Suricata | Configuration output shows 8.0.6 RELEASE | IDS and EVE JSON |
| Zeek | Offline PCAP analysis with JSON logs | Network metadata |
| pfSense | USER_NET / DMZ_NET / SOC_ADMIN | Segmentation and firewall logging |
| Nginx | TCP 80/443 | Controlled HTTP target |

## Time Zone

Evidence timestamps were interpreted in `Asia/Ho_Chi_Minh` (`UTC+07:00`) unless a tool displayed a different normalized format.
