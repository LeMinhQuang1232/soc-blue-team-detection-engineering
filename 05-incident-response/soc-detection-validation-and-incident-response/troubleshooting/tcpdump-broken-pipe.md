# tcpdump Broken Pipe During Preview

## Symptom

A command similar to:

```bash
tcpdump -nn -r "$PCAP" ... | head -n 40
```

reported `tcpdump: Unable to write output: Broken pipe`.

## Cause

`head` closes the pipeline after receiving the requested number of lines. `tcpdump` can then report that its output pipe is closed. This is an output-preview condition, not proof that the PCAP was lost or corrupted.

## Safer Alternatives

Use `tcpdump -c 40`, write filtered output to a file, or accept the expected pipeline termination while relying on `capinfos` and cryptographic hashes for integrity.
