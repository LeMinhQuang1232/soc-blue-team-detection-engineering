# Firewall, IDS, and Infrastructure Monitoring Lab

## Overview

This project extends the SOC portfolio from endpoint and SIEM telemetry into network segmentation, network intrusion detection, and infrastructure observability. The lab uses pfSense to enforce role-based access between `USER_NET`, `DMZ_NET`, and `SOC_ADMIN`; Suricata to detect controlled SQL injection, XSS, and TCP SYN scan patterns; and Prometheus/Grafana to monitor the Ubuntu DMZ server.

All suspicious traffic was intentionally generated in an isolated lab. The project does not claim a real compromise or successful exploitation.

## Start Here

| Resource | Description |
|---|---|
| [Full technical report](report.md) | Architecture, implementation, results, troubleshooting, MITRE mapping, and limitations |
| [Validation summary](validation-summary.md) | Consolidated passed, partial, and unimplemented checks |
| [Firewall project](firewall/) | pfSense policy design, IP plan, validation, and troubleshooting |
| [Suricata IDS](ids/suricata/) | Installation, interface correction, alert analysis, and evidence |
| [Custom IDS rules](ids/custom-rules/) | SQLi, XSS, and SYN-scan signatures with rule analysis |
| [Monitoring stack](monitoring/) | Docker Compose, Prometheus, node_exporter, Grafana, PromQL, and metrics analysis |
| [Incident reports](incident-reports/) | Blocked admin access, web-attack detection, and controlled metrics anomaly |
| [Scripts and configuration](scripts/) | Safe test generators and reusable configuration files |
| [Evidence index](screenshots/week5-evidence-index.md) | Curated screenshot catalogue grouped by tool |
| [All screenshots](screenshots/) | pfSense, Suricata, Prometheus, Grafana, and original evidence |

## Architecture

```text
                              VirtualBox NAT / Internet
                                        |
                                  pfSense WAN
                                        |
                     +------------------+------------------+
                     |                  |                  |
              USER_NET             DMZ_NET            SOC_ADMIN
            192.168.10.0/24      192.168.20.0/24    192.168.30.0/24
                     |                  |                  |
          Windows test client     Ubuntu DMZ server   Windows admin role
           192.168.10.10          192.168.20.10       192.168.30.10
                                  Nginx / Suricata
                              Prometheus / Grafana
```

## Demonstrated Results

| Control or capability | Result | Evidence |
|---|---|---|
| USER to Nginx TCP/80 | Allowed | [Screenshot](screenshots/pfsense/13-user-to-dmz-http-port80-passed.png) |
| USER to SSH/SMB/RDP | Blocked and logged | [Screenshot](screenshots/pfsense/17-pfsense-blocked-admin-port-logs.png) |
| SOC_ADMIN to SSH/Grafana/Prometheus | Allowed | [Screenshot](screenshots/pfsense/23-socadmin-to-prometheus-passed.png) |
| USER to Grafana/Prometheus | Blocked | [Screenshot](screenshots/pfsense/25-user-to-prometheus-blocked.png) |
| Suricata SQLi/XSS/SYN signatures | Alerted | [Screenshot](screenshots/suricata/09-suricata-fast-log-alerts.png) |
| Structured IDS analysis | Validated in `eve.json` | [Screenshot](screenshots/suricata/10-suricata-eve-json-alert-analysis.png) |
| Prometheus scrape targets | UP | [Screenshot](screenshots/prometheus/07-prometheus-targets-up.png) |
| Grafana host metrics | Visualized | [Screenshot](screenshots/grafana/06-grafana-cpu-dashboard.png) |

## Key Troubleshooting Findings

- pfSense allowed HTTP, but Ubuntu UFW blocked the server response. Packet capture isolated the failure to the host-firewall layer.
- Ubuntu could reach an external IP while DNS/package retrieval failed. A temporary NAT/DHCP recovery path was used before restoring the static DMZ configuration.
- Suricata initially referenced nonexistent `eth0`; the correct predictable interface name, AF_PACKET settings, `HOME_NET`, and local rule path were then validated.
- Prometheus restart and Grafana no-data problems were resolved through configuration validation, Docker service-name networking, target checks, and time-range review.
- Host and container timestamps were normalized rather than incorrectly treated as clock drift.

## Limitations

- Suricata ran in IDS mode, not inline IPS mode.
- FortiGate concepts were mapped from pfSense policy objects; no FortiGate appliance was deployed.
- pfSense and Suricata logs were not yet forwarded into Wazuh or Splunk.
- Grafana/Prometheus query validation passed, but complete alert firing, notification delivery, and recovery evidence is partial.
- The rules are educational signatures and need production tuning.
