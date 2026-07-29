# Reused Assets

Phase 1 reused the previously completed firewall, IDS, and monitoring foundation rather than rebuilding the network.

| Existing asset | Reuse in this project |
|---|---|
| pfSense segmentation | Preserved USER, DMZ, and SOC_ADMIN trust zones |
| USER endpoint | Generated controlled reconnaissance traffic |
| Ubuntu DMZ | Hosted Nginx and performed packet/log analysis |
| Nginx | Provided normal and enumerated HTTP paths |
| Suricata | Extended signature detection with reconnaissance rules |
| Wazuh | Ingested Python JSON alerts and exposed them in Threat Hunting |
| Firewall logs | Confirmed policy outcomes for administrative service probing |

The main additions were Zeek JSON logging, scenario PCAPs, Wireshark analysis, the Python detector, risk tuning, and Wazuh JSON integration.
