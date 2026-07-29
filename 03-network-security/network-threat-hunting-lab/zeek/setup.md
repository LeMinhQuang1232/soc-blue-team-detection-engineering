# Zeek Setup

## Objective

Enable Zeek to produce machine-readable JSON metadata for offline PCAP analysis and optional live monitoring on the Ubuntu DMZ host.

## Configuration

The retained [`local.zeek`](local.zeek) enables JSON logs and defines the lab networks as local. JSON output is required because the Python parser reads one JSON object per line.

## Verification

```bash
zeek --version
sudo zeekctl check
sudo zeekctl deploy
sudo zeekctl status
```

For offline analysis:

```bash
mkdir -p zeek-logs
cd zeek-logs
zeek -C -r ../capture.pcap ../../../zeek/local.zeek
```

`-C` disables checksum validation during offline analysis, which is useful for virtualized captures with checksum offload.

## Expected Outputs

Depending on the scenario:

```text
conn.log
http.log
files.log
packet_filter.log
reporter.log
```

## Validation Evidence

- Zeek version and service/configuration screenshots are in `../screenshots/00-setup/`.
- JSON `conn.log` and `http.log` examples are retained as screenshots and raw logs.
