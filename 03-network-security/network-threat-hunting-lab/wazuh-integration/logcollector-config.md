# Wazuh Logcollector Configuration

Add a local file entry to `/var/ossec/etc/ossec.conf` on the Wazuh manager or the host that owns the detector output:

```xml
<localfile>
  <location>/var/log/network-recon/network-recon-alerts.json</location>
  <log_format>json</log_format>
</localfile>
```

Create the directory and copy/generate the alert file:

```bash
sudo install -d -o wazuh -g wazuh /var/log/network-recon
sudo cp network-recon-alerts.json /var/log/network-recon/network-recon-alerts.json
```

Depending on the local service account and deployment, ownership may need to match the process writing the file while remaining readable by Wazuh.

Validate and restart:

```bash
sudo /var/ossec/bin/wazuh-analysisd -t
sudo systemctl restart wazuh-manager
sudo systemctl status wazuh-manager --no-pager
```

The custom rule file should be installed under `/var/ossec/etc/rules/` and validated before restart.
