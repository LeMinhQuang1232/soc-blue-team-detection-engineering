# Suricata EVE Parsing and Attribution

## Parse Error

A direct `jq -c` query stopped with `Invalid numeric literal`. Defensive parsing prevented a single malformed line from terminating the investigation:

```bash
sudo jq -Rrc 'fromjson? | select(.event_type == "alert")' /var/log/suricata/eve.json
```

## Historical Noise

The live `eve.json` contained events from earlier dates, generic stream alerts, and local scan signatures. Those records were not automatically attributed to the current test.

## Run-Specific Result

The isolated P4-NET-01 EVE output returned no matching alert for the low-volume controlled service probe. Meanwhile, the live log showed local SYN-scan alerts involving Wazuh management port 1514. This is a false-positive/tuning warning because normal agent traffic must not be presented as proof of the current scan.

Recommended tuning:

- Create a run-specific output directory before each offline analysis.
- Filter by test time, source, destination, and SID.
- Exclude or suppress known Wazuh management traffic where appropriate.
- Apply thresholding that represents multi-port behavior instead of repeated packets in one established service flow.
