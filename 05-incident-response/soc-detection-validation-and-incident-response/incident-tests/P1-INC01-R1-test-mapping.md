# P1-INC01-R1 Test Mapping

| Incident ID | Incident step | Source test | Expected evidence | Actual evidence | Result |
|---|---|---|---|---|---|
| P1-INC01-R1 | P1-AUTH-01 | P4-AUTH-01 | Windows Security and Wazuh authentication evidence | Repeated Event ID 4625 evidence was preserved | Passed |
| P1-INC01-R1 | P1-EXEC-01 | P4-EXEC-01 | Sysmon, Wazuh, and LimaCharlie process telemetry | Sysmon, Wazuh rule `92057`, and LimaCharlie recorded the execution | Passed |
| P1-INC01-R1 | P1-DISC-01 | P4-DISC-01 | Native discovery output and SIEM evidence | Command output and Wazuh rule `100132` were observed | Passed |
| P1-INC01-R1 | P1-DISC-02 | P4-DISC-02 | Network discovery commands and SIEM evidence | Native commands and Wazuh rule `100140` were observed | Passed |
| P1-INC01-R1 | P1-NET-01 | P4-NET-01 | PCAP/Zeek/Suricata/Python/Wazuh correlation | Execution was proven, but the derived network evidence did not preserve the full twelve-port diversity | Partial |
| P1-INC01-R1 | P1-HTTP-01 | P4-FILE-01 | Endpoint, Nginx, Zeek HTTP, and Wazuh evidence | Curl, Nginx, Zeek HTTP, and Wazuh rule `100154` correlated | Passed |
| P1-INC01-R1 | P1-HTTP-02 | Incident-specific web validation | Nginx/Zeek request evidence and Wazuh SQLi alert | Nginx, Zeek HTTP, and Wazuh rule `100130` recorded the request | Passed |
| P1-INC01-R1 | P1-RESP-01 | Existing LimaCharlie response workflow | Isolation, sensor continuity, rejoin, and restored connectivity | Normal traffic stopped, the sensor remained reachable, and connectivity returned after rejoin | Passed |

## Interpretation

A Passed result means the required execution and supporting evidence were preserved. A Partial result means the activity occurred, but one or more expected evidence layers were incomplete or could not be attributed confidently.
