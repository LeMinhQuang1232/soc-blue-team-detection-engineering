# Evidence Log

| ID | File | Description | Related Test |
|---|---|---|---|
| EV-01 | [`screenshots/01-setup/01-wazuh-services-and-version.png`](./screenshots/01-setup/01-wazuh-services-and-version.png) | Active Wazuh services, Nginx, SSH, package versions, and Wazuh 4.14.6 | Environment validation |
| EV-02 | [`screenshots/01-setup/02-agent-control-active.png`](./screenshots/01-setup/02-agent-control-active.png) | Local SOC-WAZUH and WIN-ENDPOINT agents active | Environment validation |
| EV-03 | [`screenshots/01-setup/03-agent-dashboard-active.png`](./screenshots/01-setup/03-agent-dashboard-active.png) | WIN-ENDPOINT dashboard status and endpoint metadata | Environment validation |
| EV-04 | [`screenshots/01-setup/04-built-in-rule-assessment.png`](./screenshots/01-setup/04-built-in-rule-assessment.png) | Built-in rule IDs and correlation parameters reviewed | Rule assessment |
| EV-05 | [`screenshots/01-setup/05-baseline-auth-and-nginx-logs.png`](./screenshots/01-setup/05-baseline-auth-and-nginx-logs.png) | Baseline authentication and normal Nginx requests | W2-T08 / baseline |
| EV-06 | [`screenshots/02-ssh-bruteforce/01-source-log.png`](./screenshots/02-ssh-bruteforce/01-source-log.png) | Repeated failed SSH authentication events | W2-T01 |
| EV-07 | [`screenshots/02-ssh-bruteforce/02-wazuh-results.png`](./screenshots/02-ssh-bruteforce/02-wazuh-results.png) | Built-in and custom SSH alert results | W2-T01 |
| EV-08 | [`screenshots/02-ssh-bruteforce/03-custom-alert-results.png`](./screenshots/02-ssh-bruteforce/03-custom-alert-results.png) | Rule 100100 result set | W2-T01 |
| EV-09 | [`screenshots/02-ssh-bruteforce/04-expanded-alert.png`](./screenshots/02-ssh-bruteforce/04-expanded-alert.png) | Expanded rule 100100 event with source/user/MITRE fields | W2-T01 |
| EV-10 | [`screenshots/03-windows-failed-logons/01-event-viewer-4625.png`](./screenshots/03-windows-failed-logons/01-event-viewer-4625.png) | Windows Event ID 4625 burst and failure details | W2-T02 |
| EV-11 | [`screenshots/03-windows-failed-logons/02-event-viewer-network-details.png`](./screenshots/03-windows-failed-logons/02-event-viewer-network-details.png) | 4625 workstation, localhost source, and source port | W2-T02 |
| EV-12 | [`screenshots/03-windows-failed-logons/03-wazuh-results.png`](./screenshots/03-windows-failed-logons/03-wazuh-results.png) | Wazuh individual and correlated failed-logon results | W2-T02 |
| EV-13 | [`screenshots/03-windows-failed-logons/04-custom-alert-results.png`](./screenshots/03-windows-failed-logons/04-custom-alert-results.png) | Rule 100110 result | W2-T02 |
| EV-14 | [`screenshots/03-windows-failed-logons/05-expanded-alert-top.png`](./screenshots/03-windows-failed-logons/05-expanded-alert-top.png) | Expanded 100110 endpoint, account, and source fields | W2-T02 |
| EV-15 | [`screenshots/03-windows-failed-logons/06-expanded-alert-bottom.png`](./screenshots/03-windows-failed-logons/06-expanded-alert-bottom.png) | Expanded 100110 level, MITRE, and timestamp | W2-T02 |
| EV-16 | [`screenshots/04-success-after-failures/01-successful-logon-top.png`](./screenshots/04-success-after-failures/01-successful-logon-top.png) | Windows successful-logon event details | W2-T03 |
| EV-17 | [`screenshots/04-success-after-failures/02-successful-logon-bottom.png`](./screenshots/04-success-after-failures/02-successful-logon-bottom.png) | Built-in rule 60106 and MITRE context | W2-T03 |
| EV-18 | [`screenshots/04-success-after-failures/03-4625-to-4624-timeline.png`](./screenshots/04-success-after-failures/03-4625-to-4624-timeline.png) | Failed-logon burst followed by successful logon | W2-T03 |
| EV-19 | [`screenshots/05-suspicious-powershell/01-event-viewer-process-create.png`](./screenshots/05-suspicious-powershell/01-event-viewer-process-create.png) | Sysmon Event ID 1 for PowerShell | W2-T04 |
| EV-20 | [`screenshots/05-suspicious-powershell/02-event-viewer-process-details.png`](./screenshots/05-suspicious-powershell/02-event-viewer-process-details.png) | PowerShell image, command line, parent, and user | W2-T04 |
| EV-21 | [`screenshots/05-suspicious-powershell/03-custom-alert-results.png`](./screenshots/05-suspicious-powershell/03-custom-alert-results.png) | Rule 100120 result | W2-T04 |
| EV-22 | [`screenshots/05-suspicious-powershell/04-expanded-alert-top.png`](./screenshots/05-suspicious-powershell/04-expanded-alert-top.png) | Expanded PowerShell command, process, and user fields | W2-T04 |
| EV-23 | [`screenshots/05-suspicious-powershell/05-expanded-alert-bottom.png`](./screenshots/05-suspicious-powershell/05-expanded-alert-bottom.png) | Rule 100120 level, MITRE, and timestamp | W2-T04 |
| EV-24 | [`screenshots/06-web-attacks/01-nginx-access-log.png`](./screenshots/06-web-attacks/01-nginx-access-log.png) | Normal, SQLi, XSS, and traversal requests in access log | W2-T05 / W2-T06 / W2-T08 |
| EV-25 | [`screenshots/06-web-attacks/02-custom-alert-results.png`](./screenshots/06-web-attacks/02-custom-alert-results.png) | Exactly four custom web-alert hits | W2-T05 / W2-T06 / W2-T08 |
| EV-26 | [`screenshots/06-web-attacks/03-sqli-expanded-alert.png`](./screenshots/06-web-attacks/03-sqli-expanded-alert.png) | Rule 100130 expanded SQLi event | W2-T05 |
| EV-27 | [`screenshots/06-web-attacks/04-path-traversal-expanded-alert.png`](./screenshots/06-web-attacks/04-path-traversal-expanded-alert.png) | Rule 100131 expanded traversal event | W2-T06 |
| EV-28 | [`screenshots/06-web-attacks/05-test-commands.png`](./screenshots/06-web-attacks/05-test-commands.png) | Safe baseline and SQLi curl commands | W2-T05 / W2-T08 |
| EV-29 | [`screenshots/06-web-attacks/06-xss-expanded-alert.png`](./screenshots/06-web-attacks/06-xss-expanded-alert.png) | Rule 100131 expanded XSS event | W2-T06 |
| EV-30 | [`screenshots/06-web-attacks/07-path-traversal-expanded-alert-2.png`](./screenshots/06-web-attacks/07-path-traversal-expanded-alert-2.png) | Additional expanded traversal evidence | W2-T06 |
| EV-31 | [`screenshots/07-rule-development/01-rule-syntax-check.png`](./screenshots/07-rule-development/01-rule-syntax-check.png) | Analysis-engine syntax check and rule-file inspection | Rule deployment |
| EV-32 | [`screenshots/07-rule-development/02-wazuh-logtest-ssh.png`](./screenshots/07-rule-development/02-wazuh-logtest-ssh.png) | Standalone logtest match for rule 100100 | W2-T01 |
| EV-33 | [`screenshots/07-rule-development/03-custom-rules-part-1.png`](./screenshots/07-rule-development/03-custom-rules-part-1.png) | Deployed SSH and Windows custom-rule XML | Rule deployment |
| EV-34 | [`screenshots/07-rule-development/04-custom-rules-part-2.png`](./screenshots/07-rule-development/04-custom-rules-part-2.png) | Deployed PowerShell and web custom-rule XML | Rule deployment |
| EV-35 | [`screenshots/07-rule-development/05-manager-restart.png`](./screenshots/07-rule-development/05-manager-restart.png) | Wazuh manager restart and active status | Rule deployment |
| EV-36 | [`screenshots/07-rule-development/06-log-collector-confirmation.png`](./screenshots/07-rule-development/06-log-collector-confirmation.png) | Nginx access-log collection confirmation | Web telemetry |

## Evidence Gap

No supplied screenshot meets the evidentiary standard for W2-T07, the normal PowerShell negative test. The missing evidence is intentionally not represented by a placeholder or a Passed status.
