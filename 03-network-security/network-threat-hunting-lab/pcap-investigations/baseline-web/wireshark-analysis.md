# Wireshark Analysis — Baseline Web Traffic

## Display Filter

```wireshark
ip.addr == 192.168.10.10 && ip.addr == 192.168.20.10 && tcp.port == 80
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

- 37 packets.
- Approximately 81.22 seconds.
- 4 successful Zeek connections.
- 1 destination host.
- 1 destination port.
- 3 unique HTTP URIs across windows.
- Base and tuned detector score 0.

## Integrity

The expected SHA-256 is `248ec8c4037014aa111a6921863bab582319bf425c6fb979e3d475619250221a`.

## Analyst Conclusion

Normal web activity remained below the alert threshold and did not produce a detector alert. This dataset is the negative control for the project.
