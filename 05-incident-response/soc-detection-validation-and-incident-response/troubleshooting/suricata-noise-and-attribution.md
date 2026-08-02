# Suricata Noise and Attribution

## Symptom

The reviewed `eve.json` excerpt contained repeated SID `2200074` messages for `SURICATA IPv4 invalid checksum`, plus limited flow evidence.

## Analyst Decision

The records were not cleanly tied to the bounded service probe by time and five-tuple. They were therefore not counted as a validated reconnaissance alert.

## Recommended Analysis

* Restrict the query to the incident start/end timestamps.
* Match `src_ip=192.168.10.10` and `dest_ip=192.168.20.10`.
* Review flow identifiers and destination ports.
* Separate stream-engine informational alerts from local reconnaissance signatures.
* Consider checksum-offload effects as an inference to test, not an assumed root cause.
* Export a run-specific EVE sample for the final report.
