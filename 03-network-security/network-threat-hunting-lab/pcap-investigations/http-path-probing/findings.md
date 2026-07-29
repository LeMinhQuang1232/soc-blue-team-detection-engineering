# Findings — HTTP Path Probing

## Evidence Summary

- 86 packets.
- Approximately 3.71 seconds.
- 9 unique URIs.
- Base score 20 Low.
- Tuned score 35 Medium.
- Suricata SID 1000006.

## Interpretation

URI diversity within a short window identified probable HTTP enumeration. The tuned profile made the behavior actionable.

## Confidence

**High for the controlled lab behavior.** The conclusion is supported by the retained packet capture and one or more independent metadata/detection layers.

## Limitations

- Results describe this small controlled dataset, not all enterprise traffic.
- Counts depend on the capture filter and sensor vantage point.
- A matching pattern in production would require asset role, authorization, and historical context before escalation.
