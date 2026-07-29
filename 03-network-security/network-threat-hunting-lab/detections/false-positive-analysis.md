# False-Positive Analysis

| Detection | Potential benign cause | Recommended control |
|---|---|---|
| Port scan | Authorized vulnerability scanner | Scanner allowlist and maintenance schedule |
| Host discovery | Monitoring or inventory job | Source-role and service-account context |
| Admin probing | Configuration management or help desk activity | Approved management subnet and change ticket |
| HTTP paths | Crawler, synthetic monitoring, application test | Known user agent, source, and application-specific threshold |
| Failed burst | Outage, closed ports, routing problem | Failure ratio plus destination diversity and health status |

## General Tuning Principles

- Baseline by source role and destination role.
- Separate alert generation from raw telemetry retention.
- Use suppression to prevent repeated incident creation for the same window.
- Correlate signature, firewall, authentication, and endpoint evidence.
- Investigate deviations from normal behavior, not only static thresholds.
