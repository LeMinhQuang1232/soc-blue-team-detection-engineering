# Incident Test Set

## Purpose

This directory records how reusable tests from Project 6 were selected, renamed, combined, executed, and evaluated inside incident `P1-INC01-R1`.

It is **not** a second copy of the reusable master test catalog. The authoritative test definitions remain in:

```text
04-adversary-emulation/
└── safe-adversary-emulation-lab/
    └── test-catalog/
```

The files in this directory are incident-specific records:

* which reusable tests were selected;
* how each test was mapped to an incident step;
* what was actually executed;
* what telemetry and detections were observed;
* which results were Passed, Partial, or not reused;
* what changed during retest.

## Files

* [Selected tests](selected-tests.md)
* [P1-INC01-R1 test mapping](P1-INC01-R1-test-mapping.md)
* [Execution records](execution-records.md)
* [Retest results](retest-results.md)

## Source-of-Truth Rule

The Project 6 catalog defines the reusable test. This directory defines only the use of that test in `P1-INC01-R1`.

When the reusable test definition changes, update Project 6 first. Update this directory only when the incident execution, evidence, or conclusion changes.
