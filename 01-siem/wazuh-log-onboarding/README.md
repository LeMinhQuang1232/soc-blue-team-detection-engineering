# Wazuh Windows and Linux Log Onboarding

This project builds a small SOC lab in Oracle VirtualBox and uses Wazuh to collect security logs from Windows and Ubuntu.

The lab includes:

- One Ubuntu VM running the Wazuh manager, indexer, dashboard, Filebeat, OpenSSH, and Nginx.
- One Windows Server 2022 VM running the Wazuh agent and Sysmon.
- NAT networking for internet access.
- Host-Only networking for stable communication between the two VMs.

## What I Built

- A local Wazuh all-in-one SIEM environment on Ubuntu Server.
- A Windows endpoint running the Wazuh agent and Sysmon.
- Collection pipelines for Windows Security events, Sysmon telemetry, Linux authentication logs, and Nginx access logs.
- Controlled validation tests for authentication failures, process execution, network connections, file creation, SSH activity, and HTTP requests.
- Evidence logs linking raw host activity to events visible in Wazuh.

## What I Learned

- Successful agent installation does not guarantee complete telemetry; each event channel must be enabled and validated separately.
- Raw host logs should be compared with normalized SIEM events before trusting dashboards or detection logic.
- Network reachability, service health, time synchronization, and log permissions directly affect log ingestion.
- Good onboarding documentation should record the source host, timestamp, event identifier, data source, observed result, and supporting evidence.

## Project results

The following activities were successfully validated:

- Windows could reach the Ubuntu VM and the required Wazuh ports.
- The Windows agent connected to Wazuh and showed an Active status.
- Windows Security Event IDs 4624 and 4625 appeared locally and in Wazuh.
- Sysmon Event ID 1 process-creation logs appeared locally and in Wazuh.
- Sysmon Event ID 11 file-creation logs appeared locally and in Wazuh.
- Failed and successful SSH logins appeared in Ubuntu logs and Wazuh.
- Nginx recorded requests from the Windows endpoint.
- A safe SQL injection test pattern triggered Wazuh rule 31164.

## Lab architecture

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

## Main documents

- [Full project report](report.md)
- [Architecture](architecture.md)
- [IP plan](ip-plan.md)
- [Setup notes](setup.md)
- [Windows agent deployment](agent-deployment.md)
- [Data sources](data-sources.md)
- [Validation tests](validation-tests.md)
- [Evidence log](evidence-log.md)
- [Troubleshooting notes](troubleshooting.md)

## Key evidence

- [Windows agent active in Wazuh](screenshots/wazuh/17-windows-agent-active.png)
- [Sysmon Event ID 1 in Wazuh](screenshots/wazuh/45-wazuh-sysmon-event1-summary.png)
- [Sysmon Event ID 11 in Wazuh](screenshots/wazuh/46-wazuh-sysmon-event11-summary.png)
- [Failed SSH event in Wazuh](screenshots/wazuh/40-wazuh-ssh-failure-details.png)
- [SQL injection pattern alert](screenshots/wazuh/44-wazuh-sqli-alert-details.png)

## Safe testing notice

All activity was intentionally generated inside a private VirtualBox lab. No malware, destructive commands, or external targets were used.

Screenshots that displayed the generated Wazuh administrator password were removed before this project was prepared for GitHub.

<!-- EVIDENCE-NAVIGATION:START -->
## Evidence Navigation

- [Complete screenshot evidence index](screenshots/evidence-index.md)
- [Technical report](report.md)
- [Evidence log](evidence-log.md)
- [Validation tests](validation-tests.md)
- [Troubleshooting notes](troubleshooting.md)

<!-- EVIDENCE-NAVIGATION:END -->
