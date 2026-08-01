# P4-EXEC-01 — Benign Encoded PowerShell

**Status:** Validated

## Objective

Generate a harmless encoded PowerShell process to validate command-line telemetry and existing detections.

## ATT&CK / Purpose

T1059.001 — Command and Scripting Interpreter: PowerShell

## Result

LimaCharlie captured process context. Wazuh rule `92057` fired at level 12 and mapped the event to T1059.001.

## Key Evidence

[Open screenshot](../../../screenshots/02-endpoint-execution/P4-EXEC-007.png)

See the companion files for prerequisites, expected telemetry, and cleanup.
