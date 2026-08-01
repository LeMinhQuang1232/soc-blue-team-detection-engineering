# Prerequisites — P4-NET-01

Complete this checklist before execution:

- [ ] pfSense rules and logging are active.
- [ ] The authorized source and target addresses are confirmed.
- [ ] tcpdump/PCAP capture and Zeek processing are available.
- [ ] The Python detector environment and configuration are known-good.
- [ ] Wazuh ingestion/rules for detector JSON are active.
- [ ] Suricata configuration validates successfully.
- [ ] A run-specific timestamp, capture path, and EVE output strategy are defined.

## Health Gate

Do not begin a high-value test while the Wazuh agent is disconnected, its event queue is flooded, the required service is stopped, or timestamps cannot be correlated. Record any exception in the execution log rather than proceeding silently.

## Evidence Entry Points

- [Safety and baseline screenshots](../../../screenshots/01-safety-and-baseline/)
- [Full test README](README.md)
