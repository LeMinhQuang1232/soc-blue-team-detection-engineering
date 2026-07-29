# Threshold and Weight Tuning

## Method

The base and tuned profiles use the same metrics and thresholds. Only selected weights differ, making the severity change auditable.

| Signal | Base weight | Tuned weight |
|---|---:|---:|
| 10–24 unique ports | 20 | 30 |
| 25+ unique ports | 30 | 60 |
| 5+ hosts | 25 | 35 |
| 10+ failures | 20 | 20 |
| 3+ admin attempts | 15 | 35 |
| 8+ URIs | 20 | 35 |

## Results

| Scenario | Base | Tuned |
|---|---:|---:|
| Baseline | 0 Low | 0 Low |
| ICMP sweep | 25 Low | 35 Medium |
| Service probing | 35 Medium | 55 Medium |
| HTTP path probing | 20 Low | 35 Medium |
| TCP SYN scan | 50 Medium | 80 Critical |

## Decision

The base profile is retained as the validated Wazuh event because it avoids presenting an unverified severity. The tuned profile demonstrates how sensitivity changes and should be evaluated against a larger benign baseline before operational adoption.
