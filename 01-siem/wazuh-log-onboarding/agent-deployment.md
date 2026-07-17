# Windows Agent Deployment

| Field | Value |
|---|---|
| Agent name | WIN-ENDPOINT |
| Agent ID | 001 |
| Agent IP | 192.168.56.20 |
| Manager IP | 192.168.56.10 |
| Operating system | Microsoft Windows Server 2022 Datacenter Evaluation |
| Windows build | 10.0.20348.587 |
| Wazuh agent version | 4.14.6 |
| Group | default |
| Cluster node | node01 |
| Agent status | Active |
| Windows service | WazuhSvc, Running |

Windows connectivity tests succeeded for TCP ports 443, 1514, and 1515.

Sysmon was also installed and running on the endpoint. The `Microsoft-Windows-Sysmon/Operational` event channel was collected by the Wazuh agent.
