# Validation Tests

Reusable source-test mapping is documented in [`incident-tests/P1-INC01-R1-test-mapping.md`](incident-tests/P1-INC01-R1-test-mapping.md).

| ID | Validation | Expected result | Actual result | Status | Primary evidence |
|---|---|---|---|---|---|
| P1-V01 | Baseline service health | Core telemetry and security services active | Wazuh, Sysmon, Defender, LimaCharlie, Nginx, Suricata, and supporting services checked | Passed | Screenshots 001–014 |
| P1-V02 | Five failed logons | Event ID 4625 records | Repeated 4625 events visible | Passed | Screenshot 017 |
| P1-V03 | Encoded PowerShell | Endpoint, SIEM, and EDR evidence | Sysmon, Wazuh 92057, and LimaCharlie evidence present | Passed | Screenshots 018–024 |
| P1-V04 | System/account discovery | Dedicated discovery evidence | Command output and Wazuh 100132 present | Passed | Screenshots 025–030 |
| P1-V05 | Network discovery | Native command and SIEM evidence | Five discovery commands and Wazuh 100140 present | Passed | Screenshots 031–051 |
| P1-V06 | Bounded twelve-port probe | Network metadata and behavioral detection | Transcript proves execution; derived network evidence incomplete | Partial | Screenshots 052, 066–074 |
| P1-V07 | Controlled HTTP download | Application/network/SIEM correlation | Curl, Nginx, Zeek HTTP, and Wazuh 100154 present | Passed | Screenshots 053–058, 068 |
| P1-V08 | SQLi-like URI | Web log and detection | Nginx/Zeek recorded request; Wazuh 100130 alerted | Passed | Screenshots 055–061, 068 |
| P1-V09 | Endpoint isolation | Normal connectivity blocked | Tested TCP connections and ping failed after isolation | Passed | Screenshots 075–077 |
| P1-V10 | Sensor continuity | EDR control remains available | LimaCharlie returned system information while isolated | Passed | Screenshot 078 |
| P1-V11 | Endpoint recovery | Connectivity restored after rejoin | Rejoin succeeded and both tested TCP services became reachable | Passed | Screenshots 079–080 |
| P1-V12 | Initial/retest repeatability | Core detections repeat | Wazuh and LimaCharlie evidence repeated | Passed with limitation | Screenshots 081–101 |
| P1-V13 | Final PCAP integrity | Non-empty capture with metadata and hash | 5,246 packets, 4.3 MB, SHA-256 verified | Passed for metadata/hash | Screenshots 102–103 |
