# Suricata Custom Rules

The final lab used three local rules:

| SID | Detection |
|---|---|
| 1000001 | URI containing `union` and `select` |
| 1000002 | URI containing `<script` |
| 1000003 | TCP SYN burst threshold |

- [Rule file](local.rules)
- [Rule analysis](rule-analysis.md)

These are educational signatures. They favor clarity over production-grade coverage and must be tuned before real deployment.
