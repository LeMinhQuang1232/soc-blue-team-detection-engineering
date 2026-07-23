# Incident Report — Suricata Web Attack and Scan Detection

## Executive Summary

Safe HTTP requests containing SQL injection and XSS patterns were sent from the Windows test client to Nginx on the Ubuntu DMZ server. A controlled SYN burst was also generated. Suricata local rules produced alerts for SIDs `1000001`, `1000002`, and `1000003`, and EVE JSON exposed the source, destination, ports, protocol, signature, and severity. Nginx access logs confirmed that the web requests reached the server. No vulnerable application or database was exploited.

## Detection details

| SID | Detection | Result |
|---|---|---|
| 1000001 | SQLi URI containing `union` and `select` | Alerted |
| 1000002 | XSS URI containing `<script` | Alerted |
| 1000003 | 15 SYN packets in ten seconds by source | Alerted |

## MITRE ATT&CK Mapping

| Tactic | Technique | ID | Rationale |
|---|---|---|---|
| Initial Access | Exploit Public-Facing Application | T1190 | Web attack patterns targeted a DMZ service |
| Discovery | Network Service Discovery | T1046 | SYN burst modeled service scanning |

## Analysis

The signatures correctly recognized the intended strings and packet pattern. The alerts should be treated as evidence of suspicious input, not proof of successful exploitation. Application response, server logs, process telemetry, file changes, and database activity would be required to establish impact.

## Response recommendations

- Preserve the raw request and EVE JSON event.
- Review application response codes and Nginx logs.
- Look for repeated sources, payload variants, and follow-on activity.
- Tune simple signatures and add application-aware controls such as input validation or a WAF.
- Forward Suricata events to a SIEM for correlation.
