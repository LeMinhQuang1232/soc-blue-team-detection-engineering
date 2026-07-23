# Suricata Troubleshooting

## Initial service problem

The service log showed `af-packet: eth0: failed to find interface`. Ubuntu used predictable interface naming, so the DMZ interface was not `eth0`.

## Correction

1. Confirm the actual interface:

```bash
ip -br address
ip route
```

2. Update the AF_PACKET interface in `/etc/suricata/suricata.yaml` to the DMZ NIC.
3. Set `HOME_NET` to `192.168.20.0/24`.
4. Ensure the local rule file is referenced.
5. Run a configuration test before restarting:

```bash
sudo suricata -T -c /etc/suricata/suricata.yaml -v
```

6. Restart and verify:

```bash
sudo systemctl restart suricata
sudo systemctl status suricata --no-pager
```

![Initial error](../../08-dashboards-screenshots/suricata/02-suricata-initial-interface-error.png)

![Successful validation](../../08-dashboards-screenshots/suricata/06-suricata-config-validation.png)

## Rule-file warning

The initial log also indicated that no rule files matched. The final configuration loaded `/var/lib/suricata/rules/local.rules`, and the resulting LOCAL alerts confirm the rule path was corrected.
