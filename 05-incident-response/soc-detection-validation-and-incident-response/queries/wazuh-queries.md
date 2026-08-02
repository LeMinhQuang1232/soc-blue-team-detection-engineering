# Wazuh Investigation Queries

The exact field names may vary by Wazuh version and data view. The following queries reflect the rule IDs observed in this project.

```text
rule.id:92057
```
Encoded PowerShell.

```text
rule.id:100132
```
System and account discovery.

```text
rule.id:100140
```
Network-discovery commands.

```text
rule.id:100154
```
Controlled file download.

```text
rule.id:100130
```
SQL-injection-like web request.

```text
agent.name:"WIN-ENDPOINT" AND rule.id:(92057 OR 100132 OR 100140 OR 100154 OR 100130)
```
Combined incident view.

```text
agent.name:"WIN-ENDPOINT" AND data.win.system.eventID:"4625"
```
Controlled failed-authentication events when the Windows Security fields are available in the selected index pattern.

Use the execution timestamps in `attack-timeline.md` to constrain each search and avoid mixing the initial run with the retest.
