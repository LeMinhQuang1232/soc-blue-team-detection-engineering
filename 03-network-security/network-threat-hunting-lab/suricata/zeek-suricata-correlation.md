# Zeek and Suricata Correlation

## Correlation Principle

Use timestamp, source IP, destination IP, protocol, and destination port to align Suricata alerts with Zeek metadata and packet evidence.

## Final TCP SYN Example

| Layer | Observation |
|---|---|
| PCAP/Wireshark | SYN packets from `192.168.10.10` to `192.168.20.10`, ports 1–100 |
| Zeek | 200 `conn.log` records, 100 unique ports, all `S0` |
| Suricata | 195 alerts, SID `1000003`, rev `2` |
| Python | 100 ports, 200 failures, score 50 Medium |
| Wazuh | Rule `100201`, level 7 |

## Why Counts Differ

Zeek and Suricata serve different purposes. Zeek records observed connections; Suricata emits alerts only after rule conditions and `detection_filter` requirements are satisfied. Therefore, 200 Zeek records and 195 Suricata alerts are consistent with a threshold of five events before alerts begin.

## No-Signature Case

Administrative-service probing produced useful Zeek/Python evidence without a dedicated Suricata alert. This is an expected and valuable result: absence of a signature alert is not absence of observable behavior.
