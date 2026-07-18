# Detection Validation Tests

| Test ID | Detection | Expected Result | Actual Result | Status |
|---|---|---|---|---|
| W2-T01 | SSH brute force | Rule 100100 alert | Rule 100100 generated; four custom-alert hits were visible | Passed |
| W2-T02 | Windows failed logons | Rule 100110 alert | Rule 100110 generated after repeated Event ID 4625 activity | Passed |
| W2-T03 | Success after failures | 4625 → 4624 timeline | Repeated 4625 events were followed by a 4624 event for the same lab account and localhost source | Passed |
| W2-T04 | Suspicious PowerShell | Rule 100120 alert | Rule 100120 generated for `powershell.exe -EncodedCommand SQBFAFgA` | Passed |
| W2-T05 | SQL injection | Rule 100130 alert | Rule 100130 generated for two encoded SQL injection patterns | Passed |
| W2-T06 | XSS/path traversal | Rule 100131 alert | Rule 100131 generated for the XSS and path-traversal requests | Passed |
| W2-T07 | Normal PowerShell | No custom alert | No supplied screenshot proves both the benign event and absence of rule 100120 in the same time window | Pending Evidence |
| W2-T08 | Normal web request | No custom web alert | Normal `/` and `/search?q=normal` requests appear in the source log; only the four attack-pattern requests appear in the custom-rule result set | Passed |

## Validation Method

A test is marked **Passed** only when the supplied evidence demonstrates the expected event or alert. W2-T07 is intentionally not marked Passed because a negative result requires time-bounded evidence, not an assumption.

## Required Evidence to Close W2-T07

1. Run a benign command such as:

   ```powershell
   powershell -NoProfile -Command "Get-Process | Select-Object -First 5"
   ```

2. Capture the corresponding Sysmon Event ID 1 with the command line visible.
3. Query Wazuh for the same host and narrow time range with `rule.id: 100120`.
4. Capture the zero-result query or an event view showing the benign process event without the custom rule.
