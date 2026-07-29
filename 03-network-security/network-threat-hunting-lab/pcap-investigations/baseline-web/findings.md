# Findings — Baseline Web Traffic

## Evidence Summary

- 37 packets.
- Approximately 81.22 seconds.
- 4 successful Zeek connections.
- 1 destination host.
- 1 destination port.
- 3 unique HTTP URIs across windows.
- Base and tuned detector score 0.

## Interpretation

Normal web activity remained below the alert threshold and did not produce a detector alert. This dataset is the negative control for the project.

## Confidence

**High for the controlled lab behavior.** The conclusion is supported by the retained packet capture and one or more independent metadata/detection layers.

## Limitations

- Results describe this small controlled dataset, not all enterprise traffic.
- Counts depend on the capture filter and sensor vantage point.
- A matching pattern in production would require asset role, authorization, and historical context before escalation.
