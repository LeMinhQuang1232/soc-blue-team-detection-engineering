# Cleanup — P4-NET-01

- [ ] Stop packet capture and detector processes.
- [ ] Remove transient run outputs that are not part of the retained evidence set.
- [ ] Preserve hashes for any retained PCAP or structured output.
- [ ] Do not delete historical EVE data before documenting why it was excluded.
- [ ] Confirm pfSense, Zeek workflow, Suricata, and Wazuh remain operational.
- [ ] Keep the status `Partial` until a fresh isolated Suricata alert is proven.

## Completion Rule

Mark cleanup complete only after the artifact, account, session, process, or temporary output has been verified absent and the required monitoring services remain operational. A command being issued is not sufficient evidence by itself; record the verification result.

## Evidence Entry Points

- [Test-specific evidence gallery](README.md#evidence-gallery)
- [Cleanup and recovery screenshots](../../../screenshots/08-cleanup-and-recovery/)
- [Project cleanup checklist](../../../cleanup-checklist.md)
