# Validation Tests

| Test ID | Activity | Expected result | Actual result | Status |
|---|---|---|---|---|
| NET-001 | Ping Ubuntu from Windows | ICMP replies | Four replies, 0% packet loss | Pass |
| WAZ-001 | Test ports 443, 1514, and 1515 | Connections succeed | All tests returned `True` | Pass |
| WAZ-002 | Check Windows agent | Agent shows Active | Agent 001 was Active | Pass |
| WIN-001 | Generate failed Windows logons | Event ID 4625 | Seen locally and in Wazuh | Pass |
| WIN-002 | Generate a successful Windows logon | Event ID 4624 | Seen locally and in Wazuh | Pass |
| SYS-001 | Run a benign process | Sysmon Event ID 1 | Seen locally and in Wazuh | Pass |
| SYS-002 | Create a harmless test file | Sysmon Event ID 11 | Seen locally and in Wazuh | Pass |
| LIN-001 | Enter incorrect SSH passwords | Failed SSH log | Seen in Ubuntu and Wazuh | Pass |
| LIN-002 | Complete a valid SSH login | Successful SSH log | Seen in the session and Wazuh | Pass |
| WEB-001 | Request `/notfound` | Nginx 404 log | Seen in `access.log` | Pass |
| WEB-002 | Send a safe SQL injection pattern | Wazuh web alert | Rule 31164 triggered | Pass |

See [evidence-log.md](evidence-log.md) for detailed fields, timestamps, and screenshots.
