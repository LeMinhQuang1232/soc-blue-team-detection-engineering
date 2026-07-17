# SOC Blue Team Detection Engineering Portfolio

This repository contains hands-on SOC and Blue Team projects focused on log collection, SIEM operations, endpoint visibility, detection engineering, and incident analysis.

## Project categories

- [SIEM Projects](01-siem/README.md)

## Current project

### Wazuh Windows and Linux Log Onboarding

Built a local Wazuh SIEM lab in Oracle VirtualBox with:

- Wazuh manager, indexer, dashboard, and Filebeat on Ubuntu.
- A Windows Server 2022 endpoint with the Wazuh agent and Sysmon.
- Windows authentication-event collection.
- Sysmon process and file telemetry.
- Ubuntu SSH authentication monitoring.
- Nginx web-log collection and a safe SQL injection pattern test.

[Open the project](01-siem/wazuh-log-onboarding/README.md)

## Safety

All tests are performed in controlled lab environments. Sensitive credentials, private keys, product keys, malware, and personal data are not included in this repository.
