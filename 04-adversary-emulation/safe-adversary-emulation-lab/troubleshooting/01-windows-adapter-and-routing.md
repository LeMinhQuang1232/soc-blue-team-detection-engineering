# Windows Adapter and Routing

## Observed

- Several VirtualBox adapters existed simultaneously.
- A broad `Remove-NetIPAddress -Confirm:$false` attempted to affect loopback addresses and failed.
- `New-NetRoute` with `-PolicyStore PersistentStore` returned Windows Error 87.
- The new address temporarily appeared as tentative or invalid.

## Safer Procedure

```powershell
$LabNIC = 'Ethernet 3'
Get-NetIPAddress -InterfaceAlias $LabNIC -AddressFamily IPv4 -ErrorAction SilentlyContinue |
  Where-Object {$_.IPAddress -notlike '169.254.*'} |
  Remove-NetIPAddress -Confirm:$false

New-NetIPAddress -InterfaceAlias $LabNIC -IPAddress 192.168.10.10 -PrefixLength 24
New-NetRoute -DestinationPrefix 192.168.20.0/24 -InterfaceAlias $LabNIC -NextHop 192.168.10.1 -RouteMetric 5
Get-NetIPConfiguration -InterfaceAlias $LabNIC
```

Do not run an unscoped address-removal command on a multi-adapter system. Final evidence confirmed source address `192.168.10.10`, successful TCP 80 access, and denied TCP 22 access.
