# Incident Test Execution Records

## Initial Run

| Order | Incident step | Source test | Execution summary | Result reference |
|---:|---|---|---|---|
| 1 | P1-AUTH-01 | P4-AUTH-01 | Five controlled wrong-password attempts | `validation-tests.md` P1-V02 |
| 2 | P1-EXEC-01 | P4-EXEC-01 | Benign encoded PowerShell execution | P1-V03 |
| 3 | P1-DISC-01 | P4-DISC-01 | User, host, and operating-system discovery | P1-V04 |
| 4 | P1-DISC-02 | P4-DISC-02 | Interface, route, ARP, socket, and TCP-connection discovery | P1-V05 |
| 5 | P1-NET-01 | P4-NET-01 | Bounded probe of twelve predefined ports against `192.168.20.10` | P1-V06 |
| 6 | P1-HTTP-01 | P4-FILE-01 | Benign HTTP text-file download | P1-V07 |
| 7 | P1-HTTP-02 | Incident-specific extension | Controlled SQLi-like request | P1-V08 |
| 8 | P1-RESP-01 | Existing LimaCharlie response workflow | Isolate, verify sensor continuity, rejoin, and validate recovery | P1-V09–P1-V11 |

## Evidence Rules

* The timestamped incident record is the authoritative execution sequence.
* Screenshots prove the observed result but do not replace the execution record.
* A test is not upgraded to Passed when an expected evidence layer is missing.
* Reused test IDs remain linked to Project 6; incident IDs remain local to Project 7.

## Primary References

* `../attack-timeline.md`
* `../validation-tests.md`
* `../telemetry-matrix.md`
* `../evidence-log.md`
* `../screenshots/evidence-index.md`
