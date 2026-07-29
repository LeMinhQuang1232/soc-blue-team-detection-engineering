# Detection Comparison

| Scenario | PCAP/Wireshark | Zeek | Suricata | Python | Wazuh |
|---|---|---|---|---|---|
| Baseline web | Normal HTTP packets | Successful connections and URIs | No required alert | 0 Low | No alert |
| ICMP sweep | Echo requests to six hosts | Multi-host metadata | SID 1000004 | 25 Low / 35 Medium | Integratable tuned event |
| Service probing | SYN/probe packets | Ports, failures, admin attempts | No dedicated signature | 35 / 55 Medium | Integratable event |
| HTTP path probing | Nine controlled GET paths | URI/status metadata | SID 1000006 | 20 Low / 35 Medium | Integratable tuned event |
| TCP SYN scan | 200 SYN packets, ports 1–100 | 200 S0 records, 100 ports | 195 SID 1000003 alerts | 50 Medium / 80 Critical | Rule 100201 level 7 |

## Key Finding

No single layer is sufficient for every scenario. PCAP establishes ground truth, Zeek supports broad hunting, Suricata confirms signatures, Python aggregates behavior, and Wazuh operationalizes the alert.
