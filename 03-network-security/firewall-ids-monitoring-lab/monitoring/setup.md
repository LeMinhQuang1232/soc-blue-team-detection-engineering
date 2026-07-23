# Setup and Validation

## Start the stack

```bash
cd ~/week5-monitoring
docker compose up -d
docker compose ps
```

## Validate configuration

```bash
docker exec week5-prometheus promtool check config /etc/prometheus/prometheus.yml
docker exec week5-prometheus promtool check rules /etc/prometheus/alert-rules.yml
```

## Validate endpoints

```bash
curl -fsS http://localhost:9090/-/healthy
curl -fsS http://localhost:9100/metrics | head
curl -I http://localhost:3000/login
```

## Grafana data source

When Grafana and Prometheus run in the same Compose network, Grafana must use the service name:

```text
http://prometheus:9090
```

Using `localhost:9090` inside the Grafana container points back to Grafana itself, not the Prometheus container.
