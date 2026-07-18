# Detection: SSH Brute Force

## 1. Goal

Identify repeated failed SSH authentication attempts that may indicate password guessing or brute-force activity against the Ubuntu server.

## 2. Data Source

- Log source: `/var/log/auth.log`
- Wazuh agent: local `SOC-WAZUH` agent
- Relevant fields: `srcip`, `srcport`, `srcuser`, `program_name`, `location`, timestamp, and rule firing count

## 3. Detection Logic

Wazuh first recognizes individual failed SSH authentication events. Its built-in correlation rule 5712 identifies a burst of failures. Custom rule 100100 inherits that correlated event and assigns a lab-specific description, group, severity level, and MITRE mapping.

## 4. Wazuh Rule

| Item | Value |
|---|---|
| Built-in parent rule | 5712 |
| Parent behavior | Repeated SSH authentication failures; evidence shows frequency 8, timeframe 120 seconds, and ignore 60 seconds |
| Custom rule ID | 100100 |
| Custom level | 12 |
| Custom description | `LAB: SSH brute-force activity detected from $(srcip)` |

## 5. Test Procedure

From the authorized Windows lab endpoint, repeated SSH attempts were made with the nonexistent account `wronguser` against `192.168.56.10`. No valid credentials or unauthorized systems were used.

Example safe action:

```powershell
ssh wronguser@192.168.56.10
```

The command was repeated enough times to satisfy the parent correlation threshold.

## 6. Expected Alert

- Rule ID: 100100
- Wazuh level: 12
- Description: `LAB: SSH brute-force activity detected from 192.168.56.20`
- Expected source IP: 192.168.56.20
- Expected username: `wronguser`

## 7. MITRE ATT&CK Mapping

| Tactic | Technique | ID | Reason |
|---|---|---|---|
| Credential Access | Brute Force | T1110 | Multiple password attempts were made against an SSH authentication service. |

## 8. Validation Result

- Expected result: Rule 100100 is generated after repeated failed SSH attempts.
- Actual result: Rule 100100 fired and four custom-alert hits were visible. The expanded event shows source IP `192.168.56.20`, source user `wronguser`, and `/var/log/auth.log`.
- Status: Passed
- Verdict: True Positive — Authorized Lab Simulation.

## 9. False Positive Considerations

- A user repeatedly mistyping a password.
- Automated monitoring or deployment jobs using an outdated credential.
- A legitimate administrator testing access with the wrong account.
- A vulnerability scanner performing authentication checks.

## 10. Limitations

- The alert proves repeated failures, not account compromise.
- NAT, proxies, or shared jump hosts may cause many users to appear under one source IP.
- The custom rule depends on the threshold and correlation behavior of built-in rule 5712.
- Username and source-IP context should be compared with successful logons before escalation.

## 11. Evidence

- [`screenshots/02-ssh-bruteforce/01-source-log.png`](../screenshots/02-ssh-bruteforce/01-source-log.png)
- [`screenshots/02-ssh-bruteforce/02-wazuh-results.png`](../screenshots/02-ssh-bruteforce/02-wazuh-results.png)
- [`screenshots/02-ssh-bruteforce/03-custom-alert-results.png`](../screenshots/02-ssh-bruteforce/03-custom-alert-results.png)
- [`screenshots/02-ssh-bruteforce/04-expanded-alert.png`](../screenshots/02-ssh-bruteforce/04-expanded-alert.png)
- [`screenshots/07-rule-development/02-wazuh-logtest-ssh.png`](../screenshots/07-rule-development/02-wazuh-logtest-ssh.png)
