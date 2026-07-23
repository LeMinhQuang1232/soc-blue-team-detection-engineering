# Suricata Setup

## Host and interface

- Host: Ubuntu DMZ server `192.168.20.10`.
- Capture interface: the actual DMZ NIC shown by `ip -br address` (`enp0s3` in the lab).
- HOME_NET: `192.168.20.0/24`.
- Local rules: `/var/lib/suricata/rules/local.rules`.
- Primary outputs: `/var/log/suricata/fast.log` and `/var/log/suricata/eve.json`.

## Validation workflow

```bash
ip -br address
ip route
sudo suricata -T -c /etc/suricata/suricata.yaml -v
sudo systemctl restart suricata
sudo systemctl status suricata --no-pager
sudo tail -f /var/log/suricata/fast.log
```

## EVE JSON analyst view

```bash
sudo jq 'select(.event_type=="alert" and (.alert.signature | startswith("LOCAL"))) |
  {timestamp,src_ip,src_port,dest_ip,dest_port,proto,signature:.alert.signature,severity:.alert.severity}' \
  /var/log/suricata/eve.json
```
