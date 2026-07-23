# IP Address Plan

| System / interface | Address | Gateway | Purpose |
|---|---|---|---|
| pfSense WAN | DHCP | VirtualBox NAT | Internet-facing lab interface |
| pfSense USER | `192.168.10.1/24` | — | USER_NET gateway |
| Windows USER role | `192.168.10.10/24` | `192.168.10.1` | Traffic generation and policy validation |
| pfSense DMZ | `192.168.20.1/24` | — | DMZ gateway |
| Ubuntu DMZ | `192.168.20.10/24` | `192.168.20.1` | Nginx, Suricata, Prometheus, Grafana, node_exporter |
| pfSense SOC_ADMIN | `192.168.30.1/24` | — | Administration gateway |
| Windows SOC_ADMIN role | `192.168.30.10/24` | `192.168.30.1` | Authorized SSH and monitoring access |

An older host-only address (`192.168.56.20`) remained visible during early validation. It was not used as the source identity for the final zone-policy tests.
