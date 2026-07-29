# Troubleshooting Record

This document records implementation problems encountered during Phase 1 and the evidence-based method used to resolve them.

## 1. Expected TCP SYN PCAP Was Missing

### Symptom

A path variable pointed to:

```text
/home/quang-le/P2-network-visibility/pcap-investigations/tcp-syn-scan/capture.pcap
```

but `ls` returned `No such file or directory`.

### Investigation

```bash
find "$HOME" -type f \( -name "capture.pcap" -o -name "*.pcap" -o -name "*.pcapng" \) 2>/dev/null
```

The result showed other scenario PCAPs and only:

```text
tcp-syn-scan/capture-old-one-port.pcap
```

### Root cause

The final multi-port capture had not yet been created. The existing file represented an obsolete one-port test and could not support the required 100-port validation.

### Resolution

A new controlled SYN scan was captured as `tcp-syn-scan/capture.pcap`. The final file contains 200 packets and 100 unique destination ports. Its SHA-256 hash is retained in `capture.sha256`. The obsolete one-port PCAP is excluded from the public repository.

## 2. Zeek Filtered-Trace Warning

### Symptom

Offline analysis produced:

```text
The analyzed trace file was determined to contain only TCP control packets,
which may indicate it has been pre-filtered.
```

### Root cause

The final PCAP was intentionally captured with a SYN-oriented filter. It did not contain complete application sessions or all segments that would normally appear in an unfiltered trace.

### Resolution

No parser failure existed. The warning was preserved in `reporter.log` and documented as a limitation. Zeek `conn.log` still provided the required source, target, ports, and `S0` connection states.

### Analyst lesson

Do not suppress a warning merely to make output look clean. Determine whether it represents corruption, an incorrect capture point, or an intentional collection decision.

## 3. Suricata TCP Rule Revision Did Not Match Final Evidence

### Symptom

Earlier working files contained different or duplicate TCP scan rule versions, while the final screenshot showed:

```text
LOCAL P2 TCP SYN Scan
sid:1000003
rev:2
```

### Risk

Publishing a rule that differs from the live validation evidence would make the repository internally inconsistent and reduce trust.

### Resolution

The public `suricata/local.rules` was normalized to:

```suricata
alert tcp 192.168.10.0/24 any -> 192.168.20.10 any \
(msg:"LOCAL P2 TCP SYN Scan"; flags:S; flow:stateless; \
detection_filter:track by_src, count 5, seconds 60; \
classtype:network-scan; sid:1000003; rev:2;)
```

Obsolete duplicate SIDs/revisions were removed from the public package.

## 4. Suricata HTTP Output Contained Checksum Noise

### Symptom

Offline PCAP analysis produced checksum-related messages in addition to the expected custom HTTP alert.

### Root cause

Virtualized or host-offloaded packet captures can contain checksums that are calculated after capture. Offline IDS engines may report these as invalid even though the original traffic was processed normally.

### Resolution

The analysis filtered custom alerts by SID/signature and treated checksum messages as engine/capture context rather than HTTP-enumeration detections.

Example:

```bash
jq -c 'select(.event_type=="alert" and .alert.signature_id==1000006)' eve.json
```

## 5. Base Profile Did Not Alert on ICMP or HTTP Probing

### Symptom

The parser correctly measured six destination hosts and nine URIs, but the base scores were 25 and 20, below `minimum_alert_score: 30`.

### Root cause

The detector was functioning as configured. The initial weights recorded the behavior as Low rather than emitting a Medium alert.

### Resolution

A separate `config-tuned.yaml` increased host-discovery and HTTP-enumeration weights to 35. The source code and thresholds remained unchanged, allowing transparent comparison between profiles.

### Analyst lesson

A missed alert can be a threshold-design issue rather than a collection or parsing failure. Validate raw metrics before changing code.

## 6. Wazuh JSON Event Did Not Immediately Appear

### Required checks

1. Confirm the detector output is valid one-object-per-line JSON.
2. Validate decoding with `wazuh-logtest`.
3. Confirm the monitored path in `<localfile>`.
4. Confirm `log_format` is `json`.
5. Validate the custom rule XML.
6. Restart `wazuh-manager` after configuration changes.
7. Query by custom rule ID or group.

Useful commands:

```bash
sudo /var/ossec/bin/wazuh-logtest
sudo /var/ossec/bin/wazuh-analysisd -t
sudo systemctl restart wazuh-manager
sudo systemctl status wazuh-manager --no-pager
```

### Final result

The parent rule decoded the event and Medium child rule `100201` fired at Wazuh level 7. The dashboard showed five matching events during validation, and the expanded alert contained the detector fields.

## 7. Detector Output Timezone

### Symptom

Unix timestamps could render differently depending on the analysis host timezone.

### Resolution

The detector converts timestamps from UTC and then uses the host timezone. Reproduction commands set:

```bash
TZ=Asia/Ho_Chi_Minh
```

This makes the `+07:00` evidence consistent with the lab clock.

## 8. Public ZIP Contained Transient Python Files

### Symptom

The source archive contained a full `.venv`, `__pycache__`, compiled Python files, and other temporary artifacts.

### Risk

- Very large repository.
- Platform-specific files.
- No review value.
- Greater chance of accidental secret or cache publication.

### Resolution

The public package excludes:

```text
.venv/
__pycache__/
*.pyc
*.pyo
capture-old-one-port.pcap
*.zip
```

A project `.gitignore` enforces the same rule locally.

## 9. Scenario Naming Inconsistency

### Symptom

An earlier working directory used `http-enumeration`, while the final portfolio convention used `http-path-probing`.

### Resolution

The public folder and documentation consistently use:

```text
pcap-investigations/http-path-probing/
```

The detector classification remains `probable_http_enumeration` because it describes the behavior rather than the folder name.

## 10. Validation Method Used Throughout

For every issue, the troubleshooting sequence was:

1. Verify file existence and exact path.
2. Verify packet evidence before relying on higher-level logs.
3. Validate Zeek/Suricata syntax and output independently.
4. Inspect metrics before changing thresholds.
5. Compare configuration files with screenshots and live output.
6. Retest after one change at a time.
7. Preserve the limitation or failed attempt in documentation.
