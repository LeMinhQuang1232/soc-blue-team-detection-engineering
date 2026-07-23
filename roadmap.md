


<!-- WEEK5-ROADMAP-START -->
## Week 5 — Firewall, IDS/IPS, and Metrics Monitoring — Completed

- [x] Build pfSense with WAN, USER_NET, DMZ_NET, and SOC_ADMIN interfaces.
- [x] Apply allow/deny policies and verify logged administrative-port blocks.
- [x] Map pfSense objects and rules to FortiGate-style policy concepts.
- [x] Deploy Suricata in IDS mode on the Ubuntu DMZ server.
- [x] Validate local SQLi, XSS, and TCP SYN scan signatures.
- [x] Deploy Prometheus, node_exporter, and Grafana.
- [x] Validate targets, PromQL queries, dashboards, and controlled CPU load.
- [x] Restrict monitoring ports to SOC_ADMIN.
- [x] Write evidence-based incident and troubleshooting reports.

### Next improvements

- Forward pfSense and Suricata logs into Wazuh or Splunk.
- Add a dedicated SOC_ADMIN VM instead of switching the test client between roles.
- Add Grafana notification channels and capture a complete alert firing/recovery sequence.
- Add blackbox_exporter for HTTP availability monitoring.
- Evaluate Suricata inline IPS only in an isolated lab with a safe rollback plan.
<!-- WEEK5-ROADMAP-END -->

