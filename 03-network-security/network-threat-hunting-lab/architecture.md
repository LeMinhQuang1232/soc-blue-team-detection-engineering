# Architecture

## Detection Pipeline

```mermaid
flowchart TB
    A["Controlled traffic generation\nWindows USER 192.168.10.10"]
    B["pfSense policy enforcement"]
    C["Ubuntu DMZ sensor\n192.168.20.10 / enp0s3"]
    D["PCAP collection\ntcpdump"]
    E["Wireshark\npacket-level evidence"]
    F["Zeek JSON logs\nconn.log / http.log"]
    G["Suricata\nfast.log / eve.json"]
    H["Python detector\nsource + 30-second window"]
    I["JSON Lines alert file"]
    J["Wazuh logcollector"]
    K["Wazuh rules 100200-100203"]
    L["Threat Hunting dashboard"]

    A --> B --> C --> D
    D --> E
    D --> F --> H
    D --> G
    H --> I --> J --> K --> L
```

## Design Rationale

- **PCAP** provides the ground truth needed to validate flags, ports, timing, and packet counts.
- **Zeek** converts packets into compact connection and HTTP metadata suitable for behavioral analysis.
- **Suricata** provides deterministic signature-based alerts for selected reconnaissance patterns.
- **Python** aggregates events across a time window and scores behavior that may not match one signature.
- **Wazuh** centralizes the generated alert and exposes it to the analyst through a SIEM workflow.

## Trust Boundaries

| Boundary | Control |
|---|---|
| USER to DMZ | pfSense policy and logged allow/block decisions |
| DMZ host | Ubuntu UFW and service configuration |
| Sensor data | SHA-256 manifests for retained PCAPs |
| Detection output | JSON schema plus Wazuh parent/child rules |
| Public repository | No credentials, VM disks, `.venv`, `__pycache__`, or obsolete PCAPs |
