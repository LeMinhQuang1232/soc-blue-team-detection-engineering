# Final Incident Report — P1-INC01-R1

## Executive Summary

On August 1–2, 2026, a controlled incident-validation exercise was executed from WIN-ENDPOINT (`192.168.10.10`) against the authorized Ubuntu DMZ target (`192.168.20.10`). The sequence simulated common behaviors that a SOC analyst must correlate: repeated failed authentication, encoded PowerShell, system and network discovery, bounded service probing, benign file transfer, and a SQL-injection-like web request.

The incident was observable across Windows Security, Sysmon, Wazuh, LimaCharlie, Nginx, Zeek, and supporting network evidence. LimaCharlie containment blocked normal network access while preserving the EDR management channel, and `rejoin_network` restored connectivity. The endpoint, SIEM, HTTP, and EDR portions were successfully repeated during retest.

The principal finding was a network collection and attribution gap. The execution transcript proves that twelve ports were tested, but the initial Zeek and Python detector inputs represented only a small subset of those connections. Suricata output was dominated by invalid-checksum noise and was not cleanly attributable to the probe. A final non-empty PCAP was recaptured and hashed, but the raw PCAP and regenerated final derived logs were not supplied in the evidence ZIP. Network behavioral validation is therefore reported as Partial.

## Classification

* **Type:** Controlled detection-validation incident.
* **Severity:** Informational lab exercise; no real compromise.
* **Scope:** One authorized Windows source, one Ubuntu DMZ target, one local lab account.
* **Impact:** Temporary intentional network isolation only.

## Findings

### F1 — Repeated Authentication Failures

Five controlled wrong-password attempts generated Windows Security Event ID 4625 records. No evidence indicates that an account was compromised.

### F2 — Encoded PowerShell Was Detected Across Three Layers

Sysmon recorded the process, Wazuh rule 92057 generated a level-12 alert, and LimaCharlie exposed process context. This was the strongest cross-layer detection in the exercise.

### F3 — Discovery Activity Generated Dedicated Wazuh Alerts

System/account discovery generated rule 100132, and network-discovery commands generated rule 100140. The evidence includes command output and expanded SIEM fields.

### F4 — Bounded Service Probe Executed but Network Attribution Was Partial

The execution record shows twelve predefined ports tested against `192.168.20.10`; ports 80 and 443 were reachable while the others shown were closed or blocked. The initial Zeek/Python artifacts did not preserve the full port set. This is a collection/input gap.

### F5 — Benign HTTP Transfer and SQLi-Like Request Correlated

The endpoint downloaded `p1-inc01-safe.txt` from Nginx, calculated a SHA-256, and sent a SQLi-like request. Nginx and Zeek HTTP recorded the activity. Wazuh rules 100154 and 100130 generated alerts.

### F6 — Endpoint Isolation and Recovery Worked

LimaCharlie isolation stopped normal connectivity to the tested DMZ and pfSense services while the sensor remained manageable. The rejoin command succeeded and connectivity returned.

### F7 — Wazuh Buffer Pressure Could Affect Evidence Completeness

The Windows agent reported a 90-percent buffer state and event discarding. Timed validation should not begin until agent connectivity and buffer health are stable.

## ATT&CK-Aligned Mapping

| Activity | Technique | Evidence note |
|---|---|---|
| Failed authentication simulation | T1110-aligned | Controlled authentication failures; not credential compromise. |
| Encoded PowerShell | T1059.001 | Observed Wazuh mapping and process evidence. |
| System information discovery | T1082 | Native discovery and Wazuh evidence. |
| System owner/user discovery | T1033 | Observed in Wazuh mapping. |
| Network configuration discovery | T1016 | ipconfig, route, arp, netstat, and connection review. |
| Network service scanning | T1046 | Bounded twelve-port probe against one authorized host. |
| Ingress tool transfer alignment | T1105 | Benign file transfer used only for telemetry validation. |
| Exploit public-facing application alignment | T1190 | Wazuh mapping for a SQLi-like URI; no exploitation succeeded. |

These mappings describe lab behavior and rule alignment. They do not prove malicious intent or successful exploitation.

## Scope and Impact

* Affected hosts: one source endpoint and one target server participated in the exercise.
* Accounts: one local lab administrator account was used.
* Internet traffic: not required for the incident chain; no evidence of external command-and-control or exfiltration.
* Lateral movement: not performed and not observed.
* Persistence: not performed and not observed.
* Malware: not used.
* Data loss: none.
* Service impact: only temporary, intentional network loss during EDR isolation.

## Root Cause and Control Analysis

This was authorized activity, so the root cause is not an intrusion. The operational control question was whether each layer produced reliable evidence. Endpoint and SIEM controls worked well for process and command activity. The EDR response path was effective. The principal weakness was the reliability of network evidence collection and run isolation, compounded by noisy Suricata output and a Wazuh agent buffer warning.

## Recommendations

1. Treat packet capture start, interface verification, metadata capture, and hashing as mandatory pre/post-test gates.
2. Regenerate Zeek and Python output only from the exact hashed final PCAP.
3. Separate every run into a fresh directory and time window.
4. Stabilize Wazuh agent connectivity and buffer health before timed execution.
5. Filter Suricata by incident window and five-tuple; do not use unrelated checksum events as detection evidence.
6. Keep endpoint, SIEM, EDR, and application evidence as independent corroborating layers.

## Final Disposition

**Completed with a documented network behavioral limitation.** The project proves a repeatable SOC workflow for controlled execution, cross-layer triage, containment, recovery, gap analysis, and retest. It does not claim full network behavioral coverage until the final recaptured PCAP is processed into matching Zeek, Suricata, and Python outputs.
