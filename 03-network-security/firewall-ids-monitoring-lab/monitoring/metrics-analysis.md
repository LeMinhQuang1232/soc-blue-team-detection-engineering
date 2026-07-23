# Metrics Analysis

## Controlled CPU anomaly

`stress-ng` was used for a bounded test. `top` showed the stress process consuming CPU, and Grafana displayed a corresponding increase in CPU activity.

## Analyst interpretation

Metrics indicate operational impact but not malicious intent. A CPU spike can result from legitimate workloads, a runaway process, scanning, cryptomining, denial of service, or maintenance. Investigation should correlate:

1. process and service telemetry;
2. firewall and IDS events;
3. application logs;
4. the metric time window;
5. an established baseline.

## Alert behavior

Prometheus alert rules were present and syntactically valid. The final screenshot showed normal/green state after the load ended. Because no screenshot captured an active notification or full firing state, the report records alert delivery validation as partial rather than complete.

## Timestamp alignment

The host used local time (`UTC+7`) while containers displayed UTC. The clocks represented the same underlying period with different timezone presentation. Correlation should normalize timestamps to UTC before comparing events.
