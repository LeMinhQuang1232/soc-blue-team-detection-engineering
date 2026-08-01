# Lab Architecture

```mermaid
flowchart LR
    WIN["WIN-ENDPOINT<br/>Windows Server 2022<br/>192.168.10.10"]
    PFS["pfSense"]
    DMZ["SOC-WAZUH / Ubuntu DMZ<br/>192.168.20.10"]
    SYS["Sysmon + Security + Defender"]
    LC["LimaCharlie"]
    WAZUH["Wazuh Manager / Indexer / Dashboard"]
    NGINX["Nginx"]
    ZEEK["tcpdump / Zeek"]
    SURI["Suricata"]
    PY["Python Recon Detector"]

    WIN --> SYS
    SYS --> WAZUH
    WIN --> LC
    WIN --> PFS
    PFS --> DMZ
    DMZ --> WAZUH
    DMZ --> NGINX
    DMZ --> ZEEK
    DMZ --> SURI
    ZEEK --> PY
    PY --> WAZUH
```

## Evidence Flow

1. Safe commands run on `WIN-ENDPOINT`.
2. Windows Security, Sysmon, Defender, and LimaCharlie record endpoint activity.
3. Wazuh receives event-channel and custom JSON data.
4. pfSense records network policy decisions.
5. Nginx records controlled HTTP requests.
6. tcpdump captures selected traffic for offline Zeek analysis.
7. Suricata provides signature and stream-alert context.
8. Python aggregates Zeek logs and produces reconnaissance JSON.
9. Wazuh presents the resulting alerts for analyst triage.
