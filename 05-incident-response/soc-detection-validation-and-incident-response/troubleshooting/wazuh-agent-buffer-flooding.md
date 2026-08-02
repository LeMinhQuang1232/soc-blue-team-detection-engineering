# Wazuh Agent Buffer Flooding

## Symptom

The Windows agent log reported:

* Agent buffer at 90 percent.
* Agent buffer flooded and events being discarded.
* Later recovery below 70 percent.

## Risk

Events can be delayed or lost, which makes alert-delay measurements and exact cross-layer counts unreliable.

## Recovery Workflow

1. Confirm `WazuhSvc` is running.
2. Confirm the manager and network path are reachable.
3. Observe the agent log until the buffer falls.
4. Avoid starting a timed incident while the buffer is flooded.
5. Reduce unnecessary high-volume telemetry or startup bursts when possible.
6. Record the buffer state in the execution record.

## Reporting Decision

The project does not claim complete event preservation during the warning period. Detections with direct evidence are reported as observed; absence of an alert during that period is not treated as conclusive.
