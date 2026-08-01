# Prerequisites — P4-DISC-02

Complete this checklist before execution:

- [ ] Atomic Red Team module and reviewed T1016 test definitions are available when Atomic execution is used.
- [ ] WIN-ENDPOINT, Sysmon, Wazuh agent, and LimaCharlie are healthy.
- [ ] PowerShell transcript or process logging is enabled as required.
- [ ] The selected commands are read-only and local.
- [ ] The operator records start/end timestamps and avoids external targets.

## Health Gate

Do not begin a high-value test while the Wazuh agent is disconnected, its event queue is flooded, the required service is stopped, or timestamps cannot be correlated. Record any exception in the execution log rather than proceeding silently.

## Evidence Entry Points

- [Safety and baseline screenshots](../../../screenshots/01-safety-and-baseline/)
- [Full test README](README.md)
