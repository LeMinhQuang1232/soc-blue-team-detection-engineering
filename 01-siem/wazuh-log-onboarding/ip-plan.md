# IP Plan

| Device | Interface | Address | Gateway | Purpose |
|---|---|---|---|---|
| VirtualBox host | Host-Only | 192.168.56.1/24 | N/A | Host access to the lab |
| SOC-WAZUH | NAT / enp0s3 | 10.0.2.15/24 | 10.0.2.2 | Internet access |
| SOC-WAZUH | Host-Only / enp0s8 | 192.168.56.10/24 | None | Stable Wazuh server address |
| WIN-ENDPOINT | NAT / Ethernet | 10.0.2.15/24 | 10.0.2.2 | Internet access |
| WIN-ENDPOINT | Host-Only / Ethernet 2 | 192.168.56.20/24 | None | Stable endpoint address |

The Host-Only interfaces did not use a default gateway. This prevented them from replacing the NAT default route.

The two VMs can show the same NAT guest address because VirtualBox NAT is handled separately for each VM. Their Host-Only addresses are unique inside the lab.
