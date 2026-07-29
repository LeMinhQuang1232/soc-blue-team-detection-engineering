# Port-Scanning Detection

## Logic

A source contacting at least 10 unique ports receives the medium-port signal; 25 or more receives the high-port signal. The high threshold also permits classification as `probable_port_scan` when higher-priority host or HTTP conditions are absent.

## Final Validation

- Source: `192.168.10.10`.
- Target: `192.168.20.10`.
- Unique ports: 100.
- Failed connections: 200.
- Base score: 50 Medium.
- Tuned score: 80 Critical.

## Recommended Production Context

Allowlist authorized scanners, distinguish scheduled maintenance, and correlate with source role, failure ratio, firewall denies, and Suricata alerts.
