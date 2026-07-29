# ICMP Host Discovery

## Purpose

Model host discovery by sending ICMP echo requests to multiple DMZ addresses.

## Dataset

| Artifact | Location |
|---|---|
| Packet capture | `capture.pcap` |
| Integrity record | `capture.sha256` |
| Zeek logs | `zeek-logs/` |
| Suricata output | `suricata-output/` when applicable |
| Traffic notes | `traffic-generation-notes.txt` |
| Wireshark analysis | `wireshark-analysis.md` |
| Findings | `findings.md` |

## Key Results

- 12 packets.
- Approximately 0.045 seconds.
- 6 unique destination hosts.
- Zeek state OTH.
- Base score 25 Low.
- Tuned score 35 Medium.
- Suricata SID 1000004.

## Integrity

```text
1b152289a787aa55829b25c9495c7986b18789cb50e3102cf4cecf39da5889f6  capture.pcap
```

## Conclusion

Destination-host diversity identified probable host discovery. The tuned profile crossed the Medium alert threshold.
