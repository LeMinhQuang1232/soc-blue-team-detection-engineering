# Host-Discovery Detection

## Logic

A source contacting at least five unique destination hosts in a 30-second window triggers `multi_host_discovery` and can be classified as `probable_host_discovery`.

## Validation

The ICMP dataset contacted six DMZ addresses. The base weight produced 25 Low; the tuned weight produced 35 Medium. Suricata SID `1000004` independently confirmed the ICMP sweep.

## False-Positive Considerations

Network inventory, monitoring, ARP/ICMP health checks, and configuration-management systems may contact many hosts legitimately.
