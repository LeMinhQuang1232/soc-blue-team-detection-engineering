# Lab Architecture

## Diagram

```text
                    Oracle VirtualBox Host
                  Host-Only: 192.168.56.1/24
                           DHCP disabled
                              |
             +----------------+----------------+
             |                                 |
      SOC-WAZUH                          WIN-ENDPOINT
      Ubuntu 24.04.4 LTS                 Windows Server 2022
      192.168.56.10                      192.168.56.20
      NAT: 10.0.2.15                     NAT: 10.0.2.15
             |                                 |
      - Wazuh manager                    - Wazuh agent 001
      - Wazuh indexer                    - Sysmon64
      - Wazuh dashboard                  - Windows Security Log
      - Filebeat
      - OpenSSH
      - Nginx
```

## Main traffic paths

| Source | Destination | Port | Purpose |
|---|---|---:|---|
| Windows | Ubuntu | TCP 443 | Access the Wazuh dashboard |
| Windows agent | Wazuh manager | TCP 1514 | Send agent events |
| Windows agent | Wazuh manager | TCP 1515 | Agent enrollment |
| Windows | Ubuntu | TCP 22 | SSH authentication tests |
| Windows | Ubuntu | TCP 80 | Nginx HTTP tests |
| Wazuh dashboard | Local Wazuh API | TCP 55000 | Dashboard and API communication |

The Host-Only network was used for stable lab addresses. NAT was used only for internet access.
