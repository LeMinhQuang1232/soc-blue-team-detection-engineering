# Response Validation — Endpoint Network Isolation

## Goal

Validate that the EDR response workflow can block ordinary endpoint network traffic and document the required recovery evidence.

## Test Procedure

1. Confirm ping and HTTP access to `192.168.56.10`.
2. Issue `segregate_network` from the LimaCharlie console.
3. Repeat ping and HTTP tests.
4. Issue `rejoin_network`.
5. Confirm connectivity is restored.

## Observed Result

| Stage | Result | Status |
|---|---|---|
| Connectivity before isolation | Ping and HTTP succeeded | Passed |
| Isolation console | Command displayed `AWAITING` | Partial |
| Connectivity after request | Ping and HTTP failed | Passed |
| Rejoin command | Not captured | Pending Evidence |
| Restored connectivity | Not captured | Pending Evidence |

## Evidence

- `screenshots/04-containment/01-connectivity-before.png`
- `screenshots/04-containment/02-segregate-network-awaiting.png`
- `screenshots/04-containment/03-connectivity-blocked.png`
