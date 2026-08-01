# Prerequisites — P4-FILE-01

Complete this checklist before execution:

- [ ] Nginx is active and listening on the DMZ server.
- [ ] HTTP from USER_NET to the DMZ is allowed by pfSense.
- [ ] Sysmon and Wazuh agent are healthy.
- [ ] Zeek processing is available for the relevant capture/log source.
- [ ] The test artifact contains only a harmless marker.
- [ ] The server and client paths are known and writable.

## Health Gate

Do not begin a high-value test while the Wazuh agent is disconnected, its event queue is flooded, the required service is stopped, or timestamps cannot be correlated. Record any exception in the execution log rather than proceeding silently.

## Evidence Entry Points

- [Safety and baseline screenshots](../../../screenshots/01-safety-and-baseline/)
- [Full test README](README.md)
