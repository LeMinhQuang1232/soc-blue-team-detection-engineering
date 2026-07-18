# SOC Blue Team Detection Engineering Portfolio

This repository contains hands-on SOC and Blue Team projects focused on log collection, SIEM operations, endpoint visibility, detection engineering, and incident analysis.

## Project Categories

- [SIEM Projects](01-siem/README.md)

## Current Projects

### 1. Wazuh Windows and Linux Log Onboarding

Built a local Wazuh SIEM lab in Oracle VirtualBox with:

- Wazuh manager, indexer, dashboard, and Filebeat on Ubuntu.
- A Windows Server 2022 endpoint with the Wazuh agent and Sysmon.
- Windows authentication-event collection.
- Sysmon process and file telemetry.
- Ubuntu SSH authentication monitoring.
- Nginx web-log collection and a safe SQL injection pattern test.

[Open the Week 1 project](01-siem/wazuh-log-onboarding/README.md)

### 2. Wazuh Detection Engineering

Extended the Week 1 telemetry pipeline by:

- Assessing Wazuh built-in rules and parent-rule behavior.
- Developing custom rules for authentication, PowerShell, and web activity.
- Validating detections through safe lab simulations.
- Mapping detections to MITRE ATT&CK.
- Performing alert triage and writing SOC-style incident reports.

[Open the Week 2 project](01-siem/wazuh-detection-engineering/README.md)

## Project Flow

1. Collect and validate logs.
2. Build detection logic.
3. Generate controlled test activity.
4. Validate and investigate alerts.
5. Document evidence, limitations, and recommendations.

## Safety

All tests are performed in controlled lab environments. Sensitive credentials, private keys, product keys, malware, and personal data are not included in this repository.
