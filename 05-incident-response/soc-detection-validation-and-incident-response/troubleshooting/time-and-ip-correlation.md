# Time and IP Correlation

## Multi-Interface Endpoint

WIN-ENDPOINT had multiple lab addresses:

* `192.168.10.10` — USER_NET and primary incident source.
* `192.168.56.20` — host-only management path.
* `10.0.2.15` — NAT address, also visible to LimaCharlie.

Correlate records using hostname, sensor identity, process command line, incident ID, and timestamp rather than IP alone.

## Time Handling

The execution log used UTC+07. Wazuh, Zeek, Suricata, and cloud EDR interfaces may display local time, UTC, or converted browser time.

The final PCAP reported `Strict time order: False`. This does not by itself invalidate the file, but analysts should sort or normalize timestamps before constructing a precise sequence and should preserve the original capture metadata.
