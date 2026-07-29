# Firewall Policy Summary

## Segmentation

| Zone | Network | Role |
|---|---|---|
| USER_NET | `192.168.10.0/24` | User workstation traffic and controlled test source |
| DMZ_NET | `192.168.20.0/24` | Ubuntu/Nginx monitored target |
| SOC_ADMIN | `192.168.30.0/24` | Authorized administration and monitoring role |

## Relevant Policy Intent

- Allow required USER web access to the DMZ server.
- Block unauthorized USER access to administrative services such as SSH, SMB, and RDP.
- Permit authorized SOC_ADMIN management access.
- Log relevant pass/block decisions for validation.
- Keep monitoring services restricted from ordinary USER access in the final network lab design.

## Phase 1 Use

pfSense evidence was used to confirm packet path and policy context. The detector did not treat a firewall block by itself as proof of malicious intent; it was correlated with packet and Zeek behavior.

## Host Firewall Note

During the foundation project, SYN packets reached Ubuntu while no SYN-ACK returned because UFW blocked Nginx traffic. This demonstrated that pfSense policy and host firewall policy must be tested separately.
