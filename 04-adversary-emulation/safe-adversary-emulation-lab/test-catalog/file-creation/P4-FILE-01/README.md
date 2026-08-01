# P4-FILE-01 — Controlled HTTP File Transfer

**Status:** Validated

## Objective

Download a harmless text artifact from the lab Nginx server to validate file, process, web, and network telemetry.

## ATT&CK / Purpose

T1105 — Ingress Tool Transfer, used here as a harmless controlled transfer pattern.

## Result

The file was downloaded and hashed. Sysmon recorded file creation. Wazuh rule `100150` fired at level 8 with T1105. Nginx and Zeek evidence confirmed the transfer.

## Key Evidence

[Open screenshot](../../../screenshots/05-file-transfer/P4-FILE-013.png)

See the companion files for prerequisites, expected telemetry, and cleanup.
