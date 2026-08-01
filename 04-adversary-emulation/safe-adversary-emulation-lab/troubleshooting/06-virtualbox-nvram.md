# VirtualBox EFI NVRAM Error

A VirtualBox log later reported:

- `VERR_VFS_UNSUPPORTED_FORMAT`
- Failure to load the NVRAM store
- EFI device construction failure

This failure occurs before the guest operating system starts and is separate from Wazuh or test logic.

Recovery priority:

1. Back up the VM folder, `.vbox` configuration, virtual disk, and snapshot metadata.
2. Do not delete the virtual disk.
3. Inspect or replace the referenced NVRAM file.
4. Recreate the EFI NVRAM state only after a backup.
5. Boot and validate network adapters, time, Wazuh agent connectivity, and sensor identity.
