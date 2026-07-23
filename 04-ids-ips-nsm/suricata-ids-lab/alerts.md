# Alert Summary

| Detection | Source | Destination | Output | Result |
|---|---|---|---|---|
| SQL injection pattern | Windows test client | Ubuntu DMZ HTTP | fast.log, eve.json | Alert generated |
| XSS pattern | Windows test client | Ubuntu DMZ HTTP | fast.log, eve.json | Alert generated |
| TCP SYN scan pattern | Windows test client | Ubuntu DMZ | fast.log, eve.json | Alert generated |

The Nginx access log independently confirms HTTP requests reached the server. Suricata provides the security interpretation, while Nginx provides application-layer request evidence.
