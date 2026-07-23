


<!-- WEEK5-CV-BULLETS-START -->
## Firewall, IDS, and Monitoring Lab

- Built a three-zone security lab using pfSense, Suricata, Prometheus, Grafana, Nginx, and VirtualBox to model USER, DMZ, and SOC administration boundaries.
- Implemented least-privilege firewall policy that allowed HTTP/HTTPS to the DMZ web server while blocking SSH, SMB, RDP, Grafana, and Prometheus access from the user zone.
- Validated role-based administrative access by permitting SOC_ADMIN traffic to DMZ SSH and monitoring services while retaining logged deny rules for unauthorized sources.
- Developed and tested Suricata signatures for SQL injection, XSS, and TCP SYN scan behavior; investigated alerts in `fast.log` and structured EVE JSON output.
- Deployed Prometheus, node_exporter, and Grafana with Docker Compose; validated scrape targets and analyzed CPU, memory, disk, and network metrics during controlled stress tests.
- Produced SOC-style validation records, evidence indexes, troubleshooting analysis, MITRE ATT&CK mappings, and incident reports for blocked remote-service access and suspicious web traffic.
<!-- WEEK5-CV-BULLETS-END -->

