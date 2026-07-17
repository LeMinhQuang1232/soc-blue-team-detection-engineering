# Troubleshooting Notes

## Dashboard or agent ports are unreachable

Useful checks:

```powershell
Test-NetConnection 192.168.56.10 -Port 443
Test-NetConnection 192.168.56.10 -Port 1514
Test-NetConnection 192.168.56.10 -Port 1515
```

On Ubuntu:

```bash
sudo systemctl status wazuh-manager
sudo systemctl status wazuh-dashboard
sudo ss -lntp | grep -E '443|1514|1515|55000'
```

In this lab, all three Windows connectivity tests succeeded.

## Sysmon events appear locally but not in Wazuh

First check the local channel:

```powershell
Get-WinEvent -LogName "Microsoft-Windows-Sysmon/Operational" -MaxEvents 5
```

Then confirm that the Sysmon event channel is present in the Wazuh agent configuration and restart the agent:

```powershell
Restart-Service WazuhSvc
Get-Content "C:\Program Files (x86)\ossec-agent\ossec.log" -Tail 100
```

This project confirmed Wazuh ingestion for Sysmon Event IDs 1 and 11.

## Nginx log exists but no alert appears

A raw application log does not always match a security rule. A normal `/notfound` request appeared in Nginx `access.log` but did not need to create a security alert.

The encoded SQL injection pattern matched Wazuh rule 31164 and produced a level-6 alert.

## Timestamp differences

Windows Event Viewer, Sysmon UTC fields, Ubuntu `+0700` logs, and Wazuh dashboard timestamps may use different time formats or time zones.

For future timeline analysis, synchronize both VMs and document one standard time zone, preferably UTC.

## Sensitive screenshots

Do not publish screenshots that contain passwords, private keys, product keys, personal information, or generated administrator credentials.
