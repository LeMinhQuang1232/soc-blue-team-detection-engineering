# Suricata EVE JSON Analysis

## Alert Summary

```bash
jq -r 'select(.event_type=="alert") |
  [.timestamp,.src_ip,.dest_ip,.alert.signature_id,.alert.signature] | @tsv' eve.json
```

## Count Alerts by SID

```bash
jq -r 'select(.event_type=="alert") | .alert.signature_id' eve.json \
| sort -n | uniq -c | sort -nr
```

## Final TCP SYN Signature

```bash
jq -c 'select(.event_type=="alert" and .alert.signature_id==1000003)' eve.json
```

The final PCAP produced 195 matching alert records. This number is alert-record volume after the detection filter threshold was reached; it should not be described as 195 separate incidents.

## ICMP and HTTP Filters

```bash
jq -c 'select(.event_type=="alert" and .alert.signature_id==1000004)' eve.json
jq -c 'select(.event_type=="alert" and .alert.signature_id==1000006)' eve.json
```

## Fields Useful to an Analyst

- `timestamp`
- `flow_id`
- `src_ip` / `src_port`
- `dest_ip` / `dest_port`
- `proto`
- `alert.signature_id`
- `alert.signature`
- `alert.severity`
- `community_id` when available
