# Incident Response and Detection Validation

This category contains integrated projects that reuse the repository's SIEM, EDR, network-security, threat-hunting, and safe-testing foundations in a complete SOC workflow.

| Project | Scope | Status |
|---|---|---|
| [SOC Detection Validation and Incident Response](soc-detection-validation-and-incident-response/) | Controlled incident execution, cross-layer triage, containment, recovery, gap analysis, tuning, and retest | Completed with a documented partial network behavioral result |

## How This Project Connects

The project reuses the test catalog from `04-adversary-emulation`, the Wazuh detections in `01-siem`, LimaCharlie response in `02-edr-endpoint-security`, and network evidence workflows in `03-network-security`.

## Test Organization

The reusable master test definitions remain in `04-adversary-emulation/safe-adversary-emulation-lab/test-catalog/`. This category stores only the incident-specific selection, mapping, execution, and retest records in [`incident-tests/`](soc-detection-validation-and-incident-response/incident-tests/).
