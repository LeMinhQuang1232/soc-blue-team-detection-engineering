# Zeek Hunting Queries

All examples assume JSON Zeek logs.

## Top Sources by Connection Count

```bash
jq -r '."id.orig_h"' conn.log | sort | uniq -c | sort -nr
```

## Unique Ports per Source

```bash
jq -r '[."id.orig_h", ."id.resp_p"] | @tsv' conn.log \
| sort -u \
| awk '{count[$1]++} END {for (ip in count) print count[ip], ip}' \
| sort -nr
```

## Unique Destination Hosts per Source

```bash
jq -r '[."id.orig_h", ."id.resp_h"] | @tsv' conn.log \
| sort -u \
| awk '{count[$1]++} END {for (ip in count) print count[ip], ip}' \
| sort -nr
```

## Failed States from the Lab Source

```bash
jq -r 'select(."id.orig_h"=="192.168.10.10") | .conn_state' conn.log \
| sort | uniq -c
```

## Administrative Ports

```bash
jq -c 'select(."id.resp_p"==22 or ."id.resp_p"==445 or ."id.resp_p"==3389)' conn.log
```

## Unique HTTP Paths

```bash
jq -r 'select(."id.orig_h"=="192.168.10.10") | .uri // empty' http.log \
| sort -u
```

## Status Codes by URI

```bash
jq -r '[.uri, (.status_code|tostring)] | @tsv' http.log | sort
```
