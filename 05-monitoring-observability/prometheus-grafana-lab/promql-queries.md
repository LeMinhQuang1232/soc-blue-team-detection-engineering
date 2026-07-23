# PromQL Queries

## CPU usage percentage

```promql
100 - (avg by(instance) (rate(node_cpu_seconds_total{mode="idle"}[5m])) * 100)
```

## Memory usage percentage

```promql
100 * (1 - (node_memory_MemAvailable_bytes / node_memory_MemTotal_bytes))
```

## Filesystem usage percentage

```promql
100 * (1 - (
  node_filesystem_avail_bytes{fstype!~"tmpfs|overlay"}
  /
  node_filesystem_size_bytes{fstype!~"tmpfs|overlay"}
))
```

## Network receive rate

```promql
sum by(instance) (rate(node_network_receive_bytes_total{device!="lo"}[5m]))
```

## Network transmit rate

```promql
sum by(instance) (rate(node_network_transmit_bytes_total{device!="lo"}[5m]))
```

Each query was validated in Prometheus. Grafana provided broader visualization through the Node Exporter Full dashboard.
