# Rules of Engagement

## Authorization

- Testing is limited to virtual machines owned and controlled by the lab operator.
- Authorized source: `WIN-ENDPOINT` (`192.168.10.10`).
- Authorized target: `SOC-WAZUH` / Ubuntu DMZ (`192.168.20.10`).
- Testing must remain inside the VirtualBox lab networks.

## Safety Controls

- Create snapshots before test execution.
- Do not use real malware, stolen credentials, or public targets.
- Do not use Bridged Adapter mode for adversary-emulation activity.
- Use harmless files and controlled commands.
- Use EICAR only for antivirus validation.
- Stop a test if it affects the host, an unintended network, or system availability.
- Record start time, expected telemetry, actual telemetry, and cleanup status.

## Evidence Rules

- Preserve original screenshots and logs.
- Do not rewrite failed results as successful.
- Label replayed datasets separately from newly generated traffic.
- Record partial results, false positives, and unknowns.
- Do not upload credentials, tokens, VM disks, malware, or test executables.
