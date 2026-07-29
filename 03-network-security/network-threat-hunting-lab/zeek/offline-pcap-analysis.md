# Offline PCAP Analysis

## Standard Workflow

```bash
SCENARIO="tcp-syn-scan"
cd "pcap-investigations/$SCENARIO"
rm -rf zeek-logs
mkdir zeek-logs
cd zeek-logs
zeek -C -r ../capture.pcap ../../../zeek/local.zeek
```

## Integrity Check

```bash
sha256sum -c capture.sha256
```

## Basic Counts

```bash
jq -r '."id.orig_h"' zeek-logs/conn.log | sort -u
jq -r '."id.resp_h"' zeek-logs/conn.log | sort -u | wc -l
jq -r '."id.resp_p"' zeek-logs/conn.log | sort -nu | wc -l
jq -r '.conn_state' zeek-logs/conn.log | sort | uniq -c
```

## HTTP URI Count

```bash
jq -r '.uri // empty' zeek-logs/http.log | sort -u
```

## Notes

- Run each PCAP in a clean output directory to avoid mixing logs.
- Keep the original capture immutable and record its SHA-256.
- Read `reporter.log` before assuming an empty or unusual log is a detector failure.
