# Incident Report — Blocked Unauthorized Administrative Access

## 1. Executive Summary

During a controlled Week 5 validation, the USER client `192.168.10.10` attempted to access administrative services on the Ubuntu DMZ server `192.168.20.10`. TCP/22, TCP/445, and TCP/3389 failed from USER_NET, and pfSense recorded matching blocked traffic. The same lab later validated that the SOC_ADMIN role at `192.168.30.10` could reach approved SSH and monitoring services. No compromise occurred; this was an authorized test of segmentation and lateral-movement controls.

## 2. Classification

| Field | Value |
|---|---|
| Severity | Medium as a real-world pattern; Informational in this authorized lab |
| Source | `192.168.10.10` USER_NET |
| Destination | `192.168.20.10` DMZ |
| Attempted services | SSH 22, SMB 445, RDP 3389 |
| Firewall action | Block |
| Confirmed compromise | No |
| Control outcome | Expected deny policy operated correctly |

## 3. Evidence

| Evidence | Meaning |
|---|---|
| USER TCP/22 failure | SSH not reachable from the user zone |
| USER TCP/445 failure | SMB not reachable from the user zone |
| USER TCP/3389 failure | RDP not reachable from the user zone |
| pfSense deny logs | Network control, rather than only service state, explains failure |
| SOC_ADMIN TCP/22 success | Authorized administration path remained available |
| USER 3000/9090 failures | Monitoring consoles were not exposed to standard users |

## 4. MITRE ATT&CK Mapping

| Tactic | Technique | ID | Rationale |
|---|---|---|---|
| Lateral Movement | Remote Services | T1021 | Attempts targeted remote administrative services |
| Discovery | Network Service Discovery | T1046 | Multi-port probing can indicate service discovery |

The mapping describes the observed test pattern, not an attribution of malicious intent.

## 5. Impact

No unauthorized session was established and no evidence indicated data access or host compromise.

## 6. Containment and Remediation

- Retain USER-to-DMZ administrative-port blocks.
- Keep deny logging enabled.
- Permit SSH and monitoring only from SOC_ADMIN.
- Review repeated multi-port attempts for source host compromise.
- Correlate firewall events with endpoint and IDS telemetry.

## 7. Lessons Learned

Client failure alone cannot identify the blocking layer. Matching firewall logs and source-address verification are required. Host firewall controls such as UFW must also be checked when pfSense permits traffic but the server does not respond.
