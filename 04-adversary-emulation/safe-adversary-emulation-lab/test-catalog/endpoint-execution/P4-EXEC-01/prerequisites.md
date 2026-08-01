# Prerequisites — P4-EXEC-01

Complete this checklist before execution:

- [ ] Authorized VirtualBox snapshot is available.
- [ ] WIN-ENDPOINT is online and time synchronized closely enough for correlation.
- [ ] Sysmon service is running and Process Create events are enabled.
- [ ] Wazuh agent is connected and its queue is not flooded.
- [ ] LimaCharlie sensor is online.
- [ ] PowerShell is available and the operator uses an output-only payload.
- [ ] A start timestamp and test ID are recorded before execution.

## Health Gate

Do not begin a high-value test while the Wazuh agent is disconnected, its event queue is flooded, the required service is stopped, or timestamps cannot be correlated. Record any exception in the execution log rather than proceeding silently.

## Evidence Entry Points

- [Safety and baseline screenshots](../../../screenshots/01-safety-and-baseline/)
- [Full test README](README.md)
