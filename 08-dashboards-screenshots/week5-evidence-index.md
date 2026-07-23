# Week 5 Evidence Index

## Curated evidence

### Pfsense

| File | Original capture | Description |
|---|---|---|
| [01-windows-test-client-system.png](pfsense/01-windows-test-client-system.png) | `Screenshot 2026-07-20 152638.png` | Windows test client system information. |
| [02-user-net-ip-configuration.png](pfsense/02-user-net-ip-configuration.png) | `Screenshot 2026-07-20 152824.png` | USER_NET address 192.168.10.10 and gateway 192.168.10.1. |
| [03-ubuntu-dmz-ip-route.png](pfsense/03-ubuntu-dmz-ip-route.png) | `Screenshot 2026-07-20 154153.png` | Ubuntu DMZ address and routing table. |
| [04-pfsense-interface-assignments.png](pfsense/04-pfsense-interface-assignments.png) | `Screenshot 2026-07-20 154330.png` | WAN, USER, DMZ, and SOC_ADMIN interface assignment. |
| [05-pfsense-wan-user-status.png](pfsense/05-pfsense-wan-user-status.png) | `Screenshot 2026-07-20 154728.png` | pfSense WAN and USER interface status. |
| [06-pfsense-dmz-socadmin-status.png](pfsense/06-pfsense-dmz-socadmin-status.png) | `Screenshot 2026-07-20 154740.png` | pfSense DMZ and SOC_ADMIN interface status. |
| [07-dmz-web-server-alias.png](pfsense/07-dmz-web-server-alias.png) | `Screenshot 2026-07-20 155348.png` | DMZ_WEB_SERVER alias mapped to 192.168.20.10. |
| [08-service-port-aliases.png](pfsense/08-service-port-aliases.png) | `Screenshot 2026-07-20 155400.png` | WEB_PORTS and ADMIN_PORTS aliases. |
| [09-user-firewall-rules-initial.png](pfsense/09-user-firewall-rules-initial.png) | `Screenshot 2026-07-20 163155.png` | Initial USER interface firewall rules. |
| [10-dmz-firewall-rules-initial.png](pfsense/10-dmz-firewall-rules-initial.png) | `Screenshot 2026-07-20 163209.png` | Initial DMZ interface firewall rules. |
| [11-socadmin-firewall-rules-initial.png](pfsense/11-socadmin-firewall-rules-initial.png) | `Screenshot 2026-07-20 163450.png` | Initial SOC_ADMIN firewall rules. |
| [12-user-http-curl-success.png](pfsense/12-user-http-curl-success.png) | `Screenshot 2026-07-20 212934.png` | Nginx page returned to USER client. |
| [13-user-to-dmz-http-port80-passed.png](pfsense/13-user-to-dmz-http-port80-passed.png) | `Screenshot 2026-07-20 212946.png` | TCP/80 test succeeded from USER_NET. |
| [14-user-to-dmz-ssh-blocked.png](pfsense/14-user-to-dmz-ssh-blocked.png) | `Screenshot 2026-07-20 213138.png` | TCP/22 and SSH tests failed from USER_NET. |
| [15-user-to-dmz-smb-blocked.png](pfsense/15-user-to-dmz-smb-blocked.png) | `Screenshot 2026-07-20 213248.png` | TCP/445 test failed from USER_NET. |
| [16-user-to-dmz-rdp-blocked.png](pfsense/16-user-to-dmz-rdp-blocked.png) | `Screenshot 2026-07-20 213318.png` | TCP/3389 test failed from USER_NET. |
| [17-pfsense-blocked-admin-port-logs.png](pfsense/17-pfsense-blocked-admin-port-logs.png) | `Screenshot 2026-07-20 213546.png` | Firewall logs for denied USER-to-DMZ administrative traffic. |
| [18-socadmin-to-dmz-ssh-passed.png](pfsense/18-socadmin-to-dmz-ssh-passed.png) | `Screenshot 2026-07-20 220707.png` | SOC_ADMIN access to pfSense management and DMZ SSH succeeded. |
| [19-socadmin-firewall-rules-final.png](pfsense/19-socadmin-firewall-rules-final.png) | `Screenshot 2026-07-23 171420.png` | Final SOC_ADMIN rules including SSH and monitoring access. |
| [20-dmz-firewall-rules-final.png](pfsense/20-dmz-firewall-rules-final.png) | `Screenshot 2026-07-23 171429.png` | Final DMZ rules. |
| [21-user-firewall-rules-final.png](pfsense/21-user-firewall-rules-final.png) | `Screenshot 2026-07-23 171439.png` | Final USER rules before final access validation. |
| [22-socadmin-to-grafana-passed.png](pfsense/22-socadmin-to-grafana-passed.png) | `Screenshot 2026-07-23 172802.png` | SOC_ADMIN to Grafana TCP/3000 succeeded. |
| [23-socadmin-to-prometheus-passed.png](pfsense/23-socadmin-to-prometheus-passed.png) | `Screenshot 2026-07-23 173017.png` | SOC_ADMIN to Prometheus TCP/9090 succeeded. |
| [24-user-to-grafana-blocked.png](pfsense/24-user-to-grafana-blocked.png) | `Screenshot 2026-07-23 201156.png` | USER_NET to Grafana TCP/3000 failed. |
| [25-user-to-prometheus-blocked.png](pfsense/25-user-to-prometheus-blocked.png) | `Screenshot 2026-07-23 201203.png` | USER_NET to Prometheus TCP/9090 failed. |
| [26-user-firewall-rules-final.png](pfsense/26-user-firewall-rules-final.png) | `Screenshot 2026-07-23 202338.png` | Final USER rules after monitoring restrictions. |
| [27-pfsense-monitoring-access-logs.png](pfsense/27-pfsense-monitoring-access-logs.png) | `Screenshot 2026-07-23 202322.png` | Firewall log evidence around monitoring access tests. |
| [28-pfsense-final-firewall-logs.png](pfsense/28-pfsense-final-firewall-logs.png) | `Screenshot 2026-07-23 202359.png` | Final pfSense firewall log view. |

### Suricata

| File | Original capture | Description |
|---|---|---|
| [01-suricata-version-and-features.png](suricata/01-suricata-version-and-features.png) | `Screenshot 2026-07-21 205448.png` | Suricata build and feature information. |
| [02-suricata-initial-interface-error.png](suricata/02-suricata-initial-interface-error.png) | `Screenshot 2026-07-21 205500.png` | Initial eth0 capture-interface error during service startup. |
| [03-ubuntu-interface-verification.png](suricata/03-ubuntu-interface-verification.png) | `Screenshot 2026-07-21 205919.png` | Actual Ubuntu interface name and routes. |
| [04-suricata-home-net-configuration.png](suricata/04-suricata-home-net-configuration.png) | `Screenshot 2026-07-21 210407.png` | HOME_NET configuration review. |
| [05-suricata-af-packet-configuration.png](suricata/05-suricata-af-packet-configuration.png) | `Screenshot 2026-07-21 210632.png` | AF_PACKET capture configuration review. |
| [06-suricata-config-validation.png](suricata/06-suricata-config-validation.png) | `Screenshot 2026-07-21 210754.png` | Suricata configuration test completed successfully. |
| [07-suricata-service-active.png](suricata/07-suricata-service-active.png) | `Screenshot 2026-07-21 210851.png` | Suricata service active after correction. |
| [08-safe-web-attack-test-requests.png](suricata/08-safe-web-attack-test-requests.png) | `Screenshot 2026-07-21 215658.png` | Safe SQLi/XSS HTTP requests sent from Windows. |
| [09-suricata-fast-log-alerts.png](suricata/09-suricata-fast-log-alerts.png) | `Screenshot 2026-07-21 224102.png` | LOCAL SQLi, XSS, and TCP SYN scan alerts in fast.log. |
| [10-suricata-eve-json-alert-analysis.png](suricata/10-suricata-eve-json-alert-analysis.png) | `Screenshot 2026-07-21 231916.png` | jq-filtered EVE JSON alerts with source, destination, signature, and severity. |
| [11-local-rules-editor.png](suricata/11-local-rules-editor.png) | `Screenshot 2026-07-23 095539.png` | Local rules in editor. |
| [12-local-rules-final.png](suricata/12-local-rules-final.png) | `Screenshot 2026-07-23 101018.png` | Final three custom Suricata rules and SIDs. |
| [13-nginx-access-log-test-traffic.png](suricata/13-nginx-access-log-test-traffic.png) | `Screenshot 2026-07-22 231950.png` | Nginx access log for generated requests. |

### Prometheus

| File | Original capture | Description |
|---|---|---|
| [01-docker-compose-services-up.png](prometheus/01-docker-compose-services-up.png) | `Screenshot 2026-07-22 102342.png` | Prometheus, node_exporter, and Grafana containers running. |
| [02-prometheus-config-validation.png](prometheus/02-prometheus-config-validation.png) | `Screenshot 2026-07-22 104450.png` | promtool validation of prometheus.yml. |
| [03-prometheus-alert-rules-validation.png](prometheus/03-prometheus-alert-rules-validation.png) | `Screenshot 2026-07-22 104501.png` | promtool validation of alert rules. |
| [04-node-exporter-metrics-endpoint.png](prometheus/04-node-exporter-metrics-endpoint.png) | `Screenshot 2026-07-22 104856.png` | node_exporter metrics endpoint response. |
| [05-prometheus-health-grafana-login.png](prometheus/05-prometheus-health-grafana-login.png) | `Screenshot 2026-07-22 105247.png` | Prometheus health and Grafana login endpoint checks. |
| [06-node-metric-query-cli.png](prometheus/06-node-metric-query-cli.png) | `Screenshot 2026-07-22 105401.png` | CLI validation of node metrics. |
| [07-prometheus-targets-up.png](prometheus/07-prometheus-targets-up.png) | `Screenshot 2026-07-22 161905.png` | Prometheus and ubuntu-node targets in UP state. |
| [08-prometheus-alert-rules-page.png](prometheus/08-prometheus-alert-rules-page.png) | `Screenshot 2026-07-22 232049.png` | Prometheus alerting rules page. |
| [09-prometheus-targets-final-up.png](prometheus/09-prometheus-targets-final-up.png) | `Screenshot 2026-07-22 234500.png` | Final targets view with both targets UP. |
| [10-host-container-time-alignment.png](prometheus/10-host-container-time-alignment.png) | `Screenshot 2026-07-22 234511.png` | Local-time and UTC comparison for timestamp correlation. |
| [11-cpu-query-api-result.png](prometheus/11-cpu-query-api-result.png) | `Screenshot 2026-07-23 113001.png` | Prometheus API result for CPU metric. |
| [12-cpu-promql-result.png](prometheus/12-cpu-promql-result.png) | `Screenshot 2026-07-23 152230.png` | CPU PromQL query in Prometheus UI. |
| [13-memory-promql-result.png](prometheus/13-memory-promql-result.png) | `Screenshot 2026-07-23 153808.png` | Memory usage query result. |
| [14-disk-promql-result.png](prometheus/14-disk-promql-result.png) | `Screenshot 2026-07-23 154511.png` | Disk usage query result. |
| [15-network-rx-promql-result.png](prometheus/15-network-rx-promql-result.png) | `Screenshot 2026-07-23 154632.png` | Network receive-rate query result. |
| [16-network-tx-promql-result.png](prometheus/16-network-tx-promql-result.png) | `Screenshot 2026-07-23 154836.png` | Network transmit-rate query result. |
| [17-alert-rules-returned-to-normal.png](prometheus/17-alert-rules-returned-to-normal.png) | `Screenshot 2026-07-23 161856.png` | Alert rules in normal state after stress ended. |

### Grafana

| File | Original capture | Description |
|---|---|---|
| [01-grafana-prometheus-datasource.png](grafana/01-grafana-prometheus-datasource.png) | `Screenshot 2026-07-22 162435.png` | Grafana Prometheus data source URL. |
| [02-grafana-datasource-query-success.png](grafana/02-grafana-datasource-query-success.png) | `Screenshot 2026-07-22 162515.png` | Successful Grafana query to Prometheus. |
| [03-stress-ng-cpu-test-command.png](grafana/03-stress-ng-cpu-test-command.png) | `Screenshot 2026-07-22 230718.png` | Controlled CPU load generation. |
| [04-top-cpu-load-evidence.png](grafana/04-top-cpu-load-evidence.png) | `Screenshot 2026-07-22 230742.png` | High CPU utilization during stress test. |
| [05-stress-ng-all-cpu-test.png](grafana/05-stress-ng-all-cpu-test.png) | `Screenshot 2026-07-23 161500.png` | Second controlled CPU stress test. |
| [06-grafana-cpu-dashboard.png](grafana/06-grafana-cpu-dashboard.png) | `Screenshot 2026-07-23 161510.png` | Node Exporter Full CPU panels and test spike. |
| [07-grafana-memory-dashboard.png](grafana/07-grafana-memory-dashboard.png) | `Screenshot 2026-07-23 161539.png` | Memory panels. |
| [08-grafana-network-dashboard.png](grafana/08-grafana-network-dashboard.png) | `Screenshot 2026-07-23 161557.png` | Network traffic panels. |
| [09-grafana-disk-io-dashboard.png](grafana/09-grafana-disk-io-dashboard.png) | `Screenshot 2026-07-23 161608.png` | Disk I/O panels. |
| [10-grafana-filesystem-dashboard.png](grafana/10-grafana-filesystem-dashboard.png) | `Screenshot 2026-07-23 161615.png` | Filesystem panels. |
| [11-grafana-disk-utilization-dashboard.png](grafana/11-grafana-disk-utilization-dashboard.png) | `Screenshot 2026-07-23 161623.png` | Disk utilization panels. |
| [12-grafana-pressure-dashboard.png](grafana/12-grafana-pressure-dashboard.png) | `Screenshot 2026-07-23 161632.png` | Pressure stall information panels. |

## Complete raw set

All 71 original screenshots are preserved under [`week5-raw-evidence/`](week5-raw-evidence/). The curated directories contain descriptive copies used by reports.
