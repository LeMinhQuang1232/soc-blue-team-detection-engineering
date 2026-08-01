# Cleanup — P4-FILE-01

- [ ] Delete `C:\AtomicLab\p4-safe.txt`.
- [ ] Delete `/var/www/html/p4-safe.txt`.
- [ ] Verify the HTTP artifact is no longer retrievable.
- [ ] Retain the hash and screenshots, not the transient test file.
- [ ] Confirm Nginx, Wazuh, and monitoring services remain healthy.

## Completion Rule

Mark cleanup complete only after the artifact, account, session, process, or temporary output has been verified absent and the required monitoring services remain operational. A command being issued is not sufficient evidence by itself; record the verification result.

## Evidence Entry Points

- [Test-specific evidence gallery](README.md#evidence-gallery)
- [Cleanup and recovery screenshots](../../../screenshots/08-cleanup-and-recovery/)
- [Project cleanup checklist](../../../cleanup-checklist.md)
