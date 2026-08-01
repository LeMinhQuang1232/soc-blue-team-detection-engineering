# Wazuh Connectivity and Buffering

## Connection Refusal

The Windows agent repeatedly received active refusals on `192.168.20.10:1514` and could not reach enrollment port `1515`. It later established TCP 1514 after server availability was restored.

Validation sequence:

```powershell
Get-Service WazuhSvc
Get-NetTCPConnection -RemotePort 1514 -State Established
Get-Content 'C:\Program Files (x86)\ossec-agent\ossec.log' -Tail 100
```

On Ubuntu, verify the manager and listener before restarting the agent.

## Buffer Flooding

The agent logged 90% buffer use, full/flooded warnings, and stated that events may be lost. The buffer later returned below 70%.

Engineering response:

- Do not begin high-value tests while SCA, FIM, and syscollector startup bursts are filling the buffer.
- Wait for the queue to drain.
- Run one test at a time.
- Verify local event logs even when central ingestion is delayed.
- Record uncertainty when the agent explicitly warns of possible event loss.
