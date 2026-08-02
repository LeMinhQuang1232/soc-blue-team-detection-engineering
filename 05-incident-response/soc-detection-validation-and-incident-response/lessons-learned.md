# Lessons Learned

1. Establish a stable baseline before generating test traffic.
2. Use one execution log as the authoritative record of what was intentionally performed.
3. A SIEM alert must be correlated with raw endpoint or application evidence.
4. Packet capture integrity is part of the detection workflow, not an optional administrative step.
5. Empty or missing PCAP files should be preserved as troubleshooting notes but replaced as primary evidence.
6. Behavioral scores depend on the completeness of the input window.
7. Suricata stream or checksum noise must not be misrepresented as incident attribution.
8. Wazuh buffering must be healthy before a timed validation run.
9. Multi-interface endpoints require explicit source-IP mapping.
10. Isolation is only fully validated when ordinary access stops, the management channel remains available, and recovery restores service.
11. Retesting should reproduce the same test IDs and preserve before/after evidence.
12. Honest partial findings improve the credibility of the portfolio more than unsupported claims of full coverage.
