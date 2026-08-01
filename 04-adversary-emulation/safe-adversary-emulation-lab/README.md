# Safe Adversary Emulation and ATT&CK-Aligned Detection Testing

## Overview

This project builds a repeatable and controlled validation workflow for creating attacker-like telemetry without using real malware. All activity was executed inside owned VirtualBox virtual machines, with snapshots, explicit scope, cleanup steps, and evidence collection.

The project reuses the existing Windows endpoint, Wazuh, LimaCharlie, pfSense, Nginx, Suricata, Zeek, and Python reconnaissance detector from earlier portfolio phases.

## What I Built

- A written rules-of-engagement and lab-isolation policy.
- Snapshot and recovery evidence for the authorized virtual machines.
- An eight-test catalog covering endpoint execution, discovery, authentication, file transfer, network reconnaissance, and antivirus validation.
- ATT&CK-aligned expected telemetry for each test.
- Cross-layer validation using Windows Security, Sysmon, Defender, LimaCharlie, Wazuh, Nginx, Zeek, Suricata, pfSense, and Python detector output.
- A capability matrix that distinguishes validated coverage, partial coverage, collection gaps, detection gaps, and cleanup status.
- An evidence library containing 164 screenshots with stable IDs and SHA-256 hashes.
- Troubleshooting records for real lab failures instead of presenting only successful outcomes.

## What I Learned

- Safe emulation requires scope, snapshots, cleanup, and evidence planning before command execution.
- Telemetry and detection are different: a command may be recorded without producing a high-confidence alert.
- One test can appear differently across Sysmon, EDR, SIEM, Zeek, Suricata, and firewall logs.
- High-volume startup activity can flood a Wazuh agent buffer and affect evidence completeness.
- Live IDS logs must be isolated by timestamp and test ID because historical records can be mistaken for current results.
- Reusing a validated dataset is useful, but replay evidence must be labeled separately from newly generated traffic.
- An alert is a signal for investigation, not automatic proof of compromise.
- Cleanup validation is part of the test result, not an optional final step.

## Test Summary

| Test ID | Activity | ATT&CK / Purpose | Result |
|---|---|---|---|
| P4-EXEC-01 | Benign encoded PowerShell | T1059.001 | Validated |
| P4-DISC-01 | System information discovery | T1082 | Validated |
| P4-DISC-02 | Network configuration and connection discovery | T1016 / supporting connection discovery | Validated |
| P4-DISC-03 | Account and policy discovery | T1087 / T1059.003 | Validated |
| P4-AUTH-01 | Controlled failed authentication | T1110-aligned simulation | Validated |
| P4-FILE-01 | Controlled HTTP file transfer | T1105 | Validated |
| P4-NET-01 | Service probing and reconnaissance-detector replay | T1046 | Partial: Suricata attribution gap |
| P4-EICAR-01 | Antivirus detection and quarantine validation | Defensive control validation | Validated |

## Key Validated Detections

| Evidence | Result |
|---|---|
| Wazuh rule `92057`, level 12 | Encoded PowerShell, T1059.001 |
| Wazuh rule `100140`, level 8 | Windows network discovery, T1016 |
| Wazuh rule `100150`, level 8 | Controlled curl file download, T1105 |
| Wazuh rule `100201`, level 7 | Medium network reconnaissance, score 50 |
| Defender Event IDs `1116` and `1117` | EICAR detection and successful quarantine |
| Wazuh rules `62123` and `62124` | Defender detection and remediation events |

## Navigation

- [Full technical report](report.md)
- [Lab architecture](architecture.md)
- [Lab environment](lab-environment.md)
- [Rules of engagement](rules-of-engagement.md)
- [Snapshot and recovery](snapshot-and-recovery.md)
- [Test catalog](test-catalog/test-index.md)
- [ATT&CK mapping](mitre-attck/technique-mapping.md)
- [Expected telemetry](telemetry/expected-telemetry.md)
- [Actual telemetry](telemetry/actual-telemetry.md)
- [Capability matrix](test-results/capability-matrix.md)
- [Troubleshooting](troubleshooting/README.md)
- [Screenshot evidence](screenshots/evidence-index.md)

## Safety Notice

This repository does not include malware, credentials, tokens, VM disks, the EICAR string, or executable test artifacts. The EICAR standard antivirus test was generated only inside the isolated Windows VM and was quarantined and removed during cleanup.
