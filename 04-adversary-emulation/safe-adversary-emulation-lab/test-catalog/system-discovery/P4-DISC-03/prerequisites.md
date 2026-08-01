# Prerequisites — P4-DISC-03

Complete this checklist before execution:

- [ ] WIN-ENDPOINT is authorized and has a snapshot.
- [ ] Sysmon and Wazuh agent are running.
- [ ] The operator has permission to run local read-only policy queries.
- [ ] The test timestamp is recorded.
- [ ] No change command such as `net accounts /...` is used.

## Health Gate

Do not begin a high-value test while the Wazuh agent is disconnected, its event queue is flooded, the required service is stopped, or timestamps cannot be correlated. Record any exception in the execution log rather than proceeding silently.

## Evidence Entry Points

- [Safety and baseline screenshots](../../../screenshots/01-safety-and-baseline/)
- [Full test README](README.md)
