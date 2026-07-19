# SOC Blue Team Detection Engineering Portfolio

## Overview

This repository contains hands-on SOC and Blue Team projects focused on log collection, detection engineering, endpoint investigation, alert validation, and incident reporting.

The environment uses Windows Server, Ubuntu, Sysmon, Wazuh, Nginx, and LimaCharlie. All test activity was performed in an isolated and authorized lab with harmless commands.

## Project Progress

| Sequence | Project | Status | Main Skills |
|---|---|---|---|
| 1 | [Wazuh Log Onboarding](01-siem/wazuh-log-onboarding/) | Completed | Windows, Sysmon, Linux, and Nginx log collection |
| 2 | [Wazuh Detection Engineering](01-siem/wazuh-detection-engineering/) | Completed | Custom detections, alert validation, and incident reports |
| 3 | [LimaCharlie EDR Detection and Response](02-edr-endpoint-security/limacharlie-edr-lab/) | Completed with documented evidence gaps | Endpoint telemetry, D&R rules, EDR/SIEM correlation, and isolation testing |
| Future | Splunk SIEM Investigation | Planned | SPL searches, dashboards, and investigation workflow |

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
