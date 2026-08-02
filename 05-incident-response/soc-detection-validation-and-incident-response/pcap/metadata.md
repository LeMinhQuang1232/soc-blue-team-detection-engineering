# Final PCAP Metadata

## File Identity

* Filename: `P1-INC01-R1-recapture.pcap`
* Lab path: `/home/quang-le/P1-INC01-R1-recapture/capture/P1-INC01-R1-recapture.pcap`
* Encapsulation: Ethernet
* File size: 4,313 kB as reported by `capinfos`
* Packet count: 5,246
* Capture duration: 111.382056 seconds
* First packet: 2026-08-02 13:46:58.358191
* Last packet: 2026-08-02 13:48:49.740247
* Average packet rate: approximately 47 packets/second
* Average packet size: 806.19 bytes
* Strict time order: False

## Integrity

* SHA-256: `eb892a293b7cbcb1d4032fb7326e13633256f410a8b19933d12c9ac70c6e183c`
* SHA-1 reported by capinfos: `69074dbf5077402a9a31be3df288cc9cbed1b71b`

![capinfos and hash](../screenshots/11-pcap-integrity/P1-INC01-102-final-pcap-capinfos-and-hash.png)

![sha256sum confirmation](../screenshots/11-pcap-integrity/P1-INC01-103-final-pcap-sha256-confirmation.png)

## Repository Decision

The raw PCAP is not bundled in the generated GitHub update. Before adding it, verify the SHA-256, review it for unintended sensitive traffic, and place only the exact validated file in this folder.
