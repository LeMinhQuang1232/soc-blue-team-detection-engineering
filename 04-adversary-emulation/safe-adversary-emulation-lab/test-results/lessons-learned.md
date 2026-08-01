# Lessons Learned

1. Safety design must precede execution.
2. A test is not complete until cleanup is verified.
3. Telemetry, alerting, and response are separate capabilities.
4. Run-specific log isolation is necessary for reliable IDS attribution.
5. Historical EVE records and broad custom signatures can create misleading evidence.
6. Wazuh startup scans can flood the agent buffer and delay events.
7. Replayed datasets are valuable for regression testing when labeled clearly.
8. EICAR validates antivirus handling, not general malware behavior.
9. Partial results and false positives are useful engineering findings.
10. This catalog is ready to become the controlled activity source for the next purple-team incident.
