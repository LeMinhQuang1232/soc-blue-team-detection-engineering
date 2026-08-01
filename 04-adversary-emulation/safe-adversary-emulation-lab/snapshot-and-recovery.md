# Snapshot and Recovery

## Pre-Test Snapshot

VirtualBox snapshot evidence was captured for the lab VMs before test execution. See:

- [Snapshot evidence 1](screenshots/01-safety-and-baseline/P4-SETUP-001.png)
- [Snapshot evidence 2](screenshots/01-safety-and-baseline/P4-SETUP-002.png)
- [Snapshot evidence 3](screenshots/01-safety-and-baseline/P4-SETUP-003.png)

## Recovery Procedure

1. Stop test commands and preserve minimum evidence.
2. Remove temporary users, sessions, files, and web artifacts.
3. Confirm Defender and Wazuh remain enabled.
4. Confirm Wazuh, Nginx, Suricata, and related services are active.
5. Confirm network access matches the baseline policy.
6. Restore the snapshot only when ordinary cleanup cannot return the VM to a known state.
7. After snapshot restoration, verify the VM network adapter, time, Wazuh agent identity, and LimaCharlie sensor state.

## VirtualBox NVRAM Maintenance Note

A later VirtualBox startup log reported `VERR_VFS_UNSUPPORTED_FORMAT` while loading the EFI NVRAM store. This is an environment-maintenance issue rather than an emulation result. Preserve the VM disk, back up the `.vbox` and NVRAM files, and repair or recreate the EFI NVRAM reference instead of deleting the VM disk.
