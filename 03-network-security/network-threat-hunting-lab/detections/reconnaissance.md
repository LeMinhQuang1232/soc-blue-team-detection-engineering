# Reconnaissance Detection Overview

Reconnaissance is detected as aggregated source behavior rather than one universally malicious packet. The project combines five signals: destination-port diversity, destination-host diversity, failed connections, administrative-service targeting, and HTTP URI diversity.

The detector emits one primary classification plus a list of all scoring signals. This prevents loss of context when one window resembles more than one reconnaissance type.

## ATT&CK Alignment

The main behavioral mapping is **T1046 — Network Service Scanning**. HTTP path discovery and system-specific probes may overlap with other discovery techniques, but the project avoids over-mapping every packet to an ATT&CK technique.
