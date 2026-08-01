# Windows Defender Event-Channel Collection

The Wazuh agent logged `Could not EvtSubscribe()` for `Microsoft-Windows-Windows Defender/Operational` with error `15007`, and later logged message-format errors `15030`.

The local Defender Operational log remained the primary source of truth. Later Wazuh screenshots proved that Defender detection and remediation events were ingested, including rules `62123` and `62124`.

This result is classified as a transient collection reliability issue rather than a complete collection failure.
