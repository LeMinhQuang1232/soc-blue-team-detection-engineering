# Detection: Successful Logon After Failures

## 1. Goal

Identify a successful Windows logon that occurs after a burst of failed attempts for the same account and source context, because this sequence may indicate that password guessing eventually succeeded.

## 2. Data Source

- Windows Security Event ID 4625: failed logon
- Windows Security Event ID 4624: successful logon
- Relevant fields: target username, source IP, logon type, destination host, and timestamp

## 3. Detection Logic

An analyst reviews repeated 4625 events and then searches forward in time for a 4624 event involving the same account, host, source address, and compatible logon type. In this lab, the sequence was investigated manually in Wazuh rather than implemented as a dedicated custom correlation rule.

## 4. Wazuh Rule

| Item | Value |
|---|---|
| Failed-logon rules | 60122 / 60204 and custom 100110 |
| Successful-logon rule observed | 60106 |
| Custom correlation rule | Not implemented |
| Investigation result | Manual 4625 → 4624 timeline |

## 5. Test Procedure

1. Generate repeated invalid logons for `SOC-LAB-Test`.
2. Authenticate successfully using the correct lab credential.
3. Search Wazuh for Event IDs 4625 and 4624 on `WIN-ENDPOINT`.
4. Compare username, source address, logon type, and timestamps.

## 6. Expected Alert

No dedicated custom alert was expected. The expected investigation result was a sequence of repeated Event ID 4625 records followed by Event ID 4624 for the same lab account and localhost source.

## 7. MITRE ATT&CK Mapping

| Tactic | Technique | ID | Reason |
|---|---|---|---|
| Credential Access | Brute Force | T1110 | Failed attempts followed by success can be consistent with successful password guessing. |
| Defense Evasion / Persistence / Privilege Escalation / Initial Access | Valid Accounts | T1078 | The successful authentication used a valid account; the built-in success event was mapped to Valid Accounts. |

## 8. Validation Result

- Expected result: A 4625 → 4624 sequence is visible for matching context.
- Actual result: Multiple failed events occurred around 15:44 ICT, followed by a successful Event ID 4624 around 16:07 ICT for `SOC-LAB-Test` from `127.0.0.1` on `WIN-ENDPOINT`.
- Status: Passed
- Verdict: True Positive — Authorized Lab Simulation; not evidence of real compromise.

## 9. False Positive Considerations

- A legitimate user correcting a mistyped password.
- A cached credential being updated after repeated failures.
- An administrator intentionally testing a lab account.
- A service recovering after its stored credential was corrected.

## 10. Limitations

- The approximately 22-minute gap is wider than many production correlation windows.
- The source is localhost, not a remote system.
- No dedicated custom correlation rule was deployed.
- A successful logon after failures does not prove takeover without post-logon process, network, privilege, and persistence evidence.

## 11. Evidence

- [`screenshots/04-success-after-failures/01-successful-logon-top.png`](../screenshots/04-success-after-failures/01-successful-logon-top.png)
- [`screenshots/04-success-after-failures/02-successful-logon-bottom.png`](../screenshots/04-success-after-failures/02-successful-logon-bottom.png)
- [`screenshots/04-success-after-failures/03-4625-to-4624-timeline.png`](../screenshots/04-success-after-failures/03-4625-to-4624-timeline.png)
