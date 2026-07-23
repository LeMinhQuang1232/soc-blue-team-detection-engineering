# Incident Report — Controlled CPU Metrics Anomaly

## Executive Summary

A bounded `stress-ng` test was executed on the Ubuntu DMZ server to validate host monitoring. The stress process was visible in `top`, and Grafana displayed increased CPU activity. Prometheus continued scraping the host, and the alert-rule page later returned to normal after the test ended. The activity was authorized and caused no sustained outage.

## Evidence

- stress command and process utilization
- Prometheus target health
- CPU PromQL results
- Grafana CPU dashboard spike
- final normal alert-rule state

## Analysis

A metric spike is a signal requiring context, not a detection of malicious behavior by itself. In production, the analyst should identify the responsible process, compare the event to a baseline, review deployment/maintenance records, and correlate network, application, endpoint, firewall, and IDS telemetry.

## Limitation

No screenshot proves a complete Prometheus/Grafana alert firing notification and recovery workflow. The repository therefore records query/dashboard validation as complete and alert-delivery validation as partial.
