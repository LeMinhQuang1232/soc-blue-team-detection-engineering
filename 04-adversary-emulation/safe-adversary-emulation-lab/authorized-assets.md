# Authorized Assets

| Asset | Role | Authorized Activity |
|---|---|---|
| WIN-ENDPOINT | Test source | PowerShell, discovery, authentication, file, and EICAR tests |
| SOC-WAZUH / Ubuntu DMZ | SIEM and network target | Wazuh collection, Nginx, tcpdump, Zeek, Suricata, Python detector |
| pfSense | Segmentation gateway | Firewall policy and log validation |
| LimaCharlie tenant/sensor | EDR telemetry | Process-event investigation |
| VirtualBox snapshots | Recovery control | Restore owned lab VMs only |
