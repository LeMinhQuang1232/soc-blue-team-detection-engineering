# Lab Isolation

The test environment used VirtualBox NAT and internal networks rather than a bridged connection to the physical LAN.

| Zone | Network | Purpose |
|---|---|---|
| USER_NET | `192.168.10.0/24` | Source endpoint traffic |
| DMZ_NET | `192.168.20.0/24` | Wazuh, Nginx, Zeek, and Suricata target |
| SOC_ADMIN | `192.168.30.0/24` | Administrative validation in foundation labs |

The final baseline confirmed HTTP access from USER_NET to the DMZ and denial of unauthorized SSH from the USER role.
