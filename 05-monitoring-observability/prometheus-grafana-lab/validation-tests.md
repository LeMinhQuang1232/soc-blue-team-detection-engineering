# Monitoring Validation Tests

| ID | Test | Expected | Status |
|---|---|---|---|
| W5-MON-01 | Docker Compose services | Three containers running | Passed |
| W5-MON-02 | Prometheus configuration | promtool success | Passed |
| W5-MON-03 | Alert rule syntax | promtool success | Passed |
| W5-MON-04 | node_exporter endpoint | Metrics returned | Passed |
| W5-MON-05 | Prometheus targets | prometheus and ubuntu-node UP | Passed |
| W5-MON-06 | Grafana data source | Query succeeds | Passed |
| W5-MON-07 | CPU PromQL | Data returned | Passed |
| W5-MON-08 | Memory PromQL | Data returned | Passed |
| W5-MON-09 | Disk PromQL | Data returned | Passed |
| W5-MON-10 | Network RX/TX PromQL | Data returned | Passed |
| W5-MON-11 | Controlled CPU load | Process and dashboard spike visible | Passed |
| W5-MON-12 | Alert returns to normal | Green/normal after stress | Passed |
| W5-MON-13 | Alert firing and notification | Firing plus delivered notification | Partial; no complete evidence set |
| W5-MON-14 | SOC_ADMIN access to 3000/9090 | Allowed | Passed |
| W5-MON-15 | USER access to 3000/9090 | Blocked | Passed |
