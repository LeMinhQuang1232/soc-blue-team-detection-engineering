# Data Sources

## Windows Security Log

| Event ID | Meaning | Wazuh result |
|---:|---|---|
| 4624 | Successful logon | Rule 60118, level 3 |
| 4625 | Failed logon | Rule 60122, level 5 |

## Sysmon

| Event ID | Meaning | Validation |
|---:|---|---|
| 1 | Process creation | Confirmed locally and in Wazuh |
| 11 | File creation | Confirmed locally and in Wazuh |

The local Event ID 1 test showed `curl.exe` launched by PowerShell. The local Event ID 11 test showed PowerShell creating `soc-lab-test.txt`.

## Ubuntu SSH

| Activity | Wazuh rule | Level | MITRE ATT&CK |
|---|---:|---:|---|
| Failed password | 5760 | 5 | T1110.001, T1021.004 |
| Successful password login | 5715 | 3 | T1078, T1021 |

## Nginx

| Item | Value |
|---|---|
| Log file | `/var/log/nginx/access.log` |
| Wazuh decoder | `web-accesslog` |
| SQL injection rule | 31164 |
| Rule level | 6 |

A normal 404 request was visible in the raw access log. A safe encoded SQL injection pattern generated a Wazuh alert.
