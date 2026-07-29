# HTTP Path Probing

## Purpose

Model rapid discovery requests to common administrative and application paths.

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

- 86 packets.
- Approximately 3.71 seconds.
- 9 unique URIs.
- Base score 20 Low.
- Tuned score 35 Medium.
- Suricata SID 1000006.

## Integrity

```text
d4cac138345eec893752902551d67e528ca28133d9c8d4a2049479f1bc1079e0  capture.pcap
```

## Conclusion

URI diversity within a short window identified probable HTTP enumeration. The tuned profile made the behavior actionable.
