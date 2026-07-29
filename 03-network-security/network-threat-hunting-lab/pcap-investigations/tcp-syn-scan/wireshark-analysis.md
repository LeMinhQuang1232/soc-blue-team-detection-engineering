# Wireshark Analysis — Final TCP SYN Scan

## Display Filter

```wireshark
ip.src == 192.168.10.10 && ip.dst == 192.168.20.10 && tcp.flags.syn == 1 && tcp.flags.ack == 0
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

The expected SHA-256 is `9e11b256d17567bfb9920b4e96e73771282ce1eb6e071782757da9d735c5f7b0`.

## Analyst Conclusion

This dataset completed the end-to-end validation from packet evidence through Wazuh. The base profile accurately produced a Medium probable port-scan event.
