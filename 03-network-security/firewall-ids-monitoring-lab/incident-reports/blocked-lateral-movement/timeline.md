# Timeline — Blocked Unauthorized Administrative Access

The screenshots were captured during sequential lab validation rather than a production incident timeline.

| Phase | Activity | Result |
|---|---|---|
| Policy build | Interfaces, aliases, and USER/DMZ/SOC_ADMIN rules configured | Segmentation established |
| Positive control | USER tested Nginx TCP/80 | Allowed |
| Negative controls | USER tested TCP/22, 445, and 3389 | Blocked |
| Firewall review | Deny logs reviewed | Source/destination and policy action confirmed |
| Privileged-path test | Client moved to SOC_ADMIN role and tested SSH | Allowed |
| Monitoring hardening | SOC_ADMIN allowed 3000/9090; USER denied | Least privilege validated |
