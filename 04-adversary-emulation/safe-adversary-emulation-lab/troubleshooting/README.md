# Troubleshooting and Detection Gaps

| Issue | Impact | Resolution / handling | Status |
|---|---|---|---|
| Multiple Windows adapters and invalid broad IP commands | Wrong source address, tentative/invalid address, failed route creation | Scope commands to the intended interface, verify route/source IP, and validate port 80/22 behavior | Resolved |
| Wazuh connection refused on 1514/1515 | Agent offline and telemetry delay | Restore manager service availability, verify listener/firewall, then confirm established TCP 1514 session | Resolved |
| Wazuh Defender event subscription error 15007 | Possible Defender collection gap | Keep local Defender log as source evidence, restart/verify agent collection, and confirm later Wazuh Defender events | Partially resolved |
| Wazuh agent buffer full/flooded | Events may be delayed or lost | Wait for buffer below 70%, avoid overlapping startup scans and tests, and verify event arrival | Recovered |
| Intermittent manager disconnects | Short collection gaps | Confirm automatic reconnect and service health before continuing | Recovered |
| Suricata `jq` parse error | Query stopped on malformed/non-JSON line | Parse defensively with `jq -Rrc 'fromjson?'` | Resolved |
| Historical Suricata EVE noise | Old alerts could be mistaken for current test evidence | Use run-specific EVE output, timestamps, source/destination, and SID filters | Resolved methodologically |
| Suricata scan-rule alerts on Wazuh TCP 1514 | False-positive attribution risk | Exclude/suppress known management traffic and tune thresholds before production use | Open tuning item |
| Zeek filtered-trace warning | Limited application-layer logs | Document that the PCAP contains control packets and use conn.log for supported conclusions | Expected limitation |
| Atomic Red Team definitions flagged by Defender | Selected tests may become unavailable | Review selected tests; do not disable protection globally; retain only authorized benign tests | Managed |
| VirtualBox EFI NVRAM unsupported format | VM may fail before OS boot | Back up VM config/disk and repair or recreate the EFI NVRAM reference | Lab maintenance item |

See the individual files in this folder for commands and detailed analyst notes.
