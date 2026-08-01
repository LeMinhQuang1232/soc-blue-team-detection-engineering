# Cleanup — P4-AUTH-01

- [ ] Run `net use \127.0.0.1\IPC$ /delete` and confirm the session is gone.
- [ ] Remove `P4-LabUser`.
- [ ] Verify the user no longer appears in local account queries.
- [ ] Confirm no scheduled task, service, saved credential, or persistent share connection was created.
- [ ] Review screenshots before publication and redact any visible password.

## Completion Rule

Mark cleanup complete only after the artifact, account, session, process, or temporary output has been verified absent and the required monitoring services remain operational. A command being issued is not sufficient evidence by itself; record the verification result.

## Evidence Entry Points

- [Test-specific evidence gallery](README.md#evidence-gallery)
- [Cleanup and recovery screenshots](../../../screenshots/08-cleanup-and-recovery/)
- [Project cleanup checklist](../../../cleanup-checklist.md)
