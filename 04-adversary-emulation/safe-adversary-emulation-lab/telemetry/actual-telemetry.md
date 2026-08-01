# Actual Telemetry Matrix

| Test | Confirmed evidence | Missing / partial evidence | Result |
|---|---|---|---|
| P4-EXEC-01 | Sysmon/process context, LimaCharlie, Wazuh 92057 | None material | Validated |
| P4-DISC-01 | Endpoint process telemetry, centralized events | Exact dedicated custom rule not required for success | Validated |
| P4-DISC-02 | Local process, LimaCharlie, Wazuh 100140 | None material | Validated |
| P4-DISC-03 | Sysmon/Wazuh 92032 | LimaCharlie not separately proven | Validated for expected minimum |
| P4-AUTH-01 | Windows logon events, Wazuh failures, success-path evidence | No containment action in this phase | Validated |
| P4-FILE-01 | curl, hash, Sysmon 11, Wazuh 100150, Nginx, Zeek | No dedicated run-specific Suricata signature required | Validated |
| P4-NET-01 | New Zeek service records; pfSense decisions; replayed Python output; Wazuh 100201 | Isolated Suricata attribution not proven; live EVE contained historical/noisy alerts | Partial |
| P4-EICAR-01 | Defender 1116/1117, quarantine success, Wazuh 62123/62124, retest | Event-channel subscription was transiently unstable | Validated |
