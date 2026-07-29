# Lab Environment

## Platforms and Tools

| Component | Value |
|---|---|
| Hypervisor | Oracle VirtualBox |
| Firewall | pfSense 2.8.1-RELEASE |
| Sensor/server | Ubuntu DMZ, hostname `SOC-WAZUH` |
| Sensor interface | `enp0s3` |
| Zeek | 8.0.9 |
| ZeekControl | 2.6.0-31 |
| Suricata | 8.0.6 RELEASE |
| SIEM | Wazuh all-in-one lab |
| Packet analysis | Wireshark and tcpdump |
| Traffic source | Windows USER endpoint with Nmap and PowerShell/curl |
| Python | Python 3 with PyYAML 6.x |
| Time zone | Asia/Ho_Chi_Minh (`UTC+07:00`) |

## Network Segments

| Segment | Subnet | Purpose |
|---|---|---|
| USER_NET | `192.168.10.0/24` | Controlled user and traffic-generation role |
| DMZ_NET | `192.168.20.0/24` | Nginx, Zeek/Suricata analysis, and target services |
| SOC_ADMIN | `192.168.30.0/24` | Administrative validation role |

## Collection Commands

The project used scenario-specific capture directories and the same base capture pattern:

```bash
sudo timeout --signal=INT 90 tcpdump \
  -i enp0s3 -nn -s 0 -U \
  -w capture.pcap \
  'host 192.168.10.10 and host 192.168.20.10'
```

Offline Zeek processing:

```bash
mkdir -p zeek-logs
cd zeek-logs
zeek -C -r ../capture.pcap ../../../zeek/local.zeek
```

Offline Suricata processing:

```bash
mkdir -p suricata-output
sudo suricata -k none \
  -r capture.pcap \
  -c /etc/suricata/suricata.yaml \
  -S ../../../suricata/local.rules \
  -l suricata-output
```
