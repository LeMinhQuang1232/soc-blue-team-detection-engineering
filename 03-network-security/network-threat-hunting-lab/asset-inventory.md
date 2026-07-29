# Asset Inventory

| Asset | Address | Role | Evidence generated |
|---|---|---|---|
| Windows USER endpoint | `192.168.10.10` | Controlled source for web requests, host discovery, service probing, and SYN scanning | Nmap/curl output and traffic |
| pfSense USER gateway | `192.168.10.1` | Routes and filters USER traffic | Rule screenshots and firewall logs |
| Ubuntu DMZ / SOC-WAZUH | `192.168.20.10` | Nginx target, packet sensor, offline analysis host, Python detector, Wazuh manager | PCAP, Zeek, Suricata, JSON alerts, SIEM alerts |
| pfSense DMZ gateway | `192.168.20.1` | DMZ routing and enforcement | Firewall policy context |
| SOC_ADMIN endpoint role | `192.168.30.10` | Approved administration comparison | Prior foundation validation |
