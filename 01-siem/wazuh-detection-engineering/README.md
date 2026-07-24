# Wazuh Detection Engineering

## Overview

This project extends the Week 1 Wazuh log-onboarding lab by creating, testing, and documenting detection use cases for Windows, Linux, Sysmon, and Nginx telemetry.

## Objectives

- Assess Wazuh built-in decoders and rules.
- Develop custom detection rules.
- Validate rule loading with `wazuh-analysisd -t` and test sample matching with `wazuh-logtest`.
- Generate safe authentication, process, and web-attack simulations.
- Map detections to MITRE ATT&CK.
- Perform alert triage.
- Write SOC-style incident reports.

## What I Built

- Custom Wazuh rules for SSH brute-force activity, repeated Windows logon failures, suspicious PowerShell execution, SQL injection, and XSS patterns.
- Controlled attack-simulation and validation procedures using benign lab commands.
- Detection documents explaining the data source, rule logic, expected result, MITRE ATT&CK mapping, and limitations.
- Incident reports for SSH brute force, suspicious PowerShell, and web attack activity.
- A repeatable rule-testing workflow using raw logs, Wazuh Logtest, dashboard searches, and expanded alert evidence.

## What I Learned

- A custom Wazuh rule depends on the correct decoder and parent rule before frequency or pattern logic can work.
- Detection validation requires both positive tests and normal baseline activity.
- A matching command-line string does not automatically prove malicious intent; process context and surrounding telemetry still matter.
- Detection documentation should separate configured logic, observed telemetry, and conclusions supported by evidence.

## Environment

| Host | IP | Role |
|---|---|---|
| SOC-WAZUH | 192.168.56.10 | Wazuh server, SSH server, and Nginx web server |
| WIN-ENDPOINT | 192.168.56.20 | Windows Server 2022 endpoint with Wazuh agent and Sysmon |

The evidence shows Wazuh version 4.14.6 and both lab agents in an active state.

## Detection Use Cases

| Detection | Data Source | Custom Rule | MITRE | Validation |
|---|---|---:|---|---|
| SSH brute force | Linux `auth.log` | 100100 | T1110 | Passed |
| Windows failed logons | Security Event ID 4625 | 100110 | T1110 | Passed |
| Successful logon after failures | Event IDs 4625 and 4624 | Analyst correlation | T1110 | Passed |
| Suspicious PowerShell | Sysmon Event ID 1 | 100120 | T1059.001 | Passed |
| SQL injection pattern | Nginx `access.log` | 100130 | T1190 | Passed |
| XSS/path traversal pattern | Nginx `access.log` | 100131 | T1190 | Passed |

## Validation Note

Seven positive or correlation tests were documented. The normal web-request negative test is supported by the source log and custom-alert result set. The normal PowerShell negative test remains **Pending Evidence** because the supplied screenshots do not show both a benign PowerShell event and a time-bounded query proving that rule 100120 did not fire.

## Project Contents

- [`custom-rules.xml`](./custom-rules.xml)
- [`wazuh-logtest-results.md`](./wazuh-logtest-results.md)
- [`validation-tests.md`](./validation-tests.md)
- [`evidence-log.md`](./evidence-log.md)
- [`detections/`](./detections/)
- [`incident-reports/`](./incident-reports/)
- [`report.md`](./report.md)
- [`screenshots/`](./screenshots/)

## Key Result

The lab transformed previously onboarded telemetry into evidence-backed Wazuh detections and SOC-style investigations. It also identified a negative-test evidence gap and a parent-rule consistency issue that should be addressed during future tuning.

## Safety Notice

All activities were performed in an isolated personal lab using authorized systems and harmless test commands. No malware, destructive payload, or unauthorized external target was used.

<!-- EVIDENCE-NAVIGATION:START -->
## Evidence Navigation

- [Complete screenshot evidence index](screenshots/evidence-index.md)
- [Technical report](report.md)
- [Evidence log](evidence-log.md)
- [Validation tests](validation-tests.md)

<!-- EVIDENCE-NAVIGATION:END -->
