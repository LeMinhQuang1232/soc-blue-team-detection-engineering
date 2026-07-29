# Findings — Final TCP SYN Scan

## Evidence Summary

- 200 packets.
- Approximately 1.862 seconds.
- 100 unique destination ports.
- 200 Zeek S0 records.
- 2 administrative-service attempts.
- Base score 50 Medium.
- Tuned score 80 Critical.
- 195 Suricata SID 1000003 rev2 alerts.
- Wazuh rule 100201 level 7.

## Interpretation

This dataset completed the end-to-end validation from packet evidence through Wazuh. The base profile accurately produced a Medium probable port-scan event.

## Confidence

**High for the controlled lab behavior.** The conclusion is supported by the retained packet capture and one or more independent metadata/detection layers.

## Limitations

- Results describe this small controlled dataset, not all enterprise traffic.
- Counts depend on the capture filter and sensor vantage point.
- A matching pattern in production would require asset role, authorization, and historical context before escalation.
