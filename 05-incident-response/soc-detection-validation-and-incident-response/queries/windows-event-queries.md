# Windows Event Review Commands

## Failed Logons

```powershell
Get-WinEvent -FilterHashtable @{LogName='Security'; Id=4625} -MaxEvents 20 |
  Select-Object TimeCreated, Id, ProviderName, Message
```

## Sysmon Process Creation for the Incident

```powershell
Get-WinEvent -FilterHashtable @{
  LogName='Microsoft-Windows-Sysmon/Operational'
  Id=1
} -MaxEvents 200 |
Where-Object {
  $_.Message -match 'EncodedCommand|P1-INC01|whoami|hostname|systeminfo|ipconfig|route print|arp -a|netstat|Get-NetTCPConnection'
} |
Select-Object TimeCreated, Id, Message
```

These commands are investigation helpers. The screenshots and raw event records remain the evidence source.
