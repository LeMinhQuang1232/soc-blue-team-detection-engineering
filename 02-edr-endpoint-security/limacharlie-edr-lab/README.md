# LimaCharlie EDR Detection and Response Lab

## Overview

This project extends the existing Wazuh and Sysmon environment with LimaCharlie EDR. It demonstrates endpoint sensor deployment, process telemetry analysis, Detection and Response rule development, endpoint investigation, EDR-to-SIEM correlation, and network isolation testing.

The project is presented as the third completed portfolio phase so it follows the two existing Wazuh projects. It was originally planned later in the learning roadmap; therefore, the literal test marker `Week4-EDR-Test` remains visible in the original evidence.

## What I Built

- A Windows endpoint connected to the LimaCharlie EDR platform.
- A detection rule for PowerShell processes using encoded-command arguments.
- An investigation workflow using process telemetry and command-line context.
- A containment test using endpoint network segregation.
- A recovery procedure using network rejoin and post-containment service validation.
- Evidence documenting detection, investigation, containment, and recovery steps.

## What I Learned

- Behavioral endpoint telemetry provides more useful context than relying only on filenames or hashes.
- An encoded PowerShell argument is an investigation signal but is not independently proof of malicious activity.
- Network isolation can interrupt other monitoring agents and services, so containment must include a recovery checklist.
- Response actions should be verified from both the EDR console and the affected endpoint.

## Key Results

| Test Area | Result |
|---|---|
| LimaCharlie Windows sensor | Passed |
| Sensor service running automatically | Passed |
| Encoded PowerShell telemetry | Passed |
| LimaCharlie encoded-PowerShell alert | Passed |
| Windows reconnaissance detection | Passed |
| Sysmon process correlation | Passed |
| Wazuh encoded PowerShell correlation | Passed |
| Network isolation effect | Passed |
| Isolation console completion | Partial |
| Network rejoin and recovery | Pending Evidence |

## Project Files

- [Detailed report](report.md)
- [Evidence log](evidence-log.md)
- [Validation tests](validation-tests.md)
- [LimaCharlie D&R rules](detection-rules.yml)
- [Suspicious PowerShell detection](detections/suspicious-powershell.md)
- [Windows reconnaissance detection](detections/windows-reconnaissance.md)
- [Network isolation response](detections/network-isolation-response.md)
- [Suspicious PowerShell incident report](incident-reports/suspicious-powershell-incident.md)
- [Reconnaissance incident report](incident-reports/windows-reconnaissance-incident.md)
- [Screenshots](screenshots/)

## Main Evidence

### Sensor Deployment

[![LimaCharlie sensor online](screenshots/01-setup/01-sensor-online.png)](screenshots/01-setup/01-sensor-online.png)

### Reconnaissance Detection

[![Reconnaissance detections](screenshots/03-reconnaissance/03-detections-overview.png)](screenshots/03-reconnaissance/03-detections-overview.png)

### Wazuh Correlation

[![Wazuh encoded PowerShell alert](screenshots/02-suspicious-powershell/04-wazuh-encoded-alert.png)](screenshots/02-suspicious-powershell/04-wazuh-encoded-alert.png)

### Network Isolation

[![Connectivity blocked after isolation](screenshots/04-containment/03-connectivity-blocked.png)](screenshots/04-containment/03-connectivity-blocked.png)

## Safety Notice

All activity was generated on authorized systems in an isolated personal lab. The encoded PowerShell test only executed `Write-Output`; the discovery commands were standard Windows utilities.

<!-- EVIDENCE-NAVIGATION:START -->
## Evidence Navigation

- [Complete screenshot evidence index](screenshots/evidence-index.md)
- [Technical report](report.md)
- [Evidence log](evidence-log.md)
- [Validation tests](validation-tests.md)

<!-- EVIDENCE-NAVIGATION:END -->
