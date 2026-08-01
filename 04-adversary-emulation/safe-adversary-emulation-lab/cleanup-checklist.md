# Cleanup Checklist

| Requirement                                            | Evidence                                              | Status   |
| ------------------------------------------------------ | ----------------------------------------------------- | -------- |
| Remove `P4-LabUser`                                    | `P4-LabUser` removal verification                     | Complete |
| Delete temporary `net use` sessions                    | Temporary `net use` session cleanup                   | Complete |
| Remove `C:\AtomicLab\p4-safe.txt`                      | File absence confirmed at `C:\AtomicLab\p4-safe.txt`  | Complete |
| Remove `/var/www/html/p4-safe.txt`                     | File absence confirmed at `/var/www/html/p4-safe.txt` | Complete |
| Confirm EICAR test files are absent                    | EICAR cleanup verification                            | Complete |
| Confirm Microsoft Defender remains enabled             | Microsoft Defender status verification                | Complete |
| Confirm Wazuh agent is running                         | Wazuh agent service status                            | Complete |
| Confirm HTTP access to the DMZ remains available       | HTTP connectivity verification                        | Complete |
| Confirm Wazuh, Nginx, and Suricata services are active | Service status verification                           | Complete |
| Validate the Suricata configuration                    | Suricata configuration validation                     | Complete |
| Preserve screenshots and report any partial results    | Screenshots and documented partial results            | Complete |


Final cleanup evidence is stored in [`screenshots/08-cleanup-and-recovery`](screenshots/08-cleanup-and-recovery/).
