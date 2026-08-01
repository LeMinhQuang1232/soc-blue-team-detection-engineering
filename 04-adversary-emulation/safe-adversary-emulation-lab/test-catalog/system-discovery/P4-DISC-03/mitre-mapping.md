# ATT&CK and Control Mapping — P4-DISC-03

The command `net accounts` reads password/account policy. The primary analyst-reviewed mapping is **T1201 — Password Policy Discovery**. The observed Wazuh rule metadata displayed **T1087** and **T1059.003**. Both are retained in the record: one as tool output, one as analyst interpretation. This prevents silent rewriting of evidence while improving mapping precision.

## Mapping Review Questions

- What action actually occurred?
- Which command, process, protocol, or control generated the evidence?
- Is the mapping reported by the security tool, added by the analyst, or both?
- Does the evidence prove the technique, or only a related indicator?
- Are legitimate administrative explanations documented?

## Supporting Evidence

- [Full test analysis](README.md)
- [Relevant screenshot folder](../../../screenshots/03-discovery/)
