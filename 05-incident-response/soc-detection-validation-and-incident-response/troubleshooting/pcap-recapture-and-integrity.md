# PCAP Recapture and Integrity

## Failure 1 — Missing File

`capinfos` and `sha256sum` against the expected initial path returned file-not-found, and a filesystem search did not locate the incident PCAP.

## Failure 2 — Empty Recapture

An early recapture command ended with zero packets captured and created a 24-byte PCAP. Its SHA-256 began with `704e5e5b...`. This file was not suitable as incident evidence.

## Corrective Action

1. Created `~/P1-INC01-R1-recapture/{capture,zeek,suricata,logs}`.
2. Created and locally validated `/var/www/html/p1-inc01-safe.txt`.
3. Confirmed `HTTP/1.1 200 OK` from Nginx.
4. Captured traffic using a filter for both authorized hosts.
5. Re-ran the controlled traffic.
6. Ended with 5,246 packets, zero kernel drops, and an approximately 4.2 MB capture.
7. Recorded `capinfos`, SHA-1, and SHA-256.

## Final SHA-256

`eb892a293b7cbcb1d4032fb7326e13633256f410a8b19933d12c9ac70c6e183c`

## Excluded Screenshots

Four screenshots showing the obsolete initial/empty-capture workflow were excluded from the GitHub evidence package. The final metadata and independent SHA-256 confirmation are the authoritative PCAP screenshots.
