# P4-EICAR-01 — EICAR Antivirus Validation

**Status:** Validated

## Objective

Validate Microsoft Defender detection and remediation using the standard EICAR antivirus test inside the isolated VM.

## ATT&CK / Purpose

Defensive control validation. EICAR is not treated as a malware-behavior ATT&CK technique.

## Result

Defender identified `Virus:DOS/EICAR_Test_File`, severity Severe, and quarantined the file successfully. Wazuh rules `62123` and `62124` recorded detection and remediation events. A timestamped retest also produced 1116/1117.

## Key Evidence

[Open screenshot](../../../screenshots/07-eicar-validation/P4-EICAR-010.png)

See the companion files for prerequisites, expected telemetry, and cleanup.
