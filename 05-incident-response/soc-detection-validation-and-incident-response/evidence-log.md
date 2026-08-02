# Evidence Log

| Evidence range | Source | Finding supported | Status |
|---|---|---|---|
| 001–014 | Windows, Ubuntu, pfSense, Grafana, LimaCharlie | Baseline health and readiness | Supporting |
| 015, 062 | PowerShell execution record | Exact initial and retest sequence | Primary |
| 017 | Windows Security | Five controlled authentication failures | Primary |
| 018–024 | Sysmon, Wazuh, LimaCharlie | Encoded PowerShell detection | Primary |
| 025–030 | Endpoint and Wazuh | System/account discovery | Primary |
| 031–051 | Endpoint and Wazuh | Network discovery | Primary |
| 052 | Endpoint execution | Twelve-port bounded probe | Primary execution evidence |
| 053–061 | Endpoint, Nginx, Wazuh | File transfer and SQLi-like request | Primary |
| 066–074 | Zeek, Suricata, Python | Network correlation and documented limitation | Primary for gap analysis |
| 075–080 | Endpoint and LimaCharlie | Containment, sensor continuity, and recovery | Primary |
| 081–101 | Wazuh and LimaCharlie | Retest and second isolation | Primary / supporting |
| 102–103 | capinfos and sha256sum | Final PCAP metadata and integrity | Primary |

For per-image hashes, filenames, timestamps, and descriptions, see [screenshots/evidence-index.md](screenshots/evidence-index.md).
