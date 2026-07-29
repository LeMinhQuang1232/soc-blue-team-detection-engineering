# HTTP Path-Probing Detection

## Logic

Eight or more unique URIs from one source in a 30-second window trigger `http_path_enumeration` and classification `probable_http_enumeration`.

## Validation

Nine unique URIs were requested within approximately 3.71 seconds. The base score was 20 Low, while the tuned profile produced 35 Medium. Suricata SID `1000006` confirmed the burst pattern.

## Triage Context

Review application type, status codes, authentication state, user agent, source reputation/role, and whether paths correspond to sensitive administration or backup locations.
