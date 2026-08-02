# Troubleshooting Index

| Issue | Confirmed symptom | Resolution / disposition |
|---|---|---|
| Wazuh agent buffer pressure | Buffer reached 90 percent and reported event discarding | Wait for recovery, verify connectivity, reduce uncontrolled startup volume, and begin timed tests only after buffer health stabilizes |
| Missing initial PCAP | `capinfos` and `sha256sum` returned file-not-found | Recreated a dedicated capture directory and performed a final recapture |
| Empty recapture attempt | Zero packets captured; 24-byte PCAP | Corrected capture workflow, target service validation, interface/filter use, and traffic generation |
| PCAP timestamp ordering | `Strict time order: False` | Preserve metadata, normalize timestamps, and analyze with tools tolerant of out-of-order records |
| Broken pipe while previewing PCAP | `tcpdump ... | head` reported unable to write output | Treat as downstream pipe closure, not capture corruption; use a bounded reader or ignore expected SIGPIPE behavior |
| Suricata attribution noise | Invalid-checksum alerts dominated EVE excerpt | Filter by incident window and flow; do not claim unrelated alerts as detection evidence |
| Python detector low-risk result | Score 0 / baseline classification despite executed probe | Recognize incomplete input; regenerate from exact final hashed PCAP and verify unique ports |
| Multi-interface endpoint | 10.0.2.15, 192.168.56.20, and 192.168.10.10 appeared across tools | Maintain an asset/IP map and correlate by hostname, sensor ID, time, and command line |
| LimaCharlie isolation behavior | Normal connectivity stopped | Expected containment behavior; confirm sensor management channel, then rejoin and retest connectivity |

Only issues supported by the supplied screenshots, execution notes, or prior Phase 3 command output are documented. No unsupported Wazuh-plugin or VM-crash root cause is asserted in this report.
