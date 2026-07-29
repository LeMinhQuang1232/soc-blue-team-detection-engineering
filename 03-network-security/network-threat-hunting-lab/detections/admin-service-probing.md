# Administrative-Service Probing

## Logic

Attempts to destination ports `22`, `445`, or `3389` are counted. Three or more attempts in one source window trigger the administrative-service signal.

## Validation

The service-probing dataset produced six configured admin-port attempts and twelve failed connections. The base score was 35 Medium; the tuned score was 55 Medium.

## Analyst Triage

Confirm source role, whether the destination is expected to expose the service, firewall allow/deny result, authentication events, and whether the activity matches an approved management tool.
