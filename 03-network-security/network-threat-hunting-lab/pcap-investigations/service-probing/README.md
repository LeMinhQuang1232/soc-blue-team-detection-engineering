# Administrative-Service Probing

## Purpose

Test repeated connections to common services, including configured administrative ports.

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

- 18 packets.
- Approximately 3.02 seconds.
- 6 destination ports.
- 12 failed connections.
- 10 S0 and 2 RSTO states.
- 6 administrative-service attempts.
- Base score 35 Medium.
- Tuned score 55 Medium.

## Integrity

```text
601f855766426efc3ab4789a1ad2b85f6ae4b5a750ccf9aae09bd879421f1c02  capture.pcap
```

## Conclusion

Zeek and the Python detector exposed behavior that did not require a dedicated Suricata signature. Administrative targeting and failures supplied useful context.
