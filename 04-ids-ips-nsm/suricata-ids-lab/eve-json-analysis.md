# EVE JSON Analysis

## Observed fields

The filtered events exposed the fields needed for basic SOC triage:

- timestamp
- source and destination IP address
- source and destination port
- protocol
- alert signature
- severity

## Detection interpretation

| SID | Signature | Evidence-backed interpretation |
|---|---|---|
| `1000001` | LOCAL Possible SQL Injection Attempt | HTTP URI contained both `union` and `select` |
| `1000002` | LOCAL Possible XSS Script Tag | HTTP URI contained `<script` after decoding/inspection |
| `1000003` | LOCAL Possible TCP SYN Port Scan | At least 15 SYN packets from one source within 10 seconds |

## False-positive considerations

- The SQLi rule is intentionally simple and can match legitimate search strings containing both words.
- The XSS rule does not cover event-handler attributes, JavaScript URIs, mixed encoding, or evasions.
- The SYN threshold can alert on legitimate parallel connection bursts.
- Production deployment requires application context, baselining, exclusions, and rule tuning.

## Analyst conclusion

The alerts prove that local Suricata rules were loaded and evaluated. They do not prove application compromise; the requests were safe simulations against Nginx and no database or vulnerable application was exploited.
