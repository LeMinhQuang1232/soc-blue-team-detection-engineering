# Wazuh Hunting Queries

Use one of the following dashboard queries, depending on available field mapping.

## All Detector Alerts

```text
rule.id:(100201 OR 100202 OR 100203)
```

```text
rule.groups:"network_reconnaissance"
```

## Medium Events

```text
rule.id:100201
```

## Final Source

```text
source_ip:"192.168.10.10"
```

or, in deployments that prefix decoded JSON fields:

```text
data.source_ip:"192.168.10.10"
```

## Port Scan Classification

```text
classification:"probable_port_scan"
```

```text
data.classification:"probable_port_scan"
```

## Suggested Expanded Fields

- `rule.id`
- `rule.level`
- `source_ip`
- `risk_score`
- `risk_level`
- `classification`
- `unique_destination_ports`
- `unique_destination_hosts`
- `failed_connections`
- `admin_service_attempts`
- `unique_http_uris`
- `signals`
- `window_start`
- `window_end`
