# Monitoring Troubleshooting

## 1. Prometheus container restarting

The initial stack experienced a Prometheus restart loop until the configuration and mounted rule paths were corrected. The final state was validated with `promtool check config`, `promtool check rules`, and `docker compose ps`.

## 2. Grafana showed no data

Checks performed:

- node_exporter endpoint returned metrics;
- Prometheus targets were UP;
- Prometheus queries returned node metrics;
- Grafana data source used `http://prometheus:9090` on the Compose network;
- the dashboard selected the correct `ubuntu-node` job/instance;
- dashboard time range included the current data.

## 3. Time appeared out of sync

The host displayed local Asia/Ho_Chi_Minh time while containers logged UTC. The fix was analytical normalization, not changing healthy container clocks.

## 4. Monitoring consoles exposed to USER_NET during setup

Temporary access rules were used during testing. The final policy permits TCP/3000 and TCP/9090 from SOC_ADMIN and blocks those ports from USER_NET. This demonstrates the difference between a temporary implementation rule and the final least-privilege state.
