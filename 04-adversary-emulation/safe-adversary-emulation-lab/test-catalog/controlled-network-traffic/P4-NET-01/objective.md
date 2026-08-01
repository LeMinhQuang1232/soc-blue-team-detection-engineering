# Objective — P4-NET-01

Validate controlled service-discovery visibility across firewall logs, packet/Zeek metadata, the Python reconnaissance detector, and Wazuh while preserving an explicit distinction between a new low-volume run and a replayed regression dataset.

### Success conditions

- Current low-volume traffic is attributable in pfSense and Zeek.
- The new run does not incorrectly trigger or claim a broad-scan result.
- The replay reproduces the documented 100-port/200-failure detector output.
- Wazuh rule `100201` is observed for the replay.
- Suricata uncertainty is reported honestly and the overall status remains `Partial`.

## Scope

- Authorized source: WIN-ENDPOINT (`192.168.10.10`)
- Authorized target: Ubuntu DMZ (`192.168.20.10`)
- Test category: Network validation
- Recorded status: **Partial**

## Evidence Entry Points

- [Full test README and image gallery](README.md)
- [Complete screenshot folder](../../../screenshots/06-network-validation/)
- [Evidence manifest](../../../screenshots/evidence-manifest.csv)
