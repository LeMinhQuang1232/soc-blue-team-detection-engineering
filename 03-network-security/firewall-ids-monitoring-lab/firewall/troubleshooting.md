# Firewall and Connectivity Troubleshooting

## 1. HTTP rule appeared correct, but Nginx timed out

### Symptoms

- pfSense policy permitted USER_NET to `192.168.20.10:80`.
- Nginx listened on `0.0.0.0:80` and `[::]:80`.
- A packet capture on Ubuntu showed the TCP SYN arriving from `192.168.10.10`, but no SYN-ACK left the server.

### Root cause

Ubuntu UFW was blocking the connection after pfSense had already routed and permitted it. This is a key troubleshooting lesson: network firewalls and host firewalls are independent enforcement layers.

### Fix

```bash
sudo ufw allow from 192.168.10.0/24 to any port 80 proto tcp
sudo ufw allow from 192.168.30.0/24 to any port 22 proto tcp
sudo ufw status verbose
```

UFW can be disabled briefly for diagnosis, but an explicit allow rule is the correct final state. After the host rule was corrected, `curl.exe` and `Test-NetConnection -Port 80` succeeded.

## 2. DMZ server could ping an IP but package downloads or DNS failed

### Analysis

Successful `ping 1.1.1.1` with failed name resolution indicates a DNS problem, not a general routing problem. During package installation, the lab also encountered limited DMZ egress.

### Temporary recovery used in the lab

1. Power off Ubuntu.
2. Change its VirtualBox adapter from `DMZ_NET` to NAT.
3. Temporarily switch Netplan to DHCP.
4. Install Suricata/Docker packages.
5. Power off, restore `DMZ_NET`, and restore the static `192.168.20.10/24` configuration.

This workaround was temporary. The final security design should instead provide controlled DNS and HTTP/HTTPS egress through pfSense.

## 3. Wrong source interface during testing

The Windows VM initially displayed an old host-only address in addition to `192.168.10.10`. Policy tests were validated using the `SourceAddress` field in PowerShell output. Final SOC_ADMIN tests used source `192.168.30.10`.

## 4. Rule order

A broad block placed above a specific pass causes valid traffic to fail. The final rules place web and SOC_ADMIN permits above broad inter-zone denies.
