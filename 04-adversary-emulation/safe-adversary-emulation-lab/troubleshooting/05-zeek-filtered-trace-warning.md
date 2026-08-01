# Zeek Filtered-Trace Warning

Zeek reported that a PCAP contained only TCP control packets and may have been pre-filtered. This warning is expected for tightly filtered scan/probe captures.

Analyst handling:

- Use `conn.log` for connection-state and destination-port conclusions.
- Do not claim HTTP/DNS content when the capture does not contain it.
- Preserve the capture filter in the report.
- Use a broader PCAP when application-layer validation is required.
