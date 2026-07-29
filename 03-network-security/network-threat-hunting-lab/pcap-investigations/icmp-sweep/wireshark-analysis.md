# Wireshark Analysis — ICMP Host Discovery

## Display Filter

```wireshark
icmp && ip.src == 192.168.10.10
```

## Investigation Steps

1. Open `capture.pcap`.
2. Apply the display filter.
3. Confirm source and destination addresses.
4. Inspect protocol and TCP/ICMP fields.
5. Count packets and review the time range.
6. Inspect representative packet details.
7. Compare packet evidence with Zeek and Suricata output.

## Observed Results

- 12 packets.
- Approximately 0.045 seconds.
- 6 unique destination hosts.
- Zeek state OTH.
- Base score 25 Low.
- Tuned score 35 Medium.
- Suricata SID 1000004.

## Integrity

The expected SHA-256 is `1b152289a787aa55829b25c9495c7986b18789cb50e3102cf4cecf39da5889f6`.

## Analyst Conclusion

Destination-host diversity identified probable host discovery. The tuned profile crossed the Medium alert threshold.
