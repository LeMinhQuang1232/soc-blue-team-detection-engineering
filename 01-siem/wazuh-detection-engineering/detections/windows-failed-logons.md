# Detection: Multiple Windows Failed Logons

## 1. Goal

Identify a burst of Windows authentication failures that may indicate password guessing, password spraying, or repeated use of invalid credentials.

## 2. Data Source

- Log source: Windows Security log
- Event ID: 4625
- Endpoint: `WIN-ENDPOINT`
- Relevant fields: `targetUserName`, `ipAddress`, `ipPort`, `logonType`, failure reason, status, sub-status, workstation name, and timestamp

## 3. Detection Logic

Wazuh maps individual Event ID 4625 records to built-in authentication rules. Built-in rule 60204 correlates repeated failures. Custom rule 100110 inherits that result and creates a lab-specific alert containing the target account and source address.

## 4. Wazuh Rule

| Item | Value |
|---|---|
| Individual built-in rule observed | 60122 |
| Correlation parent rule | 60204 |
| Parent behavior | Multiple Windows logon failures; evidence shows timeframe 240 seconds |
| Custom rule ID | 100110 |
| Custom level | 12 |
| Custom description | `LAB: Multiple Windows logon failures for $(win.eventdata.targetUserName) from $(win.eventdata.ipAddress)` |

## 5. Test Procedure

Repeated invalid authentication attempts were generated for the lab account `SOC-LAB-Test` on `WIN-ENDPOINT`. The Event Viewer evidence shows Event ID 4625, Logon Type 3, and localhost source address `127.0.0.1`.

## 6. Expected Alert

- Rule ID: 100110
- Wazuh level: 12
- Target account: `SOC-LAB-Test`
- Source IP: `127.0.0.1`
- Description: multiple Windows logon failures

## 7. MITRE ATT&CK Mapping

| Tactic | Technique | ID | Reason |
|---|---|---|---|
| Credential Access | Brute Force | T1110 | The event sequence contains repeated authentication failures against one Windows account. |

## 8. Validation Result

- Expected result: Rule 100110 is generated after repeated Event ID 4625 activity.
- Actual result: Event Viewer showed 12 failed-logon events, and Wazuh generated one custom rule 100110 alert with the expected account and localhost source.
- Status: Passed
- Verdict: True Positive — Authorized Lab Simulation.

## 9. False Positive Considerations

- A user or service retaining an old password.
- A scheduled task, mapped drive, or service account retrying invalid credentials.
- Local testing tools that authenticate through loopback.
- Temporary account lockout or domain synchronization problems.

## 10. Limitations

- The supplied source address is `127.0.0.1`, so this test does not demonstrate a remote attacker.
- Event ID 4625 alone does not establish malicious intent.
- Password spraying across many accounts requires aggregation by source IP and distinct usernames.
- Account, host, and subsequent successful-logon context are needed for escalation.

## 11. Evidence

- [`screenshots/03-windows-failed-logons/01-event-viewer-4625.png`](../screenshots/03-windows-failed-logons/01-event-viewer-4625.png)
- [`screenshots/03-windows-failed-logons/02-event-viewer-network-details.png`](../screenshots/03-windows-failed-logons/02-event-viewer-network-details.png)
- [`screenshots/03-windows-failed-logons/03-wazuh-results.png`](../screenshots/03-windows-failed-logons/03-wazuh-results.png)
- [`screenshots/03-windows-failed-logons/04-custom-alert-results.png`](../screenshots/03-windows-failed-logons/04-custom-alert-results.png)
- [`screenshots/03-windows-failed-logons/05-expanded-alert-top.png`](../screenshots/03-windows-failed-logons/05-expanded-alert-top.png)
- [`screenshots/03-windows-failed-logons/06-expanded-alert-bottom.png`](../screenshots/03-windows-failed-logons/06-expanded-alert-bottom.png)
