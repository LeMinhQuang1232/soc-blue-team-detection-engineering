# Suricata Validation Tests

| ID | Test | Expected | Status |
|---|---|---|---|
| W5-IDS-01 | Identify actual capture interface | DMZ NIC found | Passed |
| W5-IDS-02 | `suricata -T` configuration validation | Successful completion | Passed |
| W5-IDS-03 | Service starts after correction | Active/running | Passed |
| W5-IDS-04 | SQLi test request | SID 1000001 | Passed |
| W5-IDS-05 | XSS test request | SID 1000002 | Passed |
| W5-IDS-06 | SYN scan test | SID 1000003 | Passed |
| W5-IDS-07 | EVE JSON contains structured fields | Alert objects visible | Passed |

