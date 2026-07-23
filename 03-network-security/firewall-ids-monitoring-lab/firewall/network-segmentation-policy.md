# Network Segmentation Policy

## Security goals

1. Permit standard users to consume Nginx over HTTP/HTTPS.
2. Prevent USER_NET from reaching administrative services on the DMZ server.
3. Permit SOC_ADMIN to reach explicitly approved administrative and monitoring services.
4. Prevent broad lateral movement between zones.
5. Log denied traffic for investigation.

## Policy matrix

| Source | Destination | Services | Action | Logging | Rationale |
|---|---|---|---|---|---|
| USER_NET | DMZ_WEB_SERVER | TCP 80, 443 | Pass | Optional/pass log | Business web access |
| USER_NET | DMZ_NET | TCP 22, 445, 3389 | Block | Yes | Prevent remote administration and lateral movement |
| USER_NET | DMZ_NET | Any remaining traffic | Block | Yes | Default-deny between user and DMZ zones |
| USER_NET | Internet | DNS, TCP 80/443 as required | Pass | As needed | Client name resolution and updates |
| SOC_ADMIN | DMZ_WEB_SERVER | TCP 22 | Pass | Yes | Controlled SSH administration |
| SOC_ADMIN | DMZ_WEB_SERVER | TCP 3000, 9090 | Pass | Yes | Grafana and Prometheus administration |
| USER_NET | DMZ_WEB_SERVER | TCP 3000, 9090 | Block | Yes | Monitoring consoles are not user services |
| DMZ_NET | USER_NET | Any unsolicited traffic | Block | Yes | Limit reverse lateral movement |
| DMZ_NET | Internet | TCP 80/443 and required DNS | Pass | As needed | Package and rule updates |

Rule ordering matters because pfSense evaluates interface rules from top to bottom and applies the first matching rule. Specific permits must appear above broad denies.
