# Gaps, Tuning, and Retest

## Gap 1 — Incomplete Network Behavioral Input

### Before

The controlled service probe tested twelve predefined ports, but the initial Zeek output exposed only a small subset of the traffic. The Python detector therefore calculated a risk score of zero and classified the source as `baseline_or_low_activity`.

### Interpretation

The detector behaved consistently with its input. The problem was not that the test failed to run; the problem was that the observed logs did not preserve enough port diversity to cross the configured threshold.

### Improvement

* Start packet capture before launching the service probe.
* Capture on the interface that sees traffic between `192.168.10.10` and `192.168.20.10`.
* Use an explicit bidirectional host filter.
* Record `capinfos` and SHA-256 immediately after capture.
* Generate Zeek logs from the exact hashed PCAP.
* Isolate each run in a new output directory to prevent old logs from being mixed with retest data.

### Retest Outcome

A final recapture produced 5,246 packets over 111.382056 seconds and was integrity-checked. The supplied evidence proves the recapture file and hash, but the raw PCAP and regenerated final Zeek/Python output were not included in the uploaded ZIP. Network behavioral coverage therefore remains **Partial** rather than being promoted to Passed.

## Gap 2 — Wazuh Agent Buffer Pressure

The agent buffer reached 90 percent and reported event discarding. Tuning actions should include controlling high-volume startup telemetry, confirming manager connectivity before testing, and waiting for the buffer to fall before beginning a timed incident run.

## Gap 3 — Suricata Attribution Noise

Invalid-checksum alerts dominated the reviewed EVE excerpt. Future validation should isolate the incident time window and five-tuple, verify checksum-offload effects when applicable, and use a run-specific EVE output or filtered export. Unrelated EVE events must not be presented as proof of reconnaissance detection.

## Successful Retest Areas

* Encoded PowerShell again triggered Wazuh rule 92057.
* Controlled HTTP transfer and SQLi-like activity again generated Wazuh evidence.
* LimaCharlie again exposed encoded PowerShell process context.
* A second isolation task returned success.

## Before/After Summary

| Area | Before | After | Final status |
|---|---|---|---|
| Encoded PowerShell | Detected | Detected again | Passed |
| Discovery commands | Detected | Controlled sequence repeated | Passed |
| HTTP transfer and SQLi-like URI | Detected | Detected again | Passed |
| EDR isolation | Effective | Second isolation command successful | Passed |
| Service-probe behavior | Executed but incompletely represented in Zeek/Python | Final PCAP recaptured and hashed; final derived logs not supplied | Partial |
