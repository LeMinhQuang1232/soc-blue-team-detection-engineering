# Validation Tests

| Test ID | Test | Expected Result | Actual Result | Status |
|---|---|---|---|---|
| W3-T01 | Sensor appears online | Windows sensor online | `win-endpoint.lan` online | Passed |
| W3-T02 | Sensor service check | Running and Automatic | Running and Automatic | Passed |
| W3-T03 | Safe encoded PowerShell telemetry | Process event recorded | LimaCharlie, Sysmon, and Wazuh evidence recorded | Passed |
| W3-T04 | LimaCharlie encoded-PowerShell D&R alert | Detection card generated | Detection card not present in supplied evidence | Pending Evidence |
| W3-T05 | `whoami /priv` | Reconnaissance detection | Detection visible | Passed |
| W3-T06 | `net user` | Reconnaissance detection | Detection visible | Passed |
| W3-T07 | `net localgroup administrators` | Reconnaissance detection | Detection visible | Passed |
| W3-T08 | `ipconfig /all` | Reconnaissance detection | Detection visible | Passed |
| W3-T09 | Sysmon process correlation | Matching process and parent context | Confirmed | Passed |
| W3-T10 | Wazuh encoded PowerShell alert | High-severity encoded-command alert | Rule `92057`, level 12 | Passed |
| W3-T11 | Benign PowerShell comparison | Lower-severity result | Rule `92027`, level 4 | Passed |
| W3-T12 | Pre-isolation connectivity | Ping and HTTP succeed | Succeeded | Passed |
| W3-T13 | Isolation blocks traffic | Ping and HTTP fail | Failed as expected | Passed |
| W3-T14 | Isolation command completion | Completed console response | Screenshot remained `AWAITING` | Partial |
| W3-T15 | Rejoin and recovery | Connectivity restored | No supplied evidence | Pending Evidence |
| W3-T16 | `nltest /domain_trusts` detection | Detection generated | No supplied evidence | Pending Evidence |

## Status Definitions

- **Passed:** Evidence supports the expected result.
- **Partial:** Some expected behavior is visible, but the evidence is incomplete.
- **Pending Evidence:** No submitted screenshot proves the result.

Pending items can be added later without changing the current project structure.
