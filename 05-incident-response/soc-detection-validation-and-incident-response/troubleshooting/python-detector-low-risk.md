# Python Detector Low-Risk Result

## Symptom

The detector returned a risk score of zero and `baseline_or_low_activity`, with one observed destination host and insufficient unique destination ports.

## Why the Result Was Not Treated as a False Statement

The detector scored the logs it received. The execution record independently proves that twelve ports were tested, so the mismatch indicates incomplete capture/log input or analysis-window selection.

## Corrective Workflow

1. Verify the final PCAP hash.
2. Generate Zeek logs in a clean directory from that exact PCAP.
3. Count unique destination ports before running the detector.
4. Confirm the time window includes the full probe.
5. Run the detector using the matching `conn.log` and `http.log`.
6. Compare the output with the execution record and packet-level evidence.

Until final derived output is available, the network behavioral result remains Partial.
