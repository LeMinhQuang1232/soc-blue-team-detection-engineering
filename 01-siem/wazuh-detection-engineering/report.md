# Wazuh Detection Engineering and Alert Investigation Report

## 1. Executive Summary

Week 2 extended the Week 1 log-onboarding environment into a detection-engineering and alert-investigation lab. Existing Windows Security, Sysmon, Linux authentication, and Nginx telemetry was used to build four custom rule paths covering six documented detection outcomes: SSH brute force, repeated Windows logon failures, successful logon after failures, suspicious PowerShell, SQL injection patterns, and XSS/path-traversal patterns.

The lab produced evidence-backed positive detections for rules 100100, 100110, 100120, 100130, and 100131. A 4625-to-4624 sequence was validated through manual investigation rather than a dedicated custom correlation rule. The normal web baseline test was supported, while the normal PowerShell negative test remains Pending Evidence. Three complete incident reports document SSH brute force, encoded PowerShell, and web attack attempts.

## 2. Objectives

- Reuse the Week 1 Wazuh and endpoint environment.
- Review relevant built-in Wazuh rules.
- Create custom rules with lab-specific descriptions and MITRE mappings.
- Validate rule syntax and test matching behavior.
- Generate only safe, authorized lab activity.
- Compare expected and actual results.
- Assess false positives, false negatives, and rule limitations.
- Produce SOC-style detection documentation and incident reports.

## 3. Reused Week 1 Environment

| Host | Operating System | IP | Week 2 Role |
|---|---|---|---|
| SOC-WAZUH | Ubuntu Server | 192.168.56.10 | Wazuh manager/indexer/dashboard, SSH target, Nginx target, local log collection |
| WIN-ENDPOINT | Windows Server 2022 | 192.168.56.20 | Windows Security and Sysmon source; authorized test client |

The environment evidence shows Wazuh 4.14.6, active Wazuh services, an active local manager agent, and an active `WIN-ENDPOINT` agent.

## 4. Detection Architecture

```text
WIN-ENDPOINT (192.168.56.20)
  ├─ Windows Security 4625 / 4624 ─┐
  ├─ Sysmon Event ID 1 ────────────┼─ Wazuh agent ──┐
  └─ Safe curl / SSH test traffic ─┘                │
                                                    v
SOC-WAZUH (192.168.56.10)                    Wazuh analysis engine
  ├─ /var/log/auth.log --------------------------> built-in rules
  ├─ /var/log/nginx/access.log ------------------> custom rules
  └─ Wazuh manager/indexer/dashboard ------------> alerts and investigation
```

Detection workflow:

1. Source activity creates a local event.
2. Wazuh decodes and matches a built-in rule.
3. A custom rule inherits the built-in event or matches relevant fields.
4. The dashboard exposes alert context for triage.
5. Evidence is compared with the original source log or Event Viewer.

## 5. Data Sources

| Data Source | Important Fields / Events | Detection Purpose |
|---|---|---|
| Linux `auth.log` | failed password, invalid user, source IP, source port | SSH brute-force detection |
| Windows Security | Event IDs 4625 and 4624, username, source IP, logon type | Failed-logon correlation and success-after-failure investigation |
| Sysmon Operational | Event ID 1, image, command line, parent, user, PID | Suspicious PowerShell detection |
| Nginx `access.log` | source IP, method, URL, status, user agent | SQLi, XSS, path-traversal, and baseline validation |
| Wazuh alerts | rule ID, level, groups, MITRE, fired times, agent | Triage and evidence correlation |

## 6. Built-in Rule Assessment

| Rule | Observed Level / Behavior | Week 2 Use |
|---:|---|---|
| 5710 | Level 5 individual SSH authentication failure | Source context for SSH failures |
| 5712 | Level 10; frequency 8, timeframe 120 seconds, ignore 60 seconds | Parent for custom SSH rule 100100 |
| 60122 | Level 5 Windows failed-logon event | Individual 4625 context |
| 60204 | Level 10; repeated Windows failures, timeframe 240 seconds | Parent for custom rule 100110 |
| 60106 | Windows successful logon | 4624 event used in manual correlation |
| 61603 | Level 0 Sysmon process event | Parent for custom PowerShell rule 100120 |
| 31100 | Level 0 web event | Generic web parent path |
| 31103 | Level 7 web rule reviewed during assessment | Planning/reference |
| 31105 | Level 6 web rule reviewed during assessment | Planning/reference |

The deployed custom XML uses `31100,31108` for both web rules. Because the planning table referenced 31103 and 31105, the inconsistency is documented as a rule-maintenance issue. The repository records the actual deployed XML shown by the evidence.

## 7. Custom Rules Developed

| Detection | Data Source | Built-in Rule | Custom Rule | MITRE | Result |
|---|---|---:|---:|---|---|
| SSH brute force | Linux `auth.log` | 5712 | 100100 | T1110 | Passed |
| Windows failed logons | Security 4625 | 60204 | 100110 | T1110 | Passed |
| Success after failures | 4625 + 4624 | Correlation | Investigation | T1110 / T1078 | Passed |
| Suspicious PowerShell | Sysmon Event ID 1 | 61603 | 100120 | T1059.001 | Passed |
| SQL injection | Nginx `access.log` | 31100/31108 deployed | 100130 | T1190 | Passed |
| XSS/path traversal | Nginx `access.log` | 31100/31108 deployed | 100131 | T1190 | Passed |

### Rule Design Notes

- Rules 100100 and 100110 inherit frequency-based built-in correlations.
- Rule 100120 requires both the PowerShell image and a suspicious command-line pattern.
- Rules 100130 and 100131 match encoded URL indicators.
- The success-after-failures use case is an analyst workflow, not a custom rule.

## 8. Detection Validation Results

| Test | Expected | Observed | Status |
|---|---|---|---|
| W2-T01 SSH brute force | Rule 100100 | Four custom hits; expanded T1110 event | Passed |
| W2-T02 Windows failed logons | Rule 100110 | Custom alert after repeated 4625 records | Passed |
| W2-T03 Success after failures | 4625 → 4624 | Matching lab context visible in timeline | Passed |
| W2-T04 Suspicious PowerShell | Rule 100120 | Sysmon Event ID 1 and custom alert | Passed |
| W2-T05 SQL injection | Rule 100130 | Two SQLi-pattern alerts | Passed |
| W2-T06 XSS/path traversal | Rule 100131 | XSS and traversal alerts | Passed |
| W2-T07 Normal PowerShell | No 100120 | Negative-test evidence not supplied | Pending Evidence |
| W2-T08 Normal web request | No custom web alert | Baseline in source log; absent from four custom hits | Passed |

## 9. Investigation Summaries

### SSH Brute Force

Repeated SSH failures from `192.168.56.20` targeted invalid user `wronguser` on `SOC-WAZUH`. Rule 100100 fired with Wazuh level 12 and MITRE T1110. No successful authentication was found in the supplied case evidence. Incident severity: **Medium**.

### Suspicious PowerShell

Sysmon recorded `powershell.exe -NoProfile -EncodedCommand SQBFAFgA` under `WIN-ENDPOINT\Administrator`. Rule 100120 fired with level 10 and T1059.001. No malicious network, file, persistence, or child-process activity was demonstrated. Incident severity: **High** because encoded execution requires urgent review, even though this command was authorized and harmless.

### Web Attack Attempts

Nginx logged encoded SQLi, XSS, and traversal patterns from `192.168.56.20`. Wazuh produced two 100130 and two 100131 alerts. Response codes were 404 or 400, and no successful exploitation was observed. Incident severity: **Medium**.

## 10. MITRE ATT&CK Mapping

| Detection | Tactic | Technique | ID | Mapping Rationale |
|---|---|---|---|---|
| SSH brute force | Credential Access | Brute Force | T1110 | Repeated password attempts against SSH |
| Windows failed logons | Credential Access | Brute Force | T1110 | Repeated Event ID 4625 authentication failures |
| Success after failures | Credential Access / Valid-account use | Brute Force / Valid Accounts | T1110 / T1078 | Failed attempts followed by successful authentication |
| Suspicious PowerShell | Execution | PowerShell | T1059.001 | Encoded PowerShell process execution |
| SQLi/XSS/traversal | Initial Access | Exploit Public-Facing Application | T1190 | Exploit patterns sent to the web service |

## 11. False Positive and False Negative Analysis

### False Positive Risks

- Users or services retrying stale credentials.
- Administrators using encoded PowerShell for approved automation.
- Vulnerability scanners sending SQLi, XSS, or traversal strings.
- Legitimate requests that contain security-related text.

### False Negative Risks

- Slow brute-force activity below correlation thresholds.
- Password spray distributed across IP addresses or accounts.
- PowerShell obfuscation that avoids the current keyword expression.
- Other interpreters such as `pwsh.exe` not included in the image condition.
- Double-encoded or fragmented web payloads.
- Successful logons that fall outside the analyst's review window.

### Tuning Priorities

1. Add evidence-backed allowlists for approved automation instead of broad exclusions.
2. Restructure and regression-test the PowerShell regex.
3. Reconcile the web parent SID list with the intended built-in rules.
4. Add a dedicated 4625-to-4624 correlation design with a justified time window.
5. Preserve both positive and negative regression samples.

## 12. Issues and Troubleshooting

- Built-in parent rules were located and reviewed before writing custom rules.
- Rule syntax was checked before restarting the manager.
- The manager and log collector were verified after deployment.
- Nginx access-log collection was confirmed in the Wazuh log-collector output.
- The web parent SID values in the deployed XML differ from the initial planning table; documentation uses the deployed values and flags the difference.
- The normal PowerShell negative test was not captured with sufficient evidence.

## 13. Limitations

- This was a two-host isolated lab, not a production network.
- Source addresses included localhost for the Windows authentication scenario.
- The test commands were harmless simulations, not real exploitation.
- No active response, account lockout automation, endpoint isolation, WAF, or SOAR workflow was deployed.
- The success-after-failures case was manually correlated.
- No full packet capture, application backend, threat-intelligence enrichment, or malware analysis was included.

## 14. Lessons Learned

- Detection quality depends on verified data sources and source-event context.
- Parent-rule behavior should be understood before adding custom classification rules.
- A high Wazuh rule level does not automatically equal high business impact.
- Positive attack-pattern tests are insufficient without negative baseline tests.
- Sysmon command-line telemetry provides useful endpoint context for alert triage.
- Source logs and expanded Wazuh alerts should be preserved together.
- Documentation must reflect deployed configuration even when it differs from the original plan.

## 15. Next Steps

- Capture the missing normal PowerShell negative-test evidence.
- Correct or formally justify the web parent SID selection and rerun regression tests.
- Add a dedicated success-after-failures correlation rule or document an operational search procedure.
- Add more PowerShell variants, including `pwsh.exe`, mixed case, and standalone keywords.
- Export representative raw events for repeatable logtest regression.
- Continue to Week 3 with Splunk ingestion, SPL searches, dashboards, and cross-source investigation.
