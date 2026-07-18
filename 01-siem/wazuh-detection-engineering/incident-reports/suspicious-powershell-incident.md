# Incident Report — Suspicious Encoded PowerShell

## 1. Executive Summary

Sysmon recorded PowerShell process creation on `WIN-ENDPOINT` with the argument `-EncodedCommand SQBFAFgA`. Wazuh custom rule 100120 detected the event and mapped it to PowerShell technique T1059.001. The event is rated **High** in the lab because encoded PowerShell can conceal execution intent and requires rapid endpoint triage. The supplied command was a harmless authorized simulation, and no malicious follow-on behavior was observed.

## 2. Alert Details

| Field | Value |
|---|---|
| Alert Name | LAB: Suspicious PowerShell command line detected on WIN-ENDPOINT |
| Severity | High |
| Detection Time | 2026-07-18 16:28:29 ICT |
| Source IP | N/A — local process execution |
| Destination Host | WIN-ENDPOINT / 192.168.56.20 |
| User | `WIN-ENDPOINT\Administrator` |
| Data Source | Sysmon Event ID 1 |
| Wazuh Rule ID | 100120, level 10; parent 61603 |
| MITRE ATT&CK | T1059.001 — PowerShell |

## 3. Evidence

| Time | Evidence | Interpretation |
|---|---|---|
| 16:28:28 ICT | Sysmon Event ID 1 for `powershell.exe` | Confirms process creation and command line |
| 16:28:28 ICT | Command line contains `-NoProfile -EncodedCommand SQBFAFgA` | Encoded-command indicator matched the detection logic |
| 16:28:29 ICT | Wazuh rule 100120, level 10 | Custom alert generated with MITRE T1059.001 |
| Same event | Parent and child images both show PowerShell; PIDs 2384 and 2404 | Provides process-chain context for triage |

## 4. Timeline

| Time | Activity |
|---|---|
| 16:28:28.263 ICT | Sysmon records the PowerShell process creation. |
| 16:28:29.404 ICT | Wazuh generates custom rule 100120. |
| After detection | Analyst reviews image, command line, user, parent process, and related telemetry. |

## 5. Analysis

The process image, command line, user, and timestamp are consistent across Sysmon and Wazuh. The presence of `-EncodedCommand` is sufficient for this custom signature. However, the evidence does not show a network connection, downloaded content, file creation, registry persistence, privilege escalation, or malicious child process. Because the command was intentionally executed for validation, the alert accurately detected a suspicious technique while the underlying activity remained benign and authorized.

## 6. Impact

- Affected endpoint: `WIN-ENDPOINT`.
- Execution context: local Administrator account.
- Data or service impact: none observed.
- Persistence or lateral movement: not observed in supplied evidence.

## 7. Containment

In a real environment:

- Isolate the endpoint if the encoded content or process ancestry is unknown and risk is high.
- Preserve Sysmon, PowerShell, Windows Security, and network telemetry.
- Decode and review the command content in a safe analysis environment.
- Search for the same command line, hash, user, and parent process across other endpoints.

## 8. Remediation

- Enable PowerShell Script Block, Module, and Transcription logging where appropriate.
- Use application control and constrained language policies where operationally feasible.
- Restrict local administrator use.
- Tune the rule with approved automation exclusions based on signer, parent process, path, and account.
- Restructure and regression-test the regex for standalone suspicious keywords.

## 9. False Positive Assessment

Encoded PowerShell is used by some legitimate management and deployment tools. An alert should not be closed solely because the user is an administrator. In this case, the command and time were intentionally generated for the lab, so the detection is a true positive for simulated suspicious behavior.

## 10. Final Verdict

True Positive — Authorized Lab Simulation.

## 11. Lessons Learned

- Sysmon Event ID 1 provides stronger command-line and process context than authentication logs alone.
- Technique detection is not equivalent to malware confirmation.
- Negative testing is still incomplete: a benign PowerShell event and a zero-result custom-rule query must be captured.
