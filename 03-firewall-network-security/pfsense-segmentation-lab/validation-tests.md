# Firewall Validation Tests

| ID | Test | Expected | Evidence | Status |
|---|---|---|---|---|
| W5-FW-01 | pfSense has WAN, USER, DMZ, SOC_ADMIN interfaces | Four assigned interfaces | `04-pfsense-interface-assignments.png` | Passed |
| W5-FW-02 | USER reaches DMZ Nginx TCP/80 | Connection succeeds | `12`, `13` | Passed |
| W5-FW-03 | USER reaches DMZ SSH TCP/22 | Connection denied | `14` and deny logs | Passed |
| W5-FW-04 | USER reaches DMZ SMB TCP/445 | Connection denied | `15` | Passed |
| W5-FW-05 | USER reaches DMZ RDP TCP/3389 | Connection denied | `16` | Passed |
| W5-FW-06 | SOC_ADMIN reaches DMZ SSH | Connection succeeds | `18` | Passed |
| W5-FW-07 | SOC_ADMIN reaches Grafana TCP/3000 | Connection succeeds | `22` | Passed |
| W5-FW-08 | SOC_ADMIN reaches Prometheus TCP/9090 | Connection succeeds | `23` | Passed |
| W5-FW-09 | USER reaches Grafana TCP/3000 | Connection denied | `24` | Passed |
| W5-FW-10 | USER reaches Prometheus TCP/9090 | Connection denied | `25` | Passed |
| W5-FW-11 | Denied traffic is visible in pfSense logs | Matching blocks appear | `17`, `27`, `28` | Passed |
| W5-FW-12 | DMZ cannot initiate arbitrary USER access | Default-deny policy configured | Rule screenshots only | Configured; no dedicated client test captured |
