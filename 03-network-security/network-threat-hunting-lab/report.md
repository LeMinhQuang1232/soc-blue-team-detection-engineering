# Technical Report — Zeek-Suricata Network Threat Hunting and Reconnaissance Detection

## Executive Summary

This project added behavioral network-threat-hunting capability to an existing segmented SOC lab. The previous network project already provided pfSense policy enforcement, an Ubuntu DMZ server, Nginx, Suricata, and Wazuh. This will extended that environment with Zeek JSON logs, controlled PCAP datasets, Wireshark validation, a Python aggregation and scoring engine, and Wazuh ingestion of structured reconnaissance alerts.

Five datasets were analyzed: normal web traffic, ICMP host discovery, administrative-service probing, HTTP path probing, and a TCP SYN scan. The strongest validation was the final SYN-scan dataset. A single source, `192.168.10.10`, generated 200 captured SYN packets against `192.168.20.10`, targeting 100 unique destination ports. Zeek produced 200 `S0` connection records, Suricata generated 195 alerts for local SID `1000003` revision `2`, the Python detector produced a Medium-risk `probable_port_scan` event with score `50`, and Wazuh matched rule `100201` at level `7`.

The project demonstrates that signature-based and behavior-based telemetry are complementary. Suricata provided fast confirmation when a known local pattern was matched, while Zeek retained connection metadata even when no dedicated signature existed. The Python layer aggregated otherwise low-context events over a 30-second window and converted them into an analyst-friendly alert.

## 1. Project Objectives

The project was designed to answer the following questions:

1. Can reconnaissance be identified from aggregated behavior rather than one packet at a time?
2. Can the same activity be validated independently in PCAP, Wireshark, Zeek, Suricata, Python, and Wazuh?
3. Can normal traffic be retained as a negative control without generating an alert?
4. Can thresholds be adjusted without changing detector source code?
5. Can the final output be documented and reproduced by another analyst?

## 2. Scope

### Included

- Offline PCAP collection and analysis.
- Zeek JSON `conn.log` and `http.log` generation.
- Suricata offline analysis using local reconnaissance signatures.
- Wireshark packet-list and packet-detail validation.
- Python parsing, 30-second aggregation, risk scoring, and JSON Lines output.
- Wazuh JSON decoding and risk-level child rules.
- Baseline, host-discovery, port-scan, service-probing, HTTP-probing, and failed-connection analysis.
- Threshold tuning, false-positive discussion, troubleshooting, and evidence indexing.

### Excluded

- Internet-facing or unauthorized scanning.
- Malware execution.
- Suricata inline IPS deployment.
- Automatic blocking or endpoint containment.
- Production-scale performance testing.
- Machine-learning detection.

## 3. Lab Architecture

| Component | Address / role | Function in this project |
|---|---|---|
| Windows USER | `192.168.10.10` | Controlled traffic source |
| pfSense USER gateway | `192.168.10.1` | Routes and enforces USER policy |
| Ubuntu DMZ | `192.168.20.10` | Nginx target, Zeek/Suricata analysis host |
| pfSense DMZ gateway | `192.168.20.1` | DMZ routing and policy boundary |
| SOC_ADMIN role | `192.168.30.10` | Administrative comparison role |
| Wazuh | Existing SOC server services | Ingests Python JSON alerts |

The logical analysis flow was:

```text
Controlled traffic
      ↓
pfSense policy and packet path
      ↓
tcpdump PCAP
      ├── Wireshark packet validation
      ├── Zeek connection/application metadata
      └── Suricata signature evaluation
                    ↓
             Python aggregation
                    ↓
              JSON alert file
                    ↓
                  Wazuh
```

## 4. Data Sources

### 4.1 Packet capture

Each scenario contains a small `capture.pcap` and a SHA-256 hash. PCAP is the primary packet-level evidence and permits independent re-analysis.

### 4.2 Zeek

Zeek was configured to emit JSON. The project primarily used:

- `conn.log`: source/destination, ports, protocol, connection state, duration, packet/byte counts.
- `http.log`: method, host, URI, status code, and related HTTP metadata.
- `packet_filter.log`: capture-filter context.
- `reporter.log`: warnings, including the expected filtered-trace warning for the SYN-only capture.

### 4.3 Suricata

Suricata evaluated PCAPs against local rules and produced:

- `eve.json`: structured alert and flow events.
- `fast.log`: concise alert evidence.
- `stats.log` and `suricata.log`: engine and processing context.

### 4.4 Firewall logs

pfSense logs were used to confirm whether traffic crossed the expected policy boundary and to distinguish network-policy behavior from host-level behavior.

### 4.5 Python detector

The detector read Zeek JSON Lines, grouped events by `source_ip` and a 30-second tumbling window, computed metrics, applied configurable weights, selected a primary classification, and emitted JSON Lines.

### 4.6 Wazuh

Wazuh monitored the detector output file. A level-0 parent rule verified the event type, while child rules mapped Medium, High, and Critical risk levels to Wazuh levels 7, 10, and 12.

## 5. Detection Design

### 5.1 Aggregated metrics

For each source and time window, the detector calculates:

- Unique destination ports.
- Unique destination hosts.
- Failed connections.
- Administrative-service attempts to ports `22`, `445`, and `3389`.
- Unique HTTP URIs.

### 5.2 Base thresholds

| Metric | Threshold |
|---|---:|
| Medium unique-port count | 10 |
| High unique-port count | 25 |
| Unique destination hosts | 5 |
| Failed connections | 10 |
| Administrative-service attempts | 3 |
| Unique HTTP URIs | 8 |
| Minimum alert score | 30 |
| Time window | 30 seconds |

### 5.3 Base weights

| Signal | Weight |
|---|---:|
| 10–24 unique ports | 20 |
| 25+ unique ports | 30 |
| 5+ destination hosts | 25 |
| 10+ failed connections | 20 |
| 3+ administrative-service attempts | 15 |
| 8+ unique HTTP URIs | 20 |

Scores are capped at 100. Risk levels are `Low` 0–29, `Medium` 30–59, `High` 60–79, and `Critical` 80–100.

### 5.4 Classification priority

When more than one condition is true, the detector assigns one primary classification in this order:

1. `probable_http_enumeration`
2. `probable_host_discovery`
3. `probable_port_scan`
4. `probable_admin_service_probing`
5. `probable_failed_connection_burst`
6. `baseline_or_low_activity`

The full `signals` array preserves secondary reasons for the score.

## 6. Scenario Results

### 6.1 Baseline Web Traffic

**Purpose:** establish a negative control for ordinary HTTP activity.

**Observed evidence:**

- 37 packets over approximately 81.22 seconds.
- Four successful Zeek connection records.
- One destination host and one destination port.
- Three unique URIs distributed across windows.
- Successful `SF` connection states.

**Detector outcome:** base and tuned score `0`, classification `baseline_or_low_activity`, no alert entries because the score was below the configured minimum.

**Conclusion:** the detector did not classify ordinary web traffic as reconnaissance. This result is important because positive detections are not meaningful without a negative control.

### 6.2 ICMP Host Discovery

**Purpose:** identify a source contacting multiple hosts with ICMP echo requests.

**Observed evidence:**

- 12 packets captured in approximately 0.045 seconds.
- Six unique destination hosts.
- Zeek represented the activity as `OTH` connection metadata.
- pfSense showed the traffic crossing the expected network boundary.
- Suricata generated local SID `1000004`, `LOCAL P2 ICMP host discovery sweep`.

**Detector outcome:** base score `25` Low; tuned score `35` Medium; primary classification `probable_host_discovery`.

**Conclusion:** host diversity was the decisive feature. The base profile recorded the behavior but did not emit an alert at the 30-point minimum. The tuned profile raised the host-discovery weight and produced an actionable Medium event.

### 6.3 Administrative-Service Probing

**Purpose:** identify repeated attempts against common administrative services.

**Observed evidence:**

- 18 packets over approximately 3.02 seconds.
- Six destination ports.
- Twelve failed Zeek connections: ten `S0` and two `RSTO` records.
- Six attempts to configured administrative ports.
- Firewall evidence confirmed controlled probing across the USER-to-DMZ path.

**Detector outcome:** base score `35` Medium; tuned score `55` Medium; classification `probable_admin_service_probing`.

**Conclusion:** this scenario demonstrates why Zeek metadata remains useful without a dedicated Suricata signature. The combined failed-connection and administrative-port context was enough for the behavior detector to produce an alert.

### 6.4 HTTP Path Probing

**Purpose:** detect rapid requests to many different application paths.

**Observed evidence:**

- 86 packets over approximately 3.71 seconds.
- Nine unique URIs: `/`, `/admin`, `/api`, `/backup`, `/login`, `/not-found`, `/phpmyadmin`, `/robots.txt`, and `/server-status`.
- Zeek `http.log` preserved URI and response metadata.
- Suricata generated local SID `1000006`, `LOCAL P2 HTTP enumeration burst`.

**Detector outcome:** base score `20` Low; tuned score `35` Medium; classification `probable_http_enumeration`.

**Conclusion:** the base configuration recorded the HTTP enumeration signal but did not cross the alert threshold. Tuning increased the HTTP weight to make the burst actionable. Checksum-offload messages in the Suricata output were treated as analysis noise and filtered from the custom-alert evidence.

### 6.5 Final TCP SYN Scan

**Purpose:** validate a multi-port SYN scan through every analysis layer.

**Observed evidence:**

- PCAP SHA-256: `9e11b256d17567bfb9920b4e96e73771282ce1eb6e071782757da9d735c5f7b0`.
- 200 packets over approximately 1.862 seconds.
- Source `192.168.10.10`; target `192.168.20.10`.
- 100 unique destination ports, ports 1 through 100.
- TCP flags showed SYN requests without completed handshakes in the filtered trace.
- Zeek generated 200 connection records, all `S0`.
- Two attempts matched the administrative-port list.
- Suricata generated 195 alerts for SID `1000003`, revision `2`, signature `LOCAL P2 TCP SYN Scan`.
- First local Suricata alert: `2026-07-28T10:53:34.038465+0700`.
- Last local Suricata alert: `2026-07-28T10:53:35.893161+0700`.

**Base detector output:**

```json
{
  "source_ip": "192.168.10.10",
  "unique_destination_ports": 100,
  "failed_connections": 200,
  "admin_service_attempts": 2,
  "risk_score": 50,
  "risk_level": "Medium",
  "classification": "probable_port_scan",
  "signals": [
    "high_unique_port_count",
    "high_failed_connection_count"
  ]
}
```

**Tuned detector outcome:** score `80`, Critical.

**Wazuh outcome:** the validated base JSON event matched rule `100201`, level `7`. Expanded dashboard fields showed the source, classification, score, risk level, port count, and failed-connection count.

**Conclusion:** the final dataset completed the required end-to-end chain. Packet evidence proves what occurred, Zeek provides normalized behavior metadata, Suricata confirms the local scan signature, Python contextualizes the burst, and Wazuh exposes the result for analyst triage.

## 7. Zeek and Suricata Correlation

| Question | Zeek contribution | Suricata contribution |
|---|---|---|
| Which source contacted which target? | Connection metadata for every observed event | Alert source/destination fields when a rule matches |
| How many ports or hosts were involved? | Straightforward aggregation across `conn.log` | Not the primary purpose of one alert record |
| Was a known local scan pattern matched? | Behavior must be queried or aggregated | Immediate signature alert |
| What happened without a dedicated signature? | Metadata remains available | May produce no alert |
| Can an analyst investigate application paths? | `http.log` URI/status context | HTTP signature or burst alert |

The two tools were not treated as competitors. Zeek supplied broad telemetry for hunting and correlation; Suricata supplied high-confidence signature evidence.

## 8. Wazuh Integration

The Python output was written as one JSON object per line. Wazuh monitored that file using `log_format` set to `json`. The rule chain was:

| Rule | Wazuh level | Purpose |
|---|---:|---|
| `100200` | 0 | Parent event-type match |
| `100201` | 7 | Medium network reconnaissance |
| `100202` | 10 | High network reconnaissance |
| `100203` | 12 | Critical network reconnaissance |

The final base-profile SYN scan intentionally produced a Medium event and therefore matched `100201`. The tuned profile is retained for comparison, but the public Wazuh evidence accurately reflects the base score of 50 rather than claiming a Critical alert that was not the ingested event.

## 9. Threshold Tuning Analysis

The tuning profile keeps the same thresholds but increases selected weights. This allows comparison of sensitivity without changing parsing or classification logic.

| Scenario | Base | Tuned | Interpretation |
|---|---:|---:|---|
| Baseline web | 0 Low | 0 Low | Stable negative control |
| ICMP sweep | 25 Low | 35 Medium | Tuned host-discovery alert |
| Service probing | 35 Medium | 55 Medium | Greater confidence, same risk band |
| HTTP path probing | 20 Low | 35 Medium | Tuned HTTP-enumeration alert |
| TCP SYN scan | 50 Medium | 80 Critical | Large sensitivity increase |

The tuned profile is useful for a small lab, but it should not automatically replace the base profile in a production network. Normal vulnerability scanning, monitoring, service discovery, or automated web checks could create similar counts. Production tuning requires asset roles, allowlists, scanner identity, historical baselines, and separate thresholds for internal management systems.

## 10. False-Positive Analysis

Potential benign causes include:

- Authorized vulnerability scanners contacting many ports.
- Monitoring platforms checking multiple hosts or services.
- Configuration-management systems using SSH, SMB, or RDP.
- Web health checks or crawler jobs requesting many paths.
- Troubleshooting tools generating repeated failed connections.
- Backup or inventory systems contacting administrative services.

Recommended controls:

1. Allowlist approved scanners by source address and maintenance window.
2. Separate server, user, management, and scanner baselines.
3. Require corroboration such as failure ratio, unexpected source role, firewall deny events, or Suricata signature.
4. Tune URI thresholds by application type.
5. Suppress repeated alerts for the same source and window while retaining raw telemetry.
6. Review changes in behavior rather than relying only on absolute counts.

## 11. Troubleshooting Summary

The project retained real implementation failures because they demonstrate the validation method:

- The expected SYN-scan PCAP path initially did not exist; file discovery showed only an obsolete one-port capture. A new final capture was generated and the old PCAP was excluded from the public package.
- Zeek warned that the final trace contained TCP control packets only. This was expected because the PCAP was deliberately filtered to SYN traffic; the warning was documented instead of hidden.
- Suricata rule files temporarily contained obsolete or duplicate scan-rule revisions. The public rule set was normalized to SID `1000003`, rev `2`, matching the final live evidence.
- HTTP offline analysis included checksum-offload warnings. Custom alert records were filtered by signature/SID rather than counting engine noise.
- Wazuh integration required JSON decoding, a level-0 parent, child rules, file monitoring, service restart, and dashboard verification.
- The raw technical ZIP contained `.venv`, `__pycache__`, and obsolete files. These were excluded from the GitHub package.

Full command-level details are in [`troubleshooting.md`](troubleshooting.md).

## 12. Security and Evidence Handling

- All activity occurred in an isolated, authorized VirtualBox lab.
- No real passwords, tokens, private keys, or public target addresses are included.
- PCAPs are intentionally small and hashed for integrity verification.
- Virtual disks, VM exports, temporary environments, and repository ZIPs are excluded.
- Raw logs are preserved when useful for independent validation.
- Evidence names are stable and mapped in the screenshot index.

## 13. Limitations

- Small lab topology and limited host diversity.
- One principal source IP in the datasets.
- Fixed tumbling windows rather than overlapping/sliding windows.
- No source-role enrichment inside the detector.
- No direct Suricata or firewall-event input to the risk score.
- No automatic response.
- SYN-only capture was pre-filtered and therefore cannot show complete TCP sessions.
- Suricata alert volume reflects per-packet rule behavior after the threshold is crossed, not 195 separate incidents.

## 14. Lessons Learned

1. A packet-level fact and an incident-level conclusion are different products.
2. Zeek metadata is valuable even when no signature fires.
3. Suricata alerts gain meaning when correlated with connection counts and role context.
4. Negative controls are required to demonstrate detection quality.
5. Threshold weights can change severity dramatically without changing the underlying traffic.
6. Repository hygiene is part of security engineering; evidence should be reproducible without publishing transient or sensitive files.
7. A credible report must distinguish validated evidence, tuned comparison results, and unimplemented capabilities.

## 15. Final Assessment

The repository contains more than three reconnaissance scenarios, baseline and reconnaissance PCAPs, Zeek and Suricata outputs, Wireshark evidence, a configurable Python detector, Wazuh integration, tuning analysis, false-positive analysis, and a full incident report. The final TCP SYN activity can be independently traced through all required layers.
