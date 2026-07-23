# Architecture and Trust Boundaries

## Zones

| Zone | Subnet | Gateway | Primary role | Trust level |
|---|---|---|---|---|
| WAN | DHCP through VirtualBox NAT | DHCP | Package and Internet access | Untrusted |
| USER_NET | `192.168.10.0/24` | `192.168.10.1` | Standard user/client traffic | Low |
| DMZ_NET | `192.168.20.0/24` | `192.168.20.1` | Public-facing web, IDS, and monitoring host | Restricted |
| SOC_ADMIN | `192.168.30.0/24` | `192.168.30.1` | Administrative access | High |

## Design intent

- USER_NET receives only the services required to consume the DMZ web application.
- Administrative ports are not exposed to USER_NET.
- Monitoring interfaces are reserved for SOC_ADMIN.
- DMZ egress is limited to necessary update and service traffic.
- Deny rules are logged so an analyst can distinguish policy enforcement from host or application failure.

[![Interface assignments](../screenshots/pfsense/04-pfsense-interface-assignments.png)](../screenshots/pfsense/04-pfsense-interface-assignments.png)
