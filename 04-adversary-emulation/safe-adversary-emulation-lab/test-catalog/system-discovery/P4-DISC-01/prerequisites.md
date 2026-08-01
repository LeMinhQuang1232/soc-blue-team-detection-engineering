# Prerequisites — P4-DISC-01

Complete this checklist before execution:

- [ ] WIN-ENDPOINT is authorized and has a recoverable snapshot.
- [ ] Sysmon and Wazuh agent are running.
- [ ] LimaCharlie is online when EDR evidence is required.
- [ ] The operator records a start time and test ID.
- [ ] The command is executed locally, not against an external target.

## Health Gate

Do not begin a high-value test while the Wazuh agent is disconnected, its event queue is flooded, the required service is stopped, or timestamps cannot be correlated. Record any exception in the execution log rather than proceeding silently.

## Evidence Entry Points

- [Safety and baseline screenshots](../../../screenshots/01-safety-and-baseline/)
- [Full test README](README.md)
