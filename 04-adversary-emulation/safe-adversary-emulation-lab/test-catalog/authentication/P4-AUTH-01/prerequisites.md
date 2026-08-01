# Prerequisites — P4-AUTH-01

Complete this checklist before execution:

- [ ] A current VM snapshot exists.
- [ ] Windows Security auditing is enabled for authentication events.
- [ ] Wazuh agent is connected and collecting the Security channel.
- [ ] The operator can create and remove a local temporary account.
- [ ] A lab-only temporary password is prepared and will not be committed.
- [ ] The attempt count and time window are defined before execution.

## Health Gate

Do not begin a high-value test while the Wazuh agent is disconnected, its event queue is flooded, the required service is stopped, or timestamps cannot be correlated. Record any exception in the execution log rather than proceeding silently.

## Evidence Entry Points

- [Safety and baseline screenshots](../../../screenshots/01-safety-and-baseline/)
- [Full test README](README.md)
