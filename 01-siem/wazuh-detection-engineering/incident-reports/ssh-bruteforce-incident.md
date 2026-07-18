# Incident Report — SSH Brute-Force Activity

## 1. Executive Summary

Wazuh detected repeated failed SSH authentication attempts against `SOC-WAZUH` from the authorized lab endpoint `192.168.56.20`. The attempts targeted the invalid username `wronguser` and generated custom rule 100100. No successful SSH authentication or follow-on activity was identified in the supplied evidence. The case is rated **Medium** in the lab because the behavior was repetitive and credential-focused, but no compromise occurred.

## 2. Alert Details

| Field | Value |
|---|---|
| Alert Name | LAB: SSH brute-force activity detected from 192.168.56.20 |
| Severity | Medium |
| Detection Time | 2026-07-18 12:45:47 ICT |
| Source IP | 192.168.56.20 |
| Destination Host | SOC-WAZUH / 192.168.56.10 |
| User | `wronguser` |
| Data Source | Linux `/var/log/auth.log` |
| Wazuh Rule ID | 100100, level 12; parent 5712 |
| MITRE ATT&CK | T1110 — Brute Force |

## 3. Evidence

| Time | Evidence | Interpretation |
|---|---|---|
| 12:44:53–12:46:01 ICT | Repeated `Failed password for invalid user wronguser` entries from 192.168.56.20 | Authentication-failure burst against SSH |
| 12:45:47 ICT | Expanded Wazuh alert for rule 100100 | Custom detection matched the correlated activity |
| During test window | Four custom-rule hits in the Wazuh result set | The threshold was met more than once during the controlled burst |

## 4. Timeline

| Time | Activity |
|---|---|
| 12:44:53 ICT | Failed SSH activity begins from 192.168.56.20. |
| 12:45:46 ICT | A failed attempt from source port 49884 is written to `auth.log`. |
| 12:45:47 ICT | Wazuh generates custom rule 100100. |
| 12:46:01 ICT | Additional failed attempts remain visible in the source log. |

## 5. Analysis

The source log, Wazuh result list, and expanded alert agree on the source address, invalid account, destination host, and time window. The pattern satisfies the built-in SSH correlation logic and is then reclassified by custom rule 100100. No accepted-password event, valid account use, new process, or suspicious network activity was supplied for the same sequence. Therefore, the alert is a true detection of the simulated behavior but not a confirmed intrusion.

## 6. Impact

- Affected service: SSH on `SOC-WAZUH`.
- Affected account: none; `wronguser` was invalid.
- Availability impact: none observed.
- Confidentiality or integrity impact: none observed.

## 7. Containment

In a real environment:

- Temporarily block or rate-limit the source IP after validating business context.
- Review successful SSH logons from the same source and adjacent time window.
- Confirm that no valid or privileged account was targeted successfully.
- Preserve `auth.log`, Wazuh alerts, and firewall telemetry.

## 8. Remediation

- Disable password-based SSH where feasible and use managed keys.
- Enforce MFA through an appropriate access gateway.
- Restrict SSH exposure with firewall rules, VPN, or jump hosts.
- Deploy rate limiting or tools such as fail2ban where appropriate.
- Tune thresholds based on normal administrator behavior.

## 9. False Positive Assessment

A legitimate administrator could repeatedly enter an incorrect username or password, and automation could retry a stale credential. In this case, the exact timing and account were deliberately generated in the lab, so the event is not a false positive.

## 10. Final Verdict

True Positive — Authorized Lab Simulation.

## 11. Lessons Learned

- Built-in correlation can be inherited by a small custom rule to improve labeling and MITRE context.
- Alert severity must be interpreted with outcome evidence; Wazuh level 12 did not mean the lab host was compromised.
- Future testing should include a successful SSH attempt after failures and a negative baseline from an approved management source.
