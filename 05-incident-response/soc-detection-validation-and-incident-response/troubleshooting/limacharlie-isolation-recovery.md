# LimaCharlie Isolation and Recovery

## Expected Isolation Behavior

After `segregate_network`, ordinary endpoint traffic should fail while the LimaCharlie management channel remains available.

## Validated Sequence

1. Confirmed DMZ TCP/80 and pfSense TCP/443 reachable.
2. Isolated the endpoint.
3. Confirmed both TCP checks failed and ping showed complete loss.
4. Confirmed the sensor still returned system information.
5. Executed `rejoin_network` and received success.
6. Confirmed both TCP checks succeeded again.

## Evidence Limitation

A second isolation succeeded during retest, but the supplied evidence set does not include a separate second rejoin screenshot. The fully documented recovery claim applies to the first containment cycle.
