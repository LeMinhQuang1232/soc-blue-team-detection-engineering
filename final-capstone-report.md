


<!-- WEEK5-CAPSTONE-START -->
## Network Security and Observability Extension

The Week 5 extension added network segmentation, IDS telemetry, and infrastructure metrics to the endpoint- and SIEM-focused lab. pfSense enforced trust boundaries between USER, DMZ, and SOC_ADMIN zones. Suricata inspected DMZ traffic and generated structured alerts for safe SQL injection, XSS, and TCP SYN scan simulations. Prometheus and node_exporter collected host metrics, while Grafana visualized controlled CPU load and normal operating baselines.

This extension demonstrates defense in depth: the firewall decides whether a connection is permitted, the IDS provides visibility into suspicious allowed traffic, and metrics monitoring supplies operational context. The evidence also documents an important analytical boundary: the firewall, IDS, and monitoring screenshots were produced in controlled test windows and are correlated as a lab scenario rather than claimed as one production incident with perfect second-level timestamp continuity.

See [the Week 5 report](weekly-reports/week5-firewall-ids-monitoring-report.md).
<!-- WEEK5-CAPSTONE-END -->

