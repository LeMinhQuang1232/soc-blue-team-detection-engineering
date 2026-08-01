# Cleanup — P4-EICAR-01

- [ ] Allow Defender to quarantine/remediate the test artifact.
- [ ] Verify the file is absent from the designated directory.
- [ ] Do not restore or retain the artifact.
- [ ] Confirm Defender and real-time protection remain enabled.
- [ ] Confirm Wazuh agent remains connected.
- [ ] Retain only detection/remediation screenshots that do not expose the literal string.

## Completion Rule

Mark cleanup complete only after the artifact, account, session, process, or temporary output has been verified absent and the required monitoring services remain operational. A command being issued is not sufficient evidence by itself; record the verification result.

## Evidence Entry Points

- [Test-specific evidence gallery](README.md#evidence-gallery)
- [Cleanup and recovery screenshots](../../../screenshots/08-cleanup-and-recovery/)
- [Project cleanup checklist](../../../cleanup-checklist.md)
