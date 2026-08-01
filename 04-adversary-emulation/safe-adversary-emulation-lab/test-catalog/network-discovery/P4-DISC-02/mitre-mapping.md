# ATT&CK and Control Mapping — P4-DISC-02

Configuration commands such as `ipconfig`, `route print`, and `arp -a` align with **T1016**. Commands that enumerate active sockets or connections, including `netstat` and `Get-NetTCPConnection`, also align with **T1049**. The observed Wazuh custom rule primarily reported T1016, while this catalog adds the analyst-reviewed T1049 coverage.

## Mapping Review Questions

- What action actually occurred?
- Which command, process, protocol, or control generated the evidence?
- Is the mapping reported by the security tool, added by the analyst, or both?
- Does the evidence prove the technique, or only a related indicator?
- Are legitimate administrative explanations documented?

## Supporting Evidence

- [Full test analysis](README.md)
- [Relevant screenshot folder](../../../screenshots/03-discovery/)
