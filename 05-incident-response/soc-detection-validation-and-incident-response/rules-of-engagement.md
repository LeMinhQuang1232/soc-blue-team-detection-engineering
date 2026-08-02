# Rules of Engagement

## Authorization

The incident was a controlled validation exercise executed only on virtual machines owned and administered by the lab operator.

## Authorized Assets

* Source: `WIN-ENDPOINT`, primarily `192.168.10.10` on USER_NET.
* Target: Ubuntu DMZ / SOC-WAZUH, `192.168.20.10`.
* Test account: local lab administrator account on WIN-ENDPOINT.
* Network: isolated VirtualBox lab segments managed by pfSense.

## Allowed Activity

* Controlled failed authentication attempts.
* Benign encoded PowerShell that records a known test message.
* Native Windows discovery commands.
* A bounded probe of twelve predefined ports against one authorized target.
* Download of a 43-byte benign text file from Nginx.
* A SQL-injection-like URI used only to generate web telemetry.
* Endpoint isolation and recovery through LimaCharlie.

## Prohibited Activity

* Real malware, persistence, credential theft, destructive commands, ransomware behavior, exploitation, lateral movement, denial of service, public Internet scanning, or testing outside authorized assets.
* Uploading credentials, tokens, executable test artifacts, VM disks, or harmful content to GitHub.

## Safety Controls

* VM snapshots and recovery procedures were available.
* The service probe was limited to twelve predefined ports and one target.
* The HTTP payload was a benign text file.
* Evidence was collected before containment.
* Normal networking and security-service health were checked after rejoin.
