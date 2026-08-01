# Expected Telemetry Matrix

| Test | Security / Defender | Sysmon | LimaCharlie | Wazuh | Nginx / Zeek | Suricata / pfSense |
|---|---|---|---|---|---|---|
| P4-EXEC-01 | — | Process | Process | Encoded-PowerShell alert | — | — |
| P4-DISC-01 | — | Process | Process | Discovery event | — | — |
| P4-DISC-02 | — | Process | Process | T1016 discovery alert | — | — |
| P4-DISC-03 | — | Process | Optional | T1087 event | — | — |
| P4-AUTH-01 | 4625 / optional 4624 | Secondary | Optional | Repeated failure events | — | — |
| P4-FILE-01 | — | Process and file create | Process | T1105 alert | HTTP and connection metadata | Optional IDS context / policy allow |
| P4-NET-01 | — | Optional source process | Optional | Detector JSON alert | Connection metadata | Firewall allow/block; run-specific IDS alert if matched |
| P4-EICAR-01 | Defender 1116/1117 | File/process may appear | Optional | Defender detection/remediation events | — | — |
