# Evidence Log

> Timestamp note: Windows Event Viewer, Sysmon UTC fields, Ubuntu logs, and the Wazuh dashboard use different time displays. Values below are preserved as shown in the evidence.

## Test ID: NET-001

- Date: 2026-07-16
- Source host: WIN-ENDPOINT
- Source IP: 192.168.56.20
- Destination host: SOC-WAZUH
- Destination IP: 192.168.56.10
- Action: Send four ICMP echo requests from Windows to Ubuntu
- Result: Four replies, 0% packet loss, approximately 2 ms average
- Screenshot: `screenshots/windows/06-windows-ping-ubuntu.png`
- Analyst note: Confirms Host-Only network connectivity.

## Test ID: WAZ-001

- Date: 2026-07-16
- Source host: WIN-ENDPOINT
- Destination host: SOC-WAZUH
- Destination IP: 192.168.56.10
- Action: Test TCP ports 443, 1514, and 1515
- Result: `TcpTestSucceeded: True` for all three ports
- Screenshot: `screenshots/windows/16-port-connectivity-443-1514-1515.png`
- Analyst note: Confirms dashboard access, event communication, and agent enrollment connectivity.

## Test ID: WAZ-002

- Date: 2026-07-16
- Agent name: WIN-ENDPOINT
- Agent ID: 001
- Agent IP: 192.168.56.20
- Operating system: Microsoft Windows Server 2022 Datacenter Evaluation
- Agent version: 4.14.6
- Group: default
- Cluster node: node01
- Result: Active
- Screenshots:
  - `screenshots/wazuh/17-windows-agent-active.png`
  - `screenshots/windows/18-wazuh-agent-service-running.png`
- Analyst note: The manager and agent versions match.

## Test ID: WIN-001

- Date: 2026-07-16
- Source host: WIN-ENDPOINT
- Destination host: WIN-ENDPOINT
- Subject account: Administrator
- Target account: soclab
- Action: Generate three intentional failed local authentication attempts
- Data source: Windows Security Log
- Event ID: 4625
- Local TimeCreated values: 08:38:22, 08:38:28, 08:38:35
- Wazuh timestamps: 23:38:22.235, 23:38:28.830, 23:38:35.384
- Authentication package: Negotiate
- Logon process: seclogo
- Status: 0xC000006D
- SubStatus: 0xC000006A
- Source address shown in event data: `::1`
- Wazuh agent: WIN-ENDPOINT / 001
- Wazuh rule ID: 60122
- Wazuh rule description: Logon Failure - Unknown user or bad password
- Wazuh rule level: 5
- Result: Observed locally and in Wazuh
- Screenshots:
  - `screenshots/windows/31-windows-event4625-local.png`
  - `screenshots/wazuh/28-wazuh-event4625-summary.png`
  - `screenshots/wazuh/30-wazuh-event4625-details.png`
- Analyst note: The failures were intentionally generated inside the lab.

## Test ID: WIN-002

- Date: 2026-07-16
- Source host: WIN-ENDPOINT
- Destination host: WIN-ENDPOINT
- Subject account: Administrator
- Target account: soclab
- Action: Complete a controlled successful local logon
- Data source: Windows Security Log
- Event ID: 4624
- Logon type: 2
- Authentication package: Negotiate
- Logon process: seclogo
- Source address shown in Wazuh: `::1`
- Wazuh agent: WIN-ENDPOINT / 001
- Wazuh rule ID: 60118
- Wazuh rule description: Windows Workstation Logon Success
- Wazuh rule level: 3
- Result: Observed locally and in Wazuh
- Screenshots:
  - `screenshots/windows/32-windows-event4624-local.png`
  - `screenshots/wazuh/29-wazuh-event4624-summary.png`
  - `screenshots/wazuh/33-wazuh-event4624-details.png`
- Analyst note: This event was used as the successful comparison after the failed attempts.

## Test ID: SYS-001

- Date: 2026-07-16 to 2026-07-17
- Source host: WIN-ENDPOINT
- Action: Run `curl.exe` from PowerShell and verify Sysmon process-creation collection
- Data source: `Microsoft-Windows-Sysmon/Operational`
- Event ID: 1

### Local event details

- Windows display time: 2026-07-16 08:41:10
- Sysmon UtcTime: 2026-07-16 15:41:10.171
- ProcessGuid: `{fff77edd-fb96-6a58-9102-000000000800}`
- ProcessId: 4824
- Image: `C:\Windows\System32\curl.exe`
- Command line: `"C:\Windows\system32\curl.exe" http://192.168.56.10/`
- Parent image: `C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe`
- ParentProcessId: 1740
- User: `WIN-ENDPOINT\Administrator`
- SHA256: `3A6E75332364B4C2CE8336CE0E4127A199C0758B09DA1E97D990214EF2D559CA`
- Local screenshot: `screenshots/windows/25-sysmon-event1-curl.png`

### Wazuh validation

- Query filter: agent `WIN-ENDPOINT`, Sysmon Operational channel, Event ID `1`
- Search period: Jul 16, 2026 16:40:28.935 to Jul 17, 2026 16:40:28.935
- Result count: 61 hits
- Example Wazuh rule shown: 61618
- Example description: `Sysmon - Suspicious Process - svchost.exe`
- Example level: 12
- Wazuh screenshot: `screenshots/wazuh/45-wazuh-sysmon-event1-summary.png`
- Result: Confirmed locally and in Wazuh
- Analyst note: The local screenshot documents the controlled `curl.exe` test. The Wazuh screenshot confirms ingestion of Event ID 1 from the same endpoint and channel.

## Test ID: SYS-002

- Date: 2026-07-16 to 2026-07-17
- Source host: WIN-ENDPOINT
- Action: Create a harmless desktop file and verify Sysmon file-creation collection
- Data source: `Microsoft-Windows-Sysmon/Operational`
- Event ID: 11

### Local event details

- Windows display time: 2026-07-16 08:51:19
- Sysmon UtcTime: 2026-07-16 15:51:19.157
- ProcessGuid: `{fff77edd-fb96-6a58-0a02-000000000800}`
- ProcessId: 1740
- Image: `C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe`
- User: `WIN-ENDPOINT\Administrator`
- TargetFilename: `C:\Users\Administrator\Desktop\soc-lab-test.txt`
- Local screenshot: `screenshots/windows/27-sysmon-event11-file-create.png`

### Wazuh validation

- Query filter: agent `WIN-ENDPOINT`, Sysmon Operational channel, Event ID `11`
- Search period: Jul 16, 2026 16:41:06.076 to Jul 17, 2026 16:41:06.076
- Result count: 56 hits
- Example rules shown: 92213, 92217, and 92201
- Example descriptions include executable-file and scripting-file creation alerts
- Example levels shown: 15, 6, and 9
- Wazuh screenshot: `screenshots/wazuh/46-wazuh-sysmon-event11-summary.png`
- Result: Confirmed locally and in Wazuh
- Analyst note: The local screenshot documents the controlled test file. The Wazuh screenshot confirms ingestion of Event ID 11 from the same endpoint and channel.

## Test ID: LIN-001

- Date: 2026-07-17
- Time zone: +0700 in Ubuntu log
- Source host: WIN-ENDPOINT
- Source IP: 192.168.56.20
- Source port: 49919
- Destination host: SOC-WAZUH
- Destination IP: 192.168.56.10
- Username: soclab
- Action: Enter three incorrect SSH passwords
- Data source: Ubuntu authentication log and Wazuh
- SSH process ID: 22425
- Wazuh agent: SOC-WAZUH / 000
- Decoder: sshd
- Wazuh rule ID: 5760
- Wazuh rule description: sshd: authentication failed.
- Wazuh rule level: 5
- MITRE ATT&CK: T1110.001, T1021.004
- Full log: `Jul 17 08:31:09 SOC-WAZUH sshd[22425]: Failed password for soclab from 192.168.56.20 port 49919 ssh2`
- Result: Observed locally and in Wazuh
- Screenshots:
  - `screenshots/ubuntu/35-ubuntu-auth-log.png`
  - `screenshots/windows/36-windows-ssh-test.png`
  - `screenshots/wazuh/40-wazuh-ssh-failure-details.png`
- Analyst note: The failed logins were intentional lab activity.

## Test ID: LIN-002

- Date: 2026-07-17
- Source host: WIN-ENDPOINT
- Source IP: 192.168.56.20
- Source port: 49920
- Destination host: SOC-WAZUH
- Destination IP: 192.168.56.10
- Username: soclab
- Action: Complete a successful SSH password login
- Data source: Ubuntu authentication log and Wazuh
- SSH process ID: 22492
- Wazuh agent: SOC-WAZUH / 000
- Decoder: sshd
- Wazuh rule ID: 5715
- Wazuh rule description: sshd: authentication success.
- Wazuh rule level: 3
- MITRE ATT&CK: T1078, T1021
- Full log: `Jul 17 08:31:16 SOC-WAZUH sshd[22492]: Accepted password for soclab from 192.168.56.20 port 49920 ssh2`
- Result: Observed in the SSH session and in Wazuh
- Screenshots:
  - `screenshots/windows/36-windows-ssh-test.png`
  - `screenshots/wazuh/39-wazuh-ssh-success-details.png`
- Analyst note: This successful login was used as a comparison event.

## Test ID: WEB-001

- Date: 2026-07-17
- Time zone: +0700
- Client IP: 192.168.56.20
- Timestamp: 15:45:32
- Method: GET
- URI: `/notfound`
- Status code: 404
- Response bytes: 162
- User-Agent: curl/7.79.1
- Data source: `/var/log/nginx/access.log`
- Result: Observed in the local Nginx log
- Screenshot: `screenshots/ubuntu/41-nginx-access-log.png`
- Analyst note: A normal web request can be logged without becoming a security alert.

## Test ID: WEB-002

- Date: 2026-07-17
- Time zone: +0700 in the Nginx log
- Client IP: 192.168.56.20
- Timestamp: 15:46:43
- Method: GET
- URI: `/search?q=%27%20OR%201%3D1--`
- Status code: 404
- Response bytes: 162
- User-Agent: curl/7.79.1
- Data source: `/var/log/nginx/access.log`
- Wazuh agent: SOC-WAZUH / 000
- Decoder: web-accesslog
- Wazuh rule ID: 31164
- Wazuh rule description: SQL injection attempt.
- Wazuh rule level: 6
- Compliance mapping shown: GDPR IV_35.7.d
- Full log: `192.168.56.20 - - [17/Jul/2026:15:46:43 +0700] "GET /search?q=%27%20OR%201%3D1-- HTTP/1.1" 404 162 "-" "curl/7.79.1"`
- Result: Observed locally and alerted in Wazuh
- Screenshots:
  - `screenshots/ubuntu/41-nginx-access-log.png`
  - `screenshots/windows/42-windows-nginx-http-tests.png`
  - `screenshots/wazuh/43-wazuh-sqli-alert-summary.png`
  - `screenshots/wazuh/44-wazuh-sqli-alert-details.png`
- Analyst note: This was a safe pattern-matching test. The 404 response does not show successful exploitation.
