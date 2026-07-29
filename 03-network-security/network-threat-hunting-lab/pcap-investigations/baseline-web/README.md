# Baseline Web Traffic

## Purpose

Establish a negative control using ordinary HTTP requests to the DMZ web server.

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

- 37 packets.
- Approximately 81.22 seconds.
- 4 successful Zeek connections.
- 1 destination host.
- 1 destination port.
- 3 unique HTTP URIs across windows.
- Base and tuned detector score 0.

## Integrity

```text
248ec8c4037014aa111a6921863bab582319bf425c6fb979e3d475619250221a  capture.pcap
```

## Conclusion

Normal web activity remained below the alert threshold and did not produce a detector alert. This dataset is the negative control for the project.
