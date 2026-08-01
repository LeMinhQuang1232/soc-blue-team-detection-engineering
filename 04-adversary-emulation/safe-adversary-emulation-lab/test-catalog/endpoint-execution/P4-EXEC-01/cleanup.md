# Cleanup — P4-EXEC-01

- [ ] Close the temporary PowerShell process after the command completes.
- [ ] Confirm no script file, scheduled task, service, registry autorun, or startup entry was created.
- [ ] Review child processes and network telemetry for unexpected activity.
- [ ] Retain screenshots and alert metadata; do not retain unnecessary transient console output.
- [ ] Confirm Wazuh and LimaCharlie remain connected after the test.

## Completion Rule

Mark cleanup complete only after the artifact, account, session, process, or temporary output has been verified absent and the required monitoring services remain operational. A command being issued is not sufficient evidence by itself; record the verification result.

## Evidence Entry Points

- [Test-specific evidence gallery](README.md#evidence-gallery)
- [Cleanup and recovery screenshots](../../../screenshots/08-cleanup-and-recovery/)
- [Project cleanup checklist](../../../cleanup-checklist.md)
