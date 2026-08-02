# Network Analysis Notes

## Final PCAP Metadata

```bash
capinfos "$HOME/P1-INC01-R1-recapture/capture/P1-INC01-R1-recapture.pcap"
sha256sum "$HOME/P1-INC01-R1-recapture/capture/P1-INC01-R1-recapture.pcap"
```

## Zeek Offline Processing

Run Zeek in a clean output directory and keep the PCAP path explicit:

```bash
mkdir -p zeek-final
cd zeek-final
zeek -C -r ../capture/P1-INC01-R1-recapture.pcap /opt/zeek/share/zeek/site/local.zeek
```

## Example Zeek Checks

```bash
jq -r 'select(."id.orig_h"=="192.168.10.10" and ."id.resp_h"=="192.168.20.10") | ."id.resp_p"' conn.log |
  sort -nu
```

```bash
jq -c 'select(."id.orig_h"=="192.168.10.10" and ."id.resp_h"=="192.168.20.10")' http.log
```

## Suricata Correlation

Filter by the exact incident window and both hosts. Do not count unrelated `SURICATA IPv4 invalid checksum` events as proof of the bounded probe without matching flow context.
