# Network Security Projects

This category contains self-contained projects focused on firewall policy, segmentation, packet analysis, network detection, threat hunting, and infrastructure monitoring.

| Project | Scope | Status |
|---|---|---|
| [Firewall, IDS, and Monitoring Lab](firewall-ids-monitoring-lab/) | pfSense segmentation, Suricata IDS, Prometheus, Grafana, incident analysis | Completed with documented lab limitations |
| [Zeek-Suricata Network Threat Hunting and Reconnaissance Detection](network-threat-hunting-lab/) | PCAP collection, Wireshark, Zeek metadata, Suricata correlation, Python risk scoring, Wazuh integration | Phase 1 completed |

## How the Projects Connect

The firewall/IDS project created the segmented USER, DMZ, and SOC_ADMIN environment. The threat-hunting project reuses that topology and adds repeatable PCAP investigations, behavior aggregation, and SIEM alerting. Together they demonstrate both preventive policy and detective analysis.
