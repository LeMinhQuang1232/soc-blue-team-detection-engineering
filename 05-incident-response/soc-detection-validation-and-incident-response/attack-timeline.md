# Incident and Retest Timeline

All timestamps use `Asia/Ho_Chi_Minh` (`UTC+07:00`) as recorded by the execution log. Dashboard timestamps may require timezone normalization during correlation.

## Initial Run — August 1, 2026

| Timestamp | Test ID | Activity | Status / note |
|---|---|---|---|
| 21:25:34.088 | P1-INC01 | Incident start | Controlled incident execution started. |
| 21:28:10.538 | P1-AUTH-01 | Authentication failure | Started. |
| 21:28:44.742 | P1-AUTH-01 | Authentication failure | Completed; five wrong-password attempts generated. |
| 21:35:45.570 | P1-EXEC-01 | Encoded PowerShell | Started. |
| 21:36:13.618 | P1-EXEC-01 | Encoded PowerShell | Completed. |
| 21:53:53.499 | P1-DISC-01 | System/account discovery | Started. |
| 21:54:32.599 | P1-DISC-01 | System/account discovery | Completed. |
| 22:02:03.516 | P1-DISC-02 | Network discovery | Started. |
| 22:07:50.744 | P1-DISC-02 | Network discovery | Completed. |
| 22:14:26.628 | P1-NET-01 | Bounded network reconnaissance | Started. |
| 22:19:53.938 | P1-NET-01 | Bounded network reconnaissance | Completed; twelve predefined ports tested. |
| 22:28:03.888 | P1-HTTP-01 | Controlled HTTP activity | Started. |
| 22:28:48.511 | P1-HTTP-01 | Controlled HTTP activity | Completed. |

## Retest — August 2, 2026

| Timestamp | Test ID | Activity | Status / note |
|---|---|---|---|
| 10:16:32.938 | P1-AUTH-01 | Authentication failure | Started. |
| 10:17:13.549 | P1-AUTH-01 | Authentication failure | Completed. |
| 10:17:21.591 | P1-EXEC-01 | Encoded PowerShell | Started. |
| 10:17:31.622 | P1-EXEC-01 | Encoded PowerShell | Completed. |
| 10:17:48.213 | P1-DISC-01 | System/account discovery | Started. |
| 10:18:33.484 | P1-DISC-01 | System/account discovery | Completed. |
| 10:18:41.103 | P1-DISC-02 | Network discovery | Started. |
| 10:18:56.847 | P1-DISC-02 | Network discovery | Completed. |
| 10:19:06.942 | P1-NET-01 | Bounded network reconnaissance | Started. |
| 10:24:54.614 | P1-NET-01 | Bounded network reconnaissance | Completed. |
| 10:26:21.717 | P1-HTTP-01 | Controlled HTTP activity | Started. |
| 10:27:24.251 | P1-HTTP-01 | Controlled HTTP activity | Completed. |

## Containment and Recovery Anchors — August 2, 2026

| Timestamp | Activity | Result |
|---|---|---|
| 10:59:07.861 | Pre-isolation connectivity check | DMZ TCP/80 and pfSense TCP/443 reachable. |
| 11:01:29.600 | Time anchor | Local endpoint time recorded. |
| 11:02:14.992 | Post-isolation connectivity check | Both tested TCP connections failed; ping showed 100% loss. |
| 11:10:30–11:10:32 | EDR management check | LimaCharlie sensor returned system information while isolated. |
| 11:10:51 | `rejoin_network` | LimaCharlie task returned success. |
| 11:11:00.794 | Post-recovery check | DMZ TCP/80 and pfSense TCP/443 reachable again. |
| 13:36:45 | Retest isolation | Second `segregate_network` task returned success. |
| 13:46:58.358–13:48:49.740 | Final PCAP recapture | 5,246 packets captured over 111.382056 seconds. |
