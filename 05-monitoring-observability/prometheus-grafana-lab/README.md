# Prometheus and Grafana Monitoring Lab

## Objective

Deploy a lightweight monitoring stack on the Ubuntu DMZ server, verify scrape health, query host metrics, visualize them in Grafana, generate a safe CPU load, and restrict console access to SOC_ADMIN.

## Stack

- Prometheus: TCP/9090
- node_exporter: TCP/9100
- Grafana: TCP/3000
- Docker Compose deployment
- Grafana Prometheus data source: `http://prometheus:9090`

## Evidence-backed results

- All three containers were running.
- Prometheus configuration and alert rules passed `promtool` validation.
- Prometheus and ubuntu-node targets were UP.
- CPU, memory, disk, network RX, and network TX queries returned data.
- Grafana Node Exporter Full panels displayed host metrics and a controlled CPU spike.
- SOC_ADMIN could access TCP/3000 and 9090; USER_NET could not.
- Alert rules returned to normal after the stress activity ended.
- No screenshot captured a complete firing-to-recovery alert notification sequence.

![Prometheus targets](../../08-dashboards-screenshots/prometheus/07-prometheus-targets-up.png)

![Grafana CPU dashboard](../../08-dashboards-screenshots/grafana/06-grafana-cpu-dashboard.png)
