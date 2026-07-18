# Detection: Web SQL Injection, XSS, and Path Traversal Patterns

## 1. Goal

Identify URL-encoded request patterns commonly associated with SQL injection, cross-site scripting, and path-traversal attempts in Nginx access logs.

## 2. Data Source

- Log source: `/var/log/nginx/access.log`
- Wazuh log collector on `SOC-WAZUH`
- Relevant fields: source IP, URL, HTTP method, status code, user agent, log location, and timestamp

## 3. Detection Logic

- Rule 100130 searches the decoded URL field for SQL injection indicators such as encoded `union select`, encoded quote-plus-OR conditions, `information_schema`, or `sleep(`.
- Rule 100131 searches for encoded script tags, JavaScript/onerror indicators, encoded traversal sequences, or `/etc/passwd`.
- The logic detects request strings; it does not determine whether the target application executed the supplied input.

## 4. Wazuh Rule

| Detection | Built-in parent SID list in deployed XML | Custom rule | Level |
|---|---|---:|---:|
| SQL injection pattern | 31100, 31108 | 100130 | 10 |
| XSS/path traversal pattern | 31100, 31108 | 100131 | 10 |

The earlier assessment screenshot reviewed built-in rules 31100, 31103, and 31105, while the deployed custom XML uses 31108. This mismatch is documented as a tuning item rather than hidden.

## 5. Test Procedure

Safe HTTP requests were sent from `WIN-ENDPOINT` to the isolated Nginx server:

```powershell
curl.exe "http://192.168.56.10/"
curl.exe "http://192.168.56.10/search?q=normal"
curl.exe "http://192.168.56.10/search?q=union%20select%20password%20from%20users"
curl.exe "http://192.168.56.10/search?q=%27%20OR%201%3D1--"
curl.exe "http://192.168.56.10/search?q=%3Cscript%3Ealert(1)%3C%2Fscript%3E"
curl.exe "http://192.168.56.10/%2E%2E/%2E%2E/etc/passwd"
```

These commands only generated requests against an authorized lab web server.

## 6. Expected Alert

- SQL injection requests → rule 100130, level 10.
- XSS and path-traversal requests → rule 100131, level 10.
- Source IP → 192.168.56.20.
- Normal baseline requests → no custom web alert.

## 7. MITRE ATT&CK Mapping

| Tactic | Technique | ID | Reason |
|---|---|---|---|
| Initial Access | Exploit Public-Facing Application | T1190 | The requests attempted to deliver web exploit patterns to a public-facing service endpoint in the lab. |

## 8. Validation Result

- Expected result: Two SQLi alerts and two XSS/path-traversal alerts; normal requests do not match the custom rules.
- Actual result: Wazuh displayed four custom web-alert hits: two rule 100130 events and two rule 100131 events. Expanded events showed the encoded OR condition, XSS payload, and traversal URL. The normal requests were present in the source log but absent from the four custom-alert results.
- Status: Passed
- Verdict: True Positive — Authorized Lab Simulation.

## 9. False Positive Considerations

- Security scanners and web-application tests.
- Users searching for code examples or security-related strings.
- Encoded URLs containing suspicious tokens as legitimate data.
- Monitoring tools that request unusual paths.

## 10. Limitations

- A string match cannot prove successful exploitation.
- The observed SQLi/XSS requests returned HTTP 404 and the traversal request returned HTTP 400; no successful application compromise was demonstrated.
- URL encoding, double encoding, alternate case, parameter placement, and obfuscation may bypass narrow signatures.
- The deployed parent SID list differs from the original built-in-rule planning table and should be regression-tested.

## 11. Evidence

- [`screenshots/06-web-attacks/01-nginx-access-log.png`](../screenshots/06-web-attacks/01-nginx-access-log.png)
- [`screenshots/06-web-attacks/02-custom-alert-results.png`](../screenshots/06-web-attacks/02-custom-alert-results.png)
- [`screenshots/06-web-attacks/03-sqli-expanded-alert.png`](../screenshots/06-web-attacks/03-sqli-expanded-alert.png)
- [`screenshots/06-web-attacks/04-path-traversal-expanded-alert.png`](../screenshots/06-web-attacks/04-path-traversal-expanded-alert.png)
- [`screenshots/06-web-attacks/05-test-commands.png`](../screenshots/06-web-attacks/05-test-commands.png)
- [`screenshots/06-web-attacks/06-xss-expanded-alert.png`](../screenshots/06-web-attacks/06-xss-expanded-alert.png)
- [`screenshots/06-web-attacks/07-path-traversal-expanded-alert-2.png`](../screenshots/06-web-attacks/07-path-traversal-expanded-alert-2.png)
