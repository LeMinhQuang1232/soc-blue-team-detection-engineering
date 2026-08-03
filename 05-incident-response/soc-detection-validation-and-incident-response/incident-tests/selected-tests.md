# Selected Tests for P1-INC01-R1

## Selection Principle

The incident reused only the safe tests required to create a multi-layer detection and response sequence. EICAR was not selected because antivirus validation was not required for this incident chain.

| Incident step | Reusable source | Phase 3 use | Selection status |
|---|---|---|---|
| `P1-AUTH-01` | `P4-AUTH-01` | Generate five controlled failed logons | Selected |
| `P1-EXEC-01` | `P4-EXEC-01` | Execute benign encoded PowerShell | Selected |
| `P1-DISC-01` | `P4-DISC-01` | Collect hostname, user, and operating-system discovery evidence | Selected |
| `P1-DISC-02` | `P4-DISC-02` | Run native network configuration and connection discovery commands | Selected |
| `P1-NET-01` | `P4-NET-01` | Perform a bounded twelve-port probe against the authorized DMZ target | Selected |
| `P1-HTTP-01` | `P4-FILE-01` | Download a benign text file over HTTP | Selected |
| `P1-HTTP-02` | Phase 3 incident-specific extension using the earlier Wazuh web-detection lab | Send a controlled SQLi-like URI to validate application and SIEM correlation | Added for this incident |
| — | `P4-DISC-03` | Full account and policy discovery was not required as a separate test in this incident | Not separately selected |
| — | `P4-EICAR-01` | Antivirus validation was outside this incident scope | Not selected |

## Why the IDs Change

`P4-*` identifies the reusable Project 6 test definition. `P1-*` identifies the execution step inside incident `P1-INC01-R1`.

Example:

```text
P4-NET-01 = reusable bounded reconnaissance test
P1-NET-01 = the use of that test inside P1-INC01-R1
```
