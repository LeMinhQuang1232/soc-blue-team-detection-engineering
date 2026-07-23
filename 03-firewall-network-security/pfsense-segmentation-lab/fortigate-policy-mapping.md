# pfSense to FortiGate Policy Mapping

The lab used pfSense, but the design maps directly to common FortiGate policy concepts.

| pfSense concept | FortiGate concept | Lab example |
|---|---|---|
| Interface tab | Incoming interface | USER_NET or SOC_ADMIN |
| Destination network/interface | Outgoing interface | DMZ_NET |
| Host alias | Firewall address object | `DMZ_WEB_SERVER` |
| Port alias | Custom service object/service group | `WEB_PORTS`, `ADMIN_PORTS` |
| Pass rule | Accept firewall policy | USER to DMZ web |
| Block rule | Deny firewall policy | USER to DMZ admin ports |
| Rule order | Policy sequence | Specific allow before broad deny |
| Log packets | Log allowed/denied traffic | Administrative-port deny evidence |
| Suricata IDS | IPS/security-profile concept | Signature inspection for allowed traffic |

## Example FortiGate-style policy representation

```text
Policy name: USER_to_DMZ_WEB
Incoming interface: USER_NET
Outgoing interface: DMZ_NET
Source: USER_NET_SUBNET
Destination: DMZ_WEB_SERVER
Service: HTTP, HTTPS
Action: ACCEPT
NAT: Disabled for inter-zone routing
Logging: Enabled as required
Security profile: IPS profile conceptually maps to Suricata inspection
```

This is a conceptual mapping; no FortiGate appliance or FortiOS VM was deployed, and the repository does not claim FortiGate implementation experience beyond policy translation.
