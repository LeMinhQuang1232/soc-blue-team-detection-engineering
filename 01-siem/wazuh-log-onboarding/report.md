# Wazuh Windows and Linux Log Onboarding Report

## 1. Executive Summary

This project built a local Wazuh SIEM lab in Oracle VirtualBox. Wazuh 4.14.6 was deployed as an all-in-one installation on an Ubuntu virtual machine named `SOC-WAZUH`. A Windows Server 2022 endpoint named `WIN-ENDPOINT` was connected with the Wazuh agent and Sysmon.

The lab successfully collected and validated:

- Windows successful and failed authentication events.
- Sysmon process-creation and file-creation events.
- Ubuntu failed and successful SSH authentication events.
- Nginx web access logs.
- A Wazuh alert for a safe SQL injection test pattern.

All testing was performed inside a private VirtualBox network. No malware, destructive payloads, or external targets were used.

## 2. Project Objectives

- Deploy the Wazuh manager, indexer, dashboard, and Filebeat.
- Configure stable NAT and Host-Only networking.
- Onboard a Windows endpoint with the Wazuh agent.
- Install Sysmon and collect its Operational event channel.
- Collect Windows Security Event IDs 4624 and 4625.
- Collect Sysmon Event IDs 1 and 11.
- Collect Ubuntu SSH authentication logs.
- Collect Nginx access logs.
- Validate events locally and through Wazuh.
- Produce clear SOC-style technical documentation and evidence.

## 3. Scope

### In Scope

- One Ubuntu virtual machine.
- One Windows Server 2022 virtual machine.
- Wazuh all-in-one deployment.
- Windows Security logs.
- Sysmon process and file telemetry.
- Ubuntu SSH authentication logs.
- Nginx web access logs.
- Safe, controlled activity generation.

### Out of Scope

- Real malware.
- External targets.
- Production deployment.
- High availability.
- Custom Wazuh detection rules.
- Automatic containment or active response.
- Destructive testing.

## 4. Lab Architecture

```text
                    Oracle VirtualBox Host
                  Host-Only: 192.168.56.1/24
                              |
             +----------------+----------------+
             |                                 |
      SOC-WAZUH                          WIN-ENDPOINT
      Ubuntu 24.04.4 LTS                 Windows Server 2022
      192.168.56.10                      192.168.56.20
             |                                 |
      Wazuh all-in-one                  Wazuh agent 001
      OpenSSH and Nginx                 Sysmon and Security Log
```

Both virtual machines used two network adapters:

1. NAT for internet access.
2. Host-Only for stable lab communication.

The Host-Only interfaces had no default gateway, so the NAT route remained the default internet route.

## 5. Environment

| Component | Configuration |
|---|---|
| Hypervisor | Oracle VirtualBox |
| Ubuntu hostname | SOC-WAZUH |
| Ubuntu OS | Ubuntu 24.04.4 LTS |
| Ubuntu Host-Only IP | 192.168.56.10 |
| Ubuntu resources | 4 vCPU, 8 GB RAM, 60 GB disk |
| Windows hostname | WIN-ENDPOINT |
| Windows OS | Windows Server 2022 Datacenter Evaluation |
| Windows build | 10.0.20348.587 |
| Windows Host-Only IP | 192.168.56.20 |
| Windows resources | 2 vCPU, 4 GB RAM |
| SIEM | Wazuh 4.14.6 |
| Endpoint telemetry | Sysmon |
| Web server | Nginx |
| Authentication service | OpenSSH |

## 6. Network Configuration

| Device | Interface | Address | Gateway | Purpose |
|---|---|---|---|---|
| Host | Host-Only | 192.168.56.1/24 | N/A | Lab management |
| SOC-WAZUH | NAT | 10.0.2.15/24 | 10.0.2.2 | Internet access |
| SOC-WAZUH | Host-Only | 192.168.56.10/24 | None | Wazuh and server traffic |
| WIN-ENDPOINT | NAT | 10.0.2.15/24 | 10.0.2.2 | Internet access |
| WIN-ENDPOINT | Host-Only | 192.168.56.20/24 | None | Agent and test traffic |

A ping test from Windows to Ubuntu returned four replies with 0% packet loss.

Windows also successfully connected to:

- TCP 443 for the Wazuh dashboard.
- TCP 1514 for agent event communication.
- TCP 1515 for agent enrollment.

## 7. Wazuh Deployment

### Installation

Wazuh was deployed as an all-in-one installation on `SOC-WAZUH`.

The installation included:

- Wazuh manager.
- Wazuh indexer.
- Wazuh dashboard.
- Filebeat.

The confirmed Wazuh version was 4.14.6.

### Service status

The following services were active:

| Service | Status |
|---|---|
| wazuh-manager | Active |
| wazuh-indexer | Active |
| wazuh-dashboard | Active |
| filebeat | Active |

### Listening ports

| Port | Purpose | Result |
|---:|---|---|
| TCP 443 | Dashboard | Listening and reachable |
| TCP 1514 | Agent communication | Listening and reachable |
| TCP 1515 | Agent enrollment | Listening and reachable |
| TCP 55000 | Wazuh API | Listening locally |

### Dashboard

The dashboard was accessed at:

```text
https://192.168.56.10
```

The dashboard connected to the local Wazuh API at `https://127.0.0.1:55000`.

## 8. Windows Agent Deployment

| Field | Value |
|---|---|
| Agent name | WIN-ENDPOINT |
| Agent ID | 001 |
| Agent IP | 192.168.56.20 |
| Manager IP | 192.168.56.10 |
| Agent version | 4.14.6 |
| Group | default |
| Cluster node | node01 |
| Status | Active |
| Windows service | WazuhSvc, Running |

The endpoint appeared as Active in Wazuh. The agent and manager used the same Wazuh version.

Sysmon was installed and running. Its Operational event channel provided process-creation and file-creation telemetry.

## 9. Data Sources

| Data source | Important events | Purpose |
|---|---|---|
| Windows Security Log | 4624, 4625 | Successful and failed authentication monitoring |
| Sysmon | 1, 11 | Process and file activity visibility |
| Ubuntu authentication logs | Failed and accepted SSH | Linux authentication monitoring |
| Nginx access log | HTTP requests | Web activity monitoring |

## 10. Validation Tests

| Test ID | Activity | Expected result | Actual result | Status |
|---|---|---|---|---|
| NET-001 | Ping Ubuntu from Windows | ICMP replies | Four replies, 0% packet loss | Pass |
| WAZ-001 | Test ports 443, 1514, and 1515 | Connections succeed | All tests succeeded | Pass |
| WAZ-002 | Check Windows agent | Active agent | Agent 001 was Active | Pass |
| WIN-001 | Generate failed Windows logons | Event ID 4625 | Seen locally and in Wazuh | Pass |
| WIN-002 | Generate successful Windows logon | Event ID 4624 | Seen locally and in Wazuh | Pass |
| SYS-001 | Run a benign process | Sysmon Event ID 1 | Seen locally and in Wazuh | Pass |
| SYS-002 | Create a harmless file | Sysmon Event ID 11 | Seen locally and in Wazuh | Pass |
| LIN-001 | Enter incorrect SSH passwords | Failed SSH event | Seen locally and in Wazuh | Pass |
| LIN-002 | Complete a valid SSH login | Successful SSH event | Seen in the session and Wazuh | Pass |
| WEB-001 | Request `/notfound` | Nginx 404 entry | Seen in access.log | Pass |
| WEB-002 | Send a safe SQL injection pattern | Wazuh web alert | Rule 31164 triggered | Pass |

## 11. Evidence Analysis

### 11.1 Windows Failed Logon

| Field | Value |
|---|---|
| Event ID | 4625 |
| Target account | soclab |
| Subject account | Administrator |
| Authentication package | Negotiate |
| Logon process | seclogo |
| Status | 0xC000006D |
| SubStatus | 0xC000006A |
| Source address shown | `::1` |
| Wazuh rule | 60122 |
| Rule level | 5 |

Three failed authentication attempts were intentionally generated. The events appeared in the local Windows Security Log and in Wazuh.

The Wazuh description was `Logon Failure - Unknown user or bad password`. The event provides useful information for account monitoring and repeated-failure detection.

Evidence:

- `screenshots/windows/31-windows-event4625-local.png`
- `screenshots/wazuh/28-wazuh-event4625-summary.png`
- `screenshots/wazuh/30-wazuh-event4625-details.png`

### 11.2 Windows Successful Logon

| Field | Value |
|---|---|
| Event ID | 4624 |
| Target account | soclab |
| Logon type | 2 |
| Authentication package | Negotiate |
| Wazuh rule | 60118 |
| Rule level | 3 |

A successful local logon was generated after the failed attempts. It appeared locally and in Wazuh as `Windows Workstation Logon Success`.

This event can be used later to build a detection for a successful login after several failures.

Evidence:

- `screenshots/windows/32-windows-event4624-local.png`
- `screenshots/wazuh/29-wazuh-event4624-summary.png`
- `screenshots/wazuh/33-wazuh-event4624-details.png`

### 11.3 Sysmon Process Creation

| Field | Value |
|---|---|
| Event ID | 1 |
| Image | `C:\Windows\System32\curl.exe` |
| Command line | `curl.exe http://192.168.56.10/` |
| Parent image | PowerShell |
| User | `WIN-ENDPOINT\Administrator` |
| SHA256 | `3A6E75332364B4C2CE8336CE0E4127A199C0758B09DA1E97D990214EF2D559CA` |

The local Sysmon event showed `curl.exe` launched by PowerShell. Sysmon added process-level details that are not available in a basic authentication event, including the executable path, command line, parent process, user, and file hash.

A Wazuh Threat Hunting query filtered the `WIN-ENDPOINT` agent, the Sysmon Operational channel, and Event ID 1. The query returned 61 hits, confirming that Wazuh was ingesting process-creation events from the endpoint.

Evidence:

- `screenshots/windows/25-sysmon-event1-curl.png`
- `screenshots/wazuh/45-wazuh-sysmon-event1-summary.png`

### 11.4 Sysmon File Creation

| Field | Value |
|---|---|
| Event ID | 11 |
| Image | PowerShell |
| User | `WIN-ENDPOINT\Administrator` |
| Target file | `C:\Users\Administrator\Desktop\soc-lab-test.txt` |

A harmless file named `soc-lab-test.txt` was created on the Windows desktop. The local Sysmon event recorded the responsible process, user, and target file path.

A Wazuh Threat Hunting query filtered the same endpoint, Sysmon channel, and Event ID 11. The query returned 56 hits. The visible results included file-creation rules with levels 6, 9, and 15, confirming that Wazuh was ingesting and evaluating Sysmon file events.

Evidence:

- `screenshots/windows/27-sysmon-event11-file-create.png`
- `screenshots/wazuh/46-wazuh-sysmon-event11-summary.png`

### 11.5 Ubuntu SSH Authentication

#### Failed login

| Field | Value |
|---|---|
| Source IP | 192.168.56.20 |
| Username | soclab |
| Source port | 49919 |
| Wazuh rule | 5760 |
| Rule level | 5 |
| Decoder | sshd |
| MITRE ATT&CK | T1110.001, T1021.004 |

Three incorrect SSH passwords were entered from the Windows endpoint. Ubuntu recorded the source IP, username, port, and failure result. Wazuh decoded the activity and generated an authentication-failure alert.

#### Successful login

| Field | Value |
|---|---|
| Source IP | 192.168.56.20 |
| Username | soclab |
| Source port | 49920 |
| Wazuh rule | 5715 |
| Rule level | 3 |
| Decoder | sshd |
| MITRE ATT&CK | T1078, T1021 |

A valid SSH login was completed after the failed attempts. Wazuh recorded it as an authentication success.

Evidence:

- `screenshots/ubuntu/35-ubuntu-auth-log.png`
- `screenshots/windows/36-windows-ssh-test.png`
- `screenshots/wazuh/39-wazuh-ssh-success-details.png`
- `screenshots/wazuh/40-wazuh-ssh-failure-details.png`

### 11.6 Nginx Web Access and SQL Injection Pattern

#### Normal 404 request

| Field | Value |
|---|---|
| Client IP | 192.168.56.20 |
| Method | GET |
| URI | `/notfound` |
| Status | 404 |
| User-Agent | curl/7.79.1 |

The request appeared in `/var/log/nginx/access.log`. This shows the difference between a raw application log and a security alert: a normal request can be collected without matching a detection rule.

#### Safe SQL injection pattern

| Field | Value |
|---|---|
| Client IP | 192.168.56.20 |
| URI | `/search?q=%27%20OR%201%3D1--` |
| HTTP status | 404 |
| Decoder | web-accesslog |
| Wazuh rule | 31164 |
| Rule level | 6 |
| Description | SQL injection attempt. |

The encoded SQL injection pattern was sent only to the local Nginx server. It produced a 404 response, so no exploitation was demonstrated. Wazuh matched the request pattern and generated a level-6 alert.

Evidence:

- `screenshots/ubuntu/41-nginx-access-log.png`
- `screenshots/windows/42-windows-nginx-http-tests.png`
- `screenshots/wazuh/43-wazuh-sqli-alert-summary.png`
- `screenshots/wazuh/44-wazuh-sqli-alert-details.png`

## 12. Findings

- Stable Host-Only IP addresses made agent enrollment and dashboard access reliable.
- The Windows endpoint successfully communicated with Wazuh over the required ports.
- Windows Security logs provided clear authentication visibility.
- Sysmon added process, command-line, parent-process, hash, and file-path context.
- Wazuh successfully ingested Sysmon Event IDs 1 and 11 from the Windows endpoint.
- Ubuntu logs recorded both failed and successful SSH authentication events.
- Nginx logs recorded client IP, URI, status code, and User-Agent information.
- A raw web log does not always become an alert; the event must match a rule.
- The safe SQL injection pattern matched Wazuh rule 31164.

## 13. Issues and Troubleshooting

| Issue | Explanation | Resolution or lesson |
|---|---|---|
| Dashboard or agent connectivity must be verified | Ping alone does not prove that required TCP ports are open | Tested ports 443, 1514, and 1515 with `Test-NetConnection` |
| Normal Nginx request did not create an alert | Raw logs and security alerts are different | Confirmed the raw log first, then used a safe SQL injection pattern that matched a rule |
| Timestamps used different formats | Windows, Sysmon, Ubuntu, and Wazuh displayed time differently | Preserve the source timestamp and use one standard time zone in future labs |
| Installer screenshots exposed a generated password | Screenshots can contain sensitive credentials | Removed those screenshots before preparing the GitHub package |

## 14. Limitations

- The Ubuntu VM also hosted all central Wazuh components.
- The lab used safe simulated events instead of real attacks.
- No custom Wazuh rules were created.
- No automatic containment action was configured.
- The Sysmon Wazuh screenshots confirm event-ID ingestion through filtered search results. They do not claim that a visible row is the exact local `curl.exe` or test-file event.
- The environment was designed for learning, not production use.

## 15. Security Considerations

- Testing was limited to the private VirtualBox network.
- No external systems were targeted.
- No malware or destructive payload was executed.
- Wazuh credentials were excluded from the repository.
- Private keys, passwords, product keys, and personal information should never be committed to GitHub.
- The included `.gitignore` blocks several common sensitive file types and names.

## 16. Lessons Learned

- Plan the network before installing agents.
- Use stable IP addresses for SIEM communication.
- Verify logs locally before troubleshooting the SIEM.
- Confirm both service status and network port connectivity.
- Windows Security logs provide authentication context.
- Sysmon provides deeper endpoint context.
- Raw logs and security alerts are not the same thing.
- Screenshots are evidence, but they must be reviewed for sensitive data before publication.

## 17. Next Steps

- Create a repeated Windows failed-logon detection.
- Detect a successful login after multiple failures.
- Create an SSH brute-force detection.
- Detect suspicious PowerShell command lines.
- Create custom Wazuh rules for selected Sysmon events.
- Map new detections to MITRE ATT&CK.
- Add an incident report based on one complete alert investigation.
- Normalize VM time settings for cleaner timelines.

## 18. Portfolio Description

Built a local Wazuh SIEM lab in Oracle VirtualBox, deploying the Wazuh manager, indexer, dashboard, and Filebeat on Ubuntu and onboarding a Windows Server 2022 endpoint with the Wazuh agent and Sysmon.

Collected and validated Windows authentication events, Sysmon process and file telemetry, Ubuntu SSH authentication logs, and Nginx web access logs. Generated safe test activity, analyzed Wazuh alerts, and documented the environment with SOC-style validation evidence and troubleshooting notes.
