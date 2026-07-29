# Wazuh Integration Validation

## 1. Decoder Test

Paste one JSON detector event into:

```bash
sudo /var/ossec/bin/wazuh-logtest
```

Expected: JSON fields are decoded and parent rule `100200` matches.

## 2. Child Rule Test

The final base-profile event contains:

```json
"risk_level": "Medium"
```

Expected: child rule `100201`, Wazuh level 7.

## 3. Dashboard Test

Query:

```text
rule.id:100201
```

Expected expanded evidence:

- Source `192.168.10.10`.
- Classification `probable_port_scan`.
- Risk score `50`.
- Risk level `Medium`.
- 100 unique destination ports.
- 200 failed connections.

Screenshots are retained in `../screenshots/06-wazuh-integration/` and `../screenshots/07-tcp-syn-scan/`.
