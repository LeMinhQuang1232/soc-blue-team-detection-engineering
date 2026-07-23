# pfSense Three-Zone Segmentation Lab

## Objective

Build a FortiGate-style segmentation model with pfSense and validate least-privilege access between a user network, a DMZ server, and an administration network.

## Architecture

```text
                              VirtualBox NAT / Internet
                                        |
                                  pfSense WAN
                                        |
                     +------------------+------------------+
                     |                  |                  |
              USER_NET             DMZ_NET            SOC_ADMIN
            192.168.10.0/24      192.168.20.0/24    192.168.30.0/24
                     |                  |                  |
          Windows test client     Ubuntu DMZ server   Windows test role
           192.168.10.10          192.168.20.10       192.168.30.10
                                  Nginx / Suricata
                              Prometheus / Grafana
```

A single Windows VM was used as the USER client and later connected to SOC_ADMIN for role-based testing, reducing VM resource requirements without changing the policy objectives.

## Results

| Test | Expected | Observed |
|---|---|---|
| USER to Nginx TCP/80 | Allow | Passed |
| USER to SSH TCP/22 | Block | Passed |
| USER to SMB TCP/445 | Block | Passed |
| USER to RDP TCP/3389 | Block | Passed |
| SOC_ADMIN to SSH TCP/22 | Allow | Passed |
| SOC_ADMIN to Grafana TCP/3000 | Allow | Passed |
| SOC_ADMIN to Prometheus TCP/9090 | Allow | Passed |
| USER to Grafana TCP/3000 | Block | Passed |
| USER to Prometheus TCP/9090 | Block | Passed |
| Denied traffic logged | Log | Passed |

[![Final USER rules](../screenshots/pfsense/26-user-firewall-rules-final.png)](../screenshots/pfsense/26-user-firewall-rules-final.png)

[![Blocked admin ports](../screenshots/pfsense/17-pfsense-blocked-admin-port-logs.png)](../screenshots/pfsense/17-pfsense-blocked-admin-port-logs.png)

See [the validation record](validation-tests.md), [firewall rules](pfsense-rules.md), and [troubleshooting analysis](troubleshooting.md).
