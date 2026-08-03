# Retest Results

## Retest Objective

Repeat the core endpoint, SIEM, HTTP, EDR, and response steps after the initial investigation and compare the results with the first run.

| Incident step | Initial result | Retest result | Final conclusion |
|---|---|---|---|
| P1-EXEC-01 | Encoded PowerShell observed in Sysmon, Wazuh, and LimaCharlie | Wazuh and LimaCharlie evidence repeated | Passed |
| P1-HTTP-01 | File transfer correlated across curl, Nginx, Zeek HTTP, and Wazuh | HTTP/SIEM evidence repeated | Passed |
| P1-HTTP-02 | SQLi-like request generated web and Wazuh evidence | Core web-detection workflow remained available | Passed within collected evidence |
| P1-RESP-01 | Isolation blocked normal traffic; rejoin restored connectivity | A second isolation success was captured | Passed for isolation; the evidence set does not prove a second complete rejoin cycle |
| P1-NET-01 | Execution proven; derived network diversity incomplete | No complete regenerated Zeek/Python/Suricata evidence set was supplied | Partial |

## Before-and-After Finding

The retest confirmed repeatability for endpoint, SIEM, HTTP, and EDR evidence. It did not close the network behavioral attribution gap because the final non-empty PCAP was integrity-checked, but the final regenerated Zeek, Suricata, Python, and Wazuh outputs were not included in the evidence package.

## Required Future Retest

1. Start packet capture before the bounded probe.
2. Record the exact capture interface and start/end times.
3. Run the twelve-port probe once.
4. Stop capture after traffic completion.
5. Generate Zeek logs from that exact PCAP.
6. Run the Python detector against those exact Zeek logs.
7. Isolate Suricata events to the same time window and five-tuple.
8. Ingest the resulting detector JSON into Wazuh.
9. Compare the observed unique port count with the execution record.
10. Preserve PCAP metadata, hash, derived logs, and Wazuh evidence together.
