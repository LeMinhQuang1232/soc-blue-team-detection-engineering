# Failed-Connection Burst

## Logic

Zeek connection states `S0`, `REJ`, `RSTO`, `RSTR`, `SH`, and `SHR` are treated as failed or incomplete for this lab. Ten or more in one window trigger the failed-connection signal.

## Validation

The service-probing dataset contained 12 failed records. The final SYN scan contained 200 `S0` records. In the final scan, this signal combined with high port diversity to produce a score of 50.

## Limitation

Failure states can result from normal outages, closed services, asynchronous routing, or capture loss. They should be correlated with diversity and source role.
