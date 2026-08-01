# P4-AUTH-01 — Controlled Failed Authentication

**Status:** Validated

## Objective

Create a temporary local account and generate repeated wrong-password attempts against the local IPC share.

## ATT&CK / Purpose

T1110-aligned controlled password-guessing simulation.

## Result

Multiple failed logons were visible in Wazuh and local Windows event details. A controlled success path was tested before cleanup.

## Key Evidence

[Open screenshot](../../../screenshots/04-authentication/P4-AUTH-005.png)

See the companion files for prerequisites, expected telemetry, and cleanup.
