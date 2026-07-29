# Findings — ICMP Host Discovery

## Evidence Summary

- 12 packets.
- Approximately 0.045 seconds.
- 6 unique destination hosts.
- Zeek state OTH.
- Base score 25 Low.
- Tuned score 35 Medium.
- Suricata SID 1000004.

## Interpretation

Destination-host diversity identified probable host discovery. The tuned profile crossed the Medium alert threshold.

## Confidence

**High for the controlled lab behavior.** The conclusion is supported by the retained packet capture and one or more independent metadata/detection layers.

## Limitations

- Results describe this small controlled dataset, not all enterprise traffic.
- Counts depend on the capture filter and sensor vantage point.
- A matching pattern in production would require asset role, authorization, and historical context before escalation.
