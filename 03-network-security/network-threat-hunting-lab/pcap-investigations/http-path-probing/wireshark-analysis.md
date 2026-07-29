# Wireshark Analysis — HTTP Path Probing

## Display Filter

```wireshark
http.request && ip.src == 192.168.10.10
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

- 86 packets.
- Approximately 3.71 seconds.
- 9 unique URIs.
- Base score 20 Low.
- Tuned score 35 Medium.
- Suricata SID 1000006.

## Integrity

The expected SHA-256 is `d4cac138345eec893752902551d67e528ca28133d9c8d4a2049479f1bc1079e0`.

## Analyst Conclusion

URI diversity within a short window identified probable HTTP enumeration. The tuned profile made the behavior actionable.
