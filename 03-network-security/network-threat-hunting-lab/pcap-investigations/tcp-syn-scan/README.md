# Final TCP SYN Scan

## Purpose

Validate a multi-port SYN scan across every project analysis layer.

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

- 200 packets.
- Approximately 1.862 seconds.
- 100 unique destination ports.
- 200 Zeek S0 records.
- 2 administrative-service attempts.
- Base score 50 Medium.
- Tuned score 80 Critical.
- 195 Suricata SID 1000003 rev2 alerts.
- Wazuh rule 100201 level 7.

## Integrity

```text
9e11b256d17567bfb9920b4e96e73771282ce1eb6e071782757da9d735c5f7b0  capture.pcap
```

## Conclusion

This dataset completed the end-to-end validation from packet evidence through Wazuh. The base profile accurately produced a Medium probable port-scan event.
