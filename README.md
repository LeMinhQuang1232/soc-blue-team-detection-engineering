# SOC Blue Team Detection Engineering Portfolio

## Overview

This repository contains hands-on SOC and Blue Team projects focused on log collection, detection engineering, endpoint investigation, alert validation, and incident reporting.

The environment uses Windows Server, Ubuntu, Sysmon, Wazuh, Nginx, and LimaCharlie. All test activity was performed in an isolated and authorized lab with harmless commands.

## Project Progress

| Sequence | Project | Status | Main Skills |
|---|---|---|---|
| 1 | [Wazuh Log Onboarding](01-siem/wazuh-log-onboarding/) | Completed | Windows, Sysmon, Linux, and Nginx log collection |
| 2 | [Wazuh Detection Engineering](01-siem/wazuh-detection-engineering/) | Completed | Custom detections, alert validation, and incident reports |
| 3 | [LimaCharlie EDR Detection and Response](02-edr-endpoint-security/limacharlie-edr-lab/) | Completed | Endpoint telemetry, D&R rules, EDR/SIEM correlation, and isolation testing |

## Repository Structure

```text
soc-blue-team-detection-engineering/
├── README.md
├── 01-siem/
│   ├── README.md
│   ├── wazuh-log-onboarding/
│   └── wazuh-detection-engineering/
└── 02-edr-endpoint-security/
    ├── README.md
    └── limacharlie-edr-lab/
```

## Skills Demonstrated

- SIEM log onboarding and validation
- Windows Event Log and Sysmon analysis
- Wazuh detection engineering and threat hunting
- LimaCharlie sensor deployment and endpoint telemetry
- Detection and Response rule development
- Suspicious PowerShell and reconnaissance detection
- EDR and SIEM event correlation
- MITRE ATT&CK mapping
- Endpoint network isolation testing
- Evidence-based SOC reporting

## Current EDR Project

The [LimaCharlie EDR Detection and Response Lab](02-edr-endpoint-security/limacharlie-edr-lab/) includes:

- Windows sensor deployment and service validation;
- safe encoded PowerShell telemetry;
- four validated Windows reconnaissance detections;
- Sysmon and Wazuh correlation;
- endpoint isolation testing;
- validation results that clearly distinguish `Passed`, `Partial`, and `Pending Evidence`.

## Safety Notice

No malware, credential theft, persistence, or destructive payload was used. The encoded PowerShell command only printed a test string.



<!-- WEEK5-NETWORK-SECURITY-START -->
## Project 4 — Firewall, IDS, and Metrics Monitoring

Week 5 adds a three-zone network-security lab built with pfSense, Suricata, Prometheus, Grafana, Nginx, and a Windows test client. The lab validates least-privilege firewall policy, blocked administrative access from a user zone, authorized SOC administration, signature-based network detection, host-metrics collection, controlled load testing, and evidence-based incident reporting.

| Area | Project | Status |
|---|---|---|
| Firewall and segmentation | [pfSense Segmentation Lab](03-firewall-network-security/pfsense-segmentation-lab/) | Completed |
| IDS / NSM | [Suricata IDS Lab](04-ids-ips-nsm/suricata-ids-lab/) | Completed |
| Detection-as-code | [Suricata Custom Rules](04-ids-ips-nsm/suricata-custom-rules/) | Completed |
| Monitoring | [Prometheus and Grafana Lab](05-monitoring-observability/prometheus-grafana-lab/) | Completed |
| Incident response | [Week 5 Incident Reports](07-incident-response/) | Completed |
| Full weekly report | [Week 5 Report](weekly-reports/week5-firewall-ids-monitoring-report.md) | Completed |

### Week 5 Highlights

- Segmented `USER_NET`, `DMZ_NET`, and `SOC_ADMIN` with pfSense.
- Allowed USER access to DMZ web services while denying SSH, SMB, RDP, Grafana, and Prometheus.
- Allowed controlled SOC_ADMIN access to DMZ SSH and monitoring services.
- Created Suricata rules for SQL injection, XSS, and TCP SYN scan behavior.
- Validated Suricata alerts through `fast.log` and `eve.json`.
- Collected Linux metrics with node_exporter and Prometheus.
- Visualized CPU, memory, disk, and network activity in Grafana.
- Documented troubleshooting for UFW, DNS/package installation, Suricata interface selection, Docker networking, and timestamp alignment.
<!-- WEEK5-NETWORK-SECURITY-END -->

