# P4-DISC-02 — Network Configuration and Connection Discovery

**Status:** Validated

## Objective

Generate safe network-discovery command lines using selected Windows native commands and Atomic Red Team T1016 tests.

## ATT&CK / Purpose

T1016 — System Network Configuration Discovery; connection-listing commands provide supporting network-connection discovery context.

## Result

Wazuh custom rule `100140` fired at level 8 and mapped discovery commands to T1016. LimaCharlie and local process evidence were also captured.

## Key Evidence

[Open screenshot](../../../screenshots/03-discovery/P4-DISC-038.png)

See the companion files for prerequisites, expected telemetry, and cleanup.
