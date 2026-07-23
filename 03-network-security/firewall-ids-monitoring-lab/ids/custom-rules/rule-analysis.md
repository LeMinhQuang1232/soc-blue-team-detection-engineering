# Local Rule Analysis

## SID 1000001 — SQL injection pattern

Requires an established client-to-server HTTP flow and both `union` and `select` in the URI. This reduces accidental matches compared with a single keyword but still does not validate SQL syntax or exploitability.

## SID 1000002 — XSS script tag

Looks for `<script` in the HTTP URI without case sensitivity. It is useful for demonstrating decoded HTTP inspection but does not cover the broader XSS attack surface.

## SID 1000003 — TCP SYN scan

Counts SYN packets by source and alerts when 15 occur within ten seconds. The rule is stateless and therefore useful for lab scan visibility, but legitimate connection bursts can trigger it.

## Improvement ideas

- Add URI normalization and more selective content anchors.
- Split SQLi patterns into separate rules and include metadata/classification.
- Add flowbits or application context where useful.
- Establish thresholds from a normal traffic baseline.
- Add tests for normal traffic and common evasions.
