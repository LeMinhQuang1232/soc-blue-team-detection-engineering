# Incident Report — Web Attack Pattern Attempts

## 1. Executive Summary

Nginx received controlled requests containing encoded SQL injection, XSS, and path-traversal patterns from `192.168.56.20`. Wazuh generated custom rules 100130 and 100131, producing four attack-pattern alerts. The case is rated **Medium** because the requests reached the web service, but the observed responses were HTTP 404 or 400 and no successful exploitation or follow-on activity was identified.

## 2. Alert Details

| Field | Value |
|---|---|
| Alert Name | Possible SQL injection / XSS / path traversal pattern |
| Severity | Medium |
| Detection Time | 2026-07-18 20:09–20:11 ICT |
| Source IP | 192.168.56.20 |
| Destination Host | SOC-WAZUH / 192.168.56.10 |
| User | N/A |
| Data Source | Nginx `/var/log/nginx/access.log` |
| Wazuh Rule ID | 100130 and 100131, level 10 |
| MITRE ATT&CK | T1190 — Exploit Public-Facing Application |

## 3. Evidence

| Time | Evidence | Interpretation |
|---|---|---|
| 20:09:16 ICT | Rule 100130 for `q=%27%20OR%201%3D1--` | Encoded SQL injection condition matched; HTTP 404 |
| 20:10:21 ICT | Rule 100131 for encoded `<script>alert(1)</script>` | XSS signature matched; HTTP 404 |
| 20:11:05 ICT | Rule 100131 for `/%2E%2E/%2E%2E/etc/passwd` | Traversal signature matched; HTTP 400 |
| Test window | Four custom web-alert hits | Two SQLi and two XSS/traversal events were detected |
| Test window | Normal `/` and `/search?q=normal` requests in access log | Baseline traffic was present but did not appear in the custom web-alert result set |

## 4. Timeline

| Time | Activity |
|---|---|
| Before attack tests | Normal root and search requests establish baseline behavior. |
| 20:09:16 ICT | Encoded SQL injection OR condition triggers rule 100130. |
| 20:10:21 ICT | Encoded script tag triggers rule 100131. |
| 20:11:05 ICT | Encoded traversal request triggers rule 100131. |
| After tests | Analyst compares source logs, response codes, and custom alerts. |

## 5. Analysis

The source access log and Wazuh alerts agree on the source IP, URLs, status codes, and time window. The custom rules correctly separated attack-pattern requests from the normal baseline. The server returned 404 for the tested search paths and 400 for traversal, which reduces the likelihood of successful exploitation in this specific lab. A signature match alone cannot determine whether a vulnerable application processed the input, so application logs and response-body context would be needed in a real incident.

## 6. Impact

- Affected service: Nginx on `SOC-WAZUH`.
- Availability impact: none observed.
- Data access: no evidence that `/etc/passwd` or application data was returned.
- Application compromise: not demonstrated.

## 7. Containment

In a real environment:

- Block or rate-limit the source after confirming it is unauthorized.
- Review reverse-proxy, application, WAF, and endpoint logs for successful execution or data access.
- Preserve full request context and response metadata.
- Search for related requests from the same source and similar payload variants.

## 8. Remediation

- Use parameterized queries and strict server-side input validation.
- Apply output encoding and a suitable Content Security Policy for XSS risk reduction.
- Normalize and validate paths before filesystem access.
- Patch the web application and dependencies.
- Add WAF controls and tune SIEM signatures using real application routes.

## 9. False Positive Assessment

Security scanners, developers, and users searching for literal security strings may trigger these rules. The source, timing, and payloads in this case were intentionally generated in the isolated lab, so the alerts are true positives for the simulated requests.

## 10. Final Verdict

True Positive — Authorized Lab Simulation.

## 11. Lessons Learned

- Nginx telemetry can support useful pattern detections even without a full web application.
- HTTP status and application context are necessary to distinguish an attempted exploit from a successful exploit.
- Parent-rule IDs in the deployed XML should be reconciled with the original built-in-rule assessment and regression-tested.
