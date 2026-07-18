# Wazuh Rule and Logtest Results

## 1. Rule Syntax Validation

The custom rule file was checked before restarting the manager:

```bash
sudo /var/ossec/bin/wazuh-analysisd -t
```

The supplied evidence shows the syntax-test command being executed and the custom rule file being inspected.

Evidence: [`screenshots/07-rule-development/01-rule-syntax-check.png`](./screenshots/07-rule-development/01-rule-syntax-check.png)

## 2. SSH Sample Test

A synthetic failed-SSH sample was submitted to:

```bash
sudo /var/ossec/bin/wazuh-logtest
```

Observed result:

| Field | Value |
|---|---|
| Matched custom rule | 100100 |
| Rule level | 12 |
| Description | `LAB: SSH brute-force activity detected from 192.168.56.20` |
| MITRE technique | T1110 — Brute Force |
| Rule groups | `week2_detection_engineering`, `lab_week2`, `ssh_bruteforce`, `authentication_attack` |

Evidence: [`screenshots/07-rule-development/02-wazuh-logtest-ssh.png`](./screenshots/07-rule-development/02-wazuh-logtest-ssh.png)

## 3. Live Validation

The remaining detections were validated with live lab telemetry rather than isolated logtest screenshots:

- Windows Security Event ID 4625 → custom rule 100110.
- Sysmon Event ID 1 with `-EncodedCommand` → custom rule 100120.
- Encoded SQL injection patterns in Nginx access logs → custom rule 100130.
- Encoded XSS and path-traversal patterns → custom rule 100131.

## 4. Configuration Observation

The initial built-in rule review included web rules 31100, 31103, and 31105. The deployed custom XML shown in the evidence uses `31100,31108` as the parent SID list for both web detections. The repository preserves the deployed value rather than silently replacing it with the planning value. The parent selection should be reviewed in a future tuning pass and verified with additional `wazuh-logtest` samples.

## 5. Limitation

Only the SSH case has a supplied screenshot showing a complete standalone `wazuh-logtest` match. Live dashboard evidence supports the other positive cases, but separate logtest transcripts for every rule would make regression testing stronger.
