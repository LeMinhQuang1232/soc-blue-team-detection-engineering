# P4-NET-01 — Controlled Service Probing and Detector Replay

**Status:** Partial — Suricata attribution/tuning gap

## Objective

Validate reusable network-hunting coverage using a new low-volume service probe and a clearly labeled replay of the prior full-scan dataset.

## ATT&CK / Purpose

T1046 — Network Service Discovery.

## Result

The new capture contained relevant HTTP/HTTPS service records. The replayed full-scan dataset contained 100 unique ports and 200 failed connections; Python scored it 50 Medium and classified `probable_port_scan`; Wazuh rule `100201` fired at level 7. The isolated Suricata output did not prove a matching current alert, while the live EVE file contained historical and 1514 stream/scan noise.

## Key Evidence

[Open screenshot](../../../screenshots/06-network-validation/P4-NET-018.png)

See the companion files for prerequisites, expected telemetry, and cleanup.
