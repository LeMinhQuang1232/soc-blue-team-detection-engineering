# Baseline Traffic

## Purpose

The baseline provides a negative control so that reconnaissance results can be compared with known normal activity.

## Normal Activities

- A small number of HTTP requests from `192.168.10.10` to Nginx on `192.168.20.10:80`.
- Successful TCP sessions.
- Limited URI diversity.
- No burst across many ports or hosts.
- No repeated administrative-service attempts.

## Measured Result

| Metric | Result |
|---|---:|
| Packets | 37 |
| Zeek connections | 4 |
| Destination hosts | 1 |
| Destination ports | 1 |
| Unique HTTP URIs | 3 across detector windows |
| Failed connections | 0 |
| Base score | 0 Low |
| Tuned score | 0 Low |

## Baseline Decision

No detector alert was emitted. Any production deployment should collect a much longer baseline and separate user, server, scanner, and management-source behavior.
