# Detection Coverage and Gap Analysis

## Coverage Matrix

| Test | Primary detection or evidence | Status | Analyst conclusion |
|---|---|---|---|
| P1-AUTH-01 | Windows Security Event ID 4625 | Passed | Repeated controlled failures were visible at the endpoint layer. |
| P1-EXEC-01 | Wazuh rule 92057; Sysmon Event ID 1; LimaCharlie | Passed | Encoded PowerShell was consistently observable across endpoint, SIEM, and EDR. |
| P1-DISC-01 | Wazuh rule 100132 | Passed | System and user discovery generated a dedicated alert. |
| P1-DISC-02 | Wazuh rule 100140 | Passed | Multiple network-discovery commands generated dedicated alerts. |
| P1-NET-01 | Transcript, Zeek, Suricata, Python detector | Partial | The test definitely executed, but the analyzed initial network input did not contain enough unique ports for the intended behavioral classification. |
| P1-HTTP-01 transfer | Nginx, Zeek HTTP, Wazuh rule 100154 | Passed | The benign transfer correlated across application, network metadata, and SIEM. |
| P1-HTTP-01 SQLi-like URI | Nginx, Zeek HTTP, Wazuh rule 100130 | Passed | The controlled URI was recorded and alerted. |
| Containment | LimaCharlie and connectivity tests | Passed | Isolation blocked normal networking while preserving EDR control. |
| Recovery | LimaCharlie and connectivity tests | Passed | Rejoin restored normal access. |

## Confirmed Gap

**Network behavioral reconstruction was incomplete.** The execution record shows twelve predefined ports were tested, but the initial Zeek query showed only three unique destination ports and the Python detector produced a low-risk `baseline_or_low_activity` classification. This is a collection/input and attribution limitation, not evidence that the controlled probe did not occur.

## Collection Risk

The Wazuh agent reported that its local buffer reached 90 percent and was discarding events before later dropping below 70 percent. High-volume startup periods can therefore delay or lose events and weaken exact cross-layer correlation.

## Suricata Limitation

The reviewed EVE output was dominated by `SURICATA IPv4 invalid checksum` events and a small number of flow records. These entries were not cleanly attributable to the bounded probe. They are retained as troubleshooting evidence rather than claimed as a validated reconnaissance alert.

## Evidence Classification

* **Fact:** directly visible in a screenshot or execution record.
* **Inference:** an analyst interpretation supported by multiple facts.
* **Unknown:** not provable from the supplied evidence.

No evidence in this project supports persistence, credential compromise, lateral movement, exfiltration, malware execution, or impact outside the authorized lab.
