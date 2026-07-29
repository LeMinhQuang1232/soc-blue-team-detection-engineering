# Python Reconnaissance Detector

## Purpose

Parse Zeek JSON `conn.log` and optional `http.log`, aggregate by source and 30-second time window, calculate behavior metrics, score the window, and emit JSON Lines suitable for Wazuh.

## Files

| File | Purpose |
|---|---|
| `detect_recon.py` | CLI, time-window aggregation, alert output |
| `parsers.py` | Defensive JSON Lines parsing and normalization |
| `scoring.py` | Risk calculation, risk level, classification |
| `config.yaml` | Validated base profile |
| `config-tuned.yaml` | Sensitivity comparison profile |
| `requirements.txt` | PyYAML dependency |
| `tests/` | Unit tests |
| `sample-output/` | Reproducible scenario output |

## Installation

```bash
python3 -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
```

## Run a Scenario

```bash
TZ=Asia/Ho_Chi_Minh python3 detect_recon.py \
  --conn ../pcap-investigations/tcp-syn-scan/zeek-logs/conn.log \
  --config config.yaml \
  --output /tmp/network-recon-alerts.json
```

Add `--http` for HTTP metadata:

```bash
TZ=Asia/Ho_Chi_Minh python3 detect_recon.py \
  --conn ../pcap-investigations/http-path-probing/zeek-logs/conn.log \
  --http ../pcap-investigations/http-path-probing/zeek-logs/http.log \
  --config config-tuned.yaml \
  --output /tmp/http-alerts.json
```

Use `--emit-all` to retain Low/below-threshold windows for baseline validation.

## Output Contract

Each output line contains one event conforming to `../wazuh-integration/alert-schema.json`.

## Error Handling

- Missing configuration or log path returns a non-zero exit code.
- Invalid JSON lines are skipped with warnings.
- Missing source IP or invalid timestamps are skipped.
- Risk score is capped at 100.

## Tests

```bash
python3 -m unittest discover -s tests -v
```
