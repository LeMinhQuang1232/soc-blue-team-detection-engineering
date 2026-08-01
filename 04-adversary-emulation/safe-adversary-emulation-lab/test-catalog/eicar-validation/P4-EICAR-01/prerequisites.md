# Prerequisites — P4-EICAR-01

Complete this checklist before execution:

- [ ] A recoverable VM snapshot exists.
- [ ] Microsoft Defender and real-time protection are enabled.
- [ ] The Defender Operational event channel is accessible.
- [ ] Wazuh agent is connected and configured to collect Defender events.
- [ ] The Wazuh agent queue is healthy enough for a high-value test.
- [ ] The designated temporary lab directory exists.
- [ ] The operator has an approved EICAR procedure and will not commit the literal.

## Health Gate

Do not begin a high-value test while the Wazuh agent is disconnected, its event queue is flooded, the required service is stopped, or timestamps cannot be correlated. Record any exception in the execution log rather than proceeding silently.

## Evidence Entry Points

- [Safety and baseline screenshots](../../../screenshots/01-safety-and-baseline/)
- [Full test README](README.md)
