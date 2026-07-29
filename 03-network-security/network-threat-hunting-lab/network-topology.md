# Network Topology

```text
                         Internet / NAT
                               |
                           pfSense WAN
                               |
             +-----------------+-----------------+
             |                 |                 |
          USER_NET          DMZ_NET          SOC_ADMIN
       192.168.10.0/24   192.168.20.0/24   192.168.30.0/24
             |                 |                 |
 Windows USER endpoint    Ubuntu DMZ       Admin test role
     192.168.10.10       192.168.20.10      192.168.30.10
                               |
                     Nginx / Zeek / Suricata
                     Python detector / Wazuh
```

## Gateways

| Interface | Address |
|---|---|
| pfSense USER | `192.168.10.1` |
| pfSense DMZ | `192.168.20.1` |
| pfSense SOC_ADMIN | `192.168.30.1` |

## Relevant Policy

- USER traffic to DMZ HTTP was allowed for baseline and HTTP path testing.
- USER access to administrative services such as SSH, SMB, and RDP was blocked or filtered by policy.
- SOC_ADMIN was the approved administrative path.
- Logging was enabled to correlate traffic generation with firewall decisions.
