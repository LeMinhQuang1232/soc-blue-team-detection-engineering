# Validation Summary

| Test ID | Scenario | Expected result | Actual result | Status |
|---|---|---|---|---|
| P2-T01 | Baseline web | Normal traffic remains below alert threshold | Scores were `0`; no alert file entries | Passed |
| P2-T02 | ICMP host discovery | Multiple destination hosts identified | 6 hosts; tuned score `35`; Suricata SID `1000004` | Passed |
| P2-T03 | Administrative service probing | Failed/admin-service behavior identified | 6 ports, 12 failures, 6 admin attempts; score `35`/`55` | Passed |
| P2-T04 | HTTP path probing | Unique URI burst identified | 9 URIs; tuned score `35`; Suricata SID `1000006` | Passed |
| P2-T05 | TCP SYN scan packet validation | SYN-only scan visible in PCAP/Wireshark | 200 captured packets targeting ports 1-100 | Passed |
| P2-T06 | Zeek TCP scan metadata | Many ports and failed states recorded | 100 unique ports; 200 `S0` records | Passed |
| P2-T07 | Suricata TCP scan | Local scan signature fires | 195 alerts, SID `1000003`, rev `2` | Passed |
| P2-T08 | Python TCP scan | Detector classifies and scores scan | `probable_port_scan`, score `50` Medium | Passed |
| P2-T09 | Wazuh integration | JSON is decoded and child rule fires | Rule `100201`, level `7`, expanded fields present | Passed |
| P2-T10 | Negative control | Baseline does not create a security alert | Baseline alert files are empty | Passed |

## Definition of Done

- At least three reconnaissance scenarios: completed.
- Baseline and reconnaissance PCAPs retained with hashes: completed.
- Same final traffic validated through PCAP, Zeek, Suricata, Python, and Wazuh: completed.
- Threshold tuning documented: completed.
- False-positive and limitation analysis documented: completed.
- Public repository package cleaned of transient or obsolete files: completed.
