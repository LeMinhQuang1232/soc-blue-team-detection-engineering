# Suricata Setup and Offline Validation

## Local Rules

The public rule file contains retained web signatures from the foundation lab and three Phase 1 reconnaissance signatures:

| SID | Revision | Detection |
|---:|---:|---|
| `1000003` | 2 | TCP SYN scan |
| `1000004` | 1 | ICMP host-discovery sweep |
| `1000006` | 1 | HTTP enumeration burst |

## Validate Syntax

```bash
sudo suricata -T -c /etc/suricata/suricata.yaml
```

## Offline PCAP Run

```bash
mkdir -p suricata-output
suricata -r capture.pcap \
  -c /etc/suricata/suricata.yaml \
  -l suricata-output
```

## Filter Only Local Alerts

```bash
jq -c 'select(.event_type=="alert" and (.alert.signature_id >= 1000000))' \
  suricata-output/eve.json
```

## Deployment Mode

This project validates Suricata in IDS/offline-analysis mode. It does not claim inline IPS blocking.
