# Findings — Administrative-Service Probing

## Evidence Summary

- 18 packets.
- Approximately 3.02 seconds.
- 6 destination ports.
- 12 failed connections.
- 10 S0 and 2 RSTO states.
- 6 administrative-service attempts.
- Base score 35 Medium.
- Tuned score 55 Medium.

## Interpretation

Zeek and the Python detector exposed behavior that did not require a dedicated Suricata signature. Administrative targeting and failures supplied useful context.

## Confidence

**High for the controlled lab behavior.** The conclusion is supported by the retained packet capture and one or more independent metadata/detection layers.

## Limitations

- Results describe this small controlled dataset, not all enterprise traffic.
- Counts depend on the capture filter and sensor vantage point.
- A matching pattern in production would require asset role, authorization, and historical context before escalation.
