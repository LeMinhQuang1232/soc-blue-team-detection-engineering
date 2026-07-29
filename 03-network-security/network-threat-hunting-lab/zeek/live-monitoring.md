# Zeek Live Monitoring Notes

Offline PCAP analysis was selected as the primary method because it is reproducible and easy to review on GitHub. Live monitoring remains supported by the same JSON configuration.

## Interface Selection

Identify the interface that observes DMZ traffic:

```bash
ip -br address
ip route
```

Update the Zeek node configuration with the verified interface rather than assuming a name such as `eth0` or `enp0s3`.

## Deploy and Verify

```bash
sudo zeekctl check
sudo zeekctl deploy
sudo zeekctl status
sudo tail -f /opt/zeek/logs/current/conn.log
```

## Operational Caution

A host-based Zeek sensor sees only traffic available at that interface/capture point. Switched traffic not addressed to the sensor may require a TAP, SPAN/mirror port, bridge, or monitoring at the gateway.
