# Setup Notes

## Wazuh deployment

| Field | Value |
|---|---|
| Deployment type | All-in-one |
| Server hostname | SOC-WAZUH |
| Server operating system | Ubuntu 24.04.4 LTS |
| Wazuh version | 4.14.6 |
| Dashboard address | `https://192.168.56.10` |
| Components | Manager, indexer, dashboard, Filebeat |

## Confirmed services

- `wazuh-manager`: Active
- `wazuh-indexer`: Active
- `wazuh-dashboard`: Active
- `filebeat`: Active

## Confirmed listening ports

- TCP 443: Wazuh dashboard
- TCP 1514: Agent event communication
- TCP 1515: Agent enrollment
- TCP 55000: Wazuh API

## Additional services

- OpenSSH was used for authentication testing.
- Nginx was used to generate web access logs.

## Security note

The installer screenshots that displayed the generated Wazuh administrator password are not included in this repository.
