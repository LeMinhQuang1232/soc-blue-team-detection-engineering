# Evidence Log

## Evidence Status Summary

| Evidence ID | Description | File | Status |
|---|---|---|---|
| EDR-E01 | LimaCharlie sensor online | `screenshots/01-setup/01-sensor-online.png` | Complete |
| EDR-E02 | LimaCharlie service running automatically | `screenshots/01-setup/02-service-running.png` | Complete |
| EDR-E03 | Safe encoded PowerShell command | `screenshots/02-suspicious-powershell/01-safe-test-command.png` | Complete |
| EDR-E04 | LimaCharlie PowerShell process telemetry | `screenshots/02-suspicious-powershell/02-limacharlie-process-telemetry.png` | Complete |
| EDR-E05 | Wazuh PowerShell hunt results | `screenshots/02-suspicious-powershell/03-wazuh-powershell-hunt.png` | Complete |
| EDR-E06 | Wazuh encoded PowerShell alert | `screenshots/02-suspicious-powershell/04-wazuh-encoded-alert.png` | Complete |
| EDR-E07 | Benign PowerShell comparison | `screenshots/02-suspicious-powershell/05-benign-powershell-comparison.png` | Complete |
| EDR-E08 | Reconnaissance D&R rule | `screenshots/03-reconnaissance/01-recon-rule.png` | Complete |
| EDR-E09 | Reconnaissance unit tests | `screenshots/03-reconnaissance/02-rule-unit-tests.png` | Complete |
| EDR-E10 | Four reconnaissance detections | `screenshots/03-reconnaissance/03-detections-overview.png` | Complete |
| EDR-E11 | Expanded reconnaissance event context | `screenshots/03-reconnaissance/04-detection-event-context.png` | Complete |
| EDR-E12 | Sysmon `ipconfig /all` evidence | `screenshots/03-reconnaissance/05-sysmon-ipconfig-process.png` and `06-sysmon-ipconfig-parent.png` | Complete |
| EDR-E13 | Sysmon `net localgroup administrators` evidence | `screenshots/03-reconnaissance/07-sysmon-localgroup-process.png` and `08-sysmon-localgroup-parent.png` | Complete |
| EDR-E14 | Sysmon `whoami /priv` evidence | `screenshots/03-reconnaissance/09-sysmon-whoami-process.png` and `10-sysmon-whoami-parent.png` | Complete |
| EDR-E15 | Connectivity before isolation | `screenshots/04-containment/01-connectivity-before.png` | Complete |
| EDR-E16 | Isolation console request | `screenshots/04-containment/02-segregate-network-awaiting.png` | Partial — command remained `AWAITING` |
| EDR-E17 | Traffic blocked after isolation request | `screenshots/04-containment/03-connectivity-blocked.png` | Complete |
| EDR-E18 | LimaCharlie encoded-PowerShell detection card | Not captured | Pending Evidence |
| EDR-E19 | `rejoin_network` completion | Not captured | Pending Evidence |
| EDR-E20 | Restored ping and HTTP connectivity | Not captured | Pending Evidence |

## Screenshots Removed from the Public Project

The original archive contained additional zoomed, repeated, or raw-detail screenshots. They were omitted because the retained evidence already supports the relevant findings. Removing them keeps the repository readable without changing validation results.

## Timezone Note

LimaCharlie and Sysmon evidence displays UTC. The Wazuh dashboard evidence displays UTC+7 in this lab. Correlation was performed after accounting for the seven-hour display difference.
