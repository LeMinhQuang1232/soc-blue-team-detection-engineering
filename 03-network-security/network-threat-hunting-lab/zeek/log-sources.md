# Zeek Log Sources

| Log | Important fields | Threat-hunting use |
|---|---|---|
| `conn.log` | `ts`, `id.orig_h`, `id.resp_h`, `id.resp_p`, `proto`, `conn_state`, packet/byte counts | Port scans, host discovery, failed bursts, service probing |
| `http.log` | source/destination, method, host, URI, status code, user agent | Path enumeration and application-layer context |
| `files.log` | file identifiers, MIME type, source | File-transfer context when present |
| `packet_filter.log` | active capture filter | Explains collection scope |
| `reporter.log` | warnings/errors | Detects filtered traces, parser warnings, or analysis problems |

## Connection States Used by the Detector

The failed-state set is configurable and currently includes:

```text
S0, REJ, RSTO, RSTR, SH, SHR
```

`S0` is particularly important in the final scan because Zeek observed connection attempts without a reply completing the handshake.
