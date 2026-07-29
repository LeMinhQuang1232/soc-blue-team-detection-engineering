# Incident Report — Controlled TCP SYN Reconnaissance

## Incident Metadata

| Field | Value |
|---|---|
| Incident type | Network reconnaissance / probable port scan |
| Environment | Isolated VirtualBox SOC lab |
| Source | `192.168.10.10` (Windows USER) |
| Target | `192.168.20.10` (Ubuntu DMZ) |
| Observed time | July 28, 2026, approximately 10:53:34–10:53:36 `+07:00` |
| Severity used in Wazuh | Medium / level 7 |
| Detector classification | `probable_port_scan` |
| ATT&CK mapping | T1046 — Network Service Scanning |
| Status | Validated controlled activity; no production impact |

## Executive Summary

A controlled source in the USER network sent TCP SYN packets to 100 destination ports on the Ubuntu DMZ server. Packet, Zeek, Suricata, Python, and Wazuh evidence independently confirmed the activity. The validated base detector scored the event at 50, Medium, and Wazuh matched rule `100201` at level 7.

## Timeline

| Time (`+07:00`) | Event |
|---|---|
| 10:53:34.038465 | First retained Suricata TCP scan alert |
| 10:53:34–10:53:36 | SYN burst spans ports 1–100 |
| 10:53:35.893161 | Last retained Suricata TCP scan alert |
| 10:53:30–10:54:00 | Python detector aggregation window |
| Validation period | JSON event ingested and displayed by Wazuh |

## Evidence

### Packet Capture

- 200 packets.
- Source `192.168.10.10`.
- Destination `192.168.20.10`.
- 100 unique destination ports.
- SHA-256 `9e11b256d17567bfb9920b4e96e73771282ce1eb6e071782757da9d735c5f7b0`.

### Zeek

- 200 `conn.log` entries.
- All connection states `S0`.
- 100 unique destination ports.
- Trace warning correctly indicated TCP control packets only.

### Suricata

- Signature `LOCAL P2 TCP SYN Scan`.
- SID `1000003`, revision `2`.
- 195 alert records after the detection threshold was reached.

### Python Detector

- 100 unique ports.
- 200 failed connections.
- 2 administrative-service attempts.
- Signals: `high_unique_port_count`, `high_failed_connection_count`.
- Score 50, Medium.

### Wazuh

- Parent event rule `100200`.
- Medium child rule `100201`.
- Wazuh level 7.
- Expanded fields visible in dashboard evidence.

## Analyst Assessment

The activity is highly consistent with a TCP SYN port scan because one user-network source contacted many ports on one DMZ host within less than two seconds and none of the captured attempts completed. Confidence is high within the controlled lab.

In production, severity would depend on whether the source is an approved scanner, whether the target is scheduled for assessment, firewall policy, authentication/endpoint context, and whether the behavior continued to exploitation.

## Impact

No operational impact occurred. The target and source were lab-owned systems, and the activity was intentionally generated. No successful access, data transfer, persistence, or malware execution was observed.

## Recommended Response for a Real Environment

1. Confirm whether the source is an authorized scanner.
2. Identify the source owner, hostname, user, and endpoint process.
3. Review firewall permits/denies and scan scope.
4. Search Zeek/Suricata for other targets and protocols from the source.
5. Review authentication and endpoint telemetry for follow-on activity.
6. If unauthorized, contain or restrict the source and preserve evidence.
7. Tune detections only after documenting the disposition.

## Containment in This Lab

Automatic containment was intentionally out of scope. The project validated detection and analyst triage only. Existing pfSense and EDR capabilities can be used by later purple-team phases to validate response.

## Final Disposition

**True positive, authorized simulation.** Detection chain validated successfully. No additional technical screenshot is required for Phase 1.
