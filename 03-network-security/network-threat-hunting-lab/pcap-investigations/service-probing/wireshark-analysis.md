# Wireshark Analysis — Administrative-Service Probing

## Display Filter

```wireshark
ip.src == 192.168.10.10 && ip.dst == 192.168.20.10 && tcp.flags.syn == 1
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

- 18 packets.
- Approximately 3.02 seconds.
- 6 destination ports.
- 12 failed connections.
- 10 S0 and 2 RSTO states.
- 6 administrative-service attempts.
- Base score 35 Medium.
- Tuned score 55 Medium.

## Integrity

The expected SHA-256 is `601f855766426efc3ab4789a1ad2b85f6ae4b5a750ccf9aae09bd879421f1c02`.

## Analyst Conclusion

Zeek and the Python detector exposed behavior that did not require a dedicated Suricata signature. Administrative targeting and failures supplied useful context.
