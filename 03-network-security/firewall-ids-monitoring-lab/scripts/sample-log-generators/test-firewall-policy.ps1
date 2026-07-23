[CmdletBinding()]
param(
    [string]$DmzHost = "192.168.20.10"
)

$tests = @(
    @{ Name = "HTTP"; Port = 80 },
    @{ Name = "SSH"; Port = 22 },
    @{ Name = "SMB"; Port = 445 },
    @{ Name = "RDP"; Port = 3389 },
    @{ Name = "Grafana"; Port = 3000 },
    @{ Name = "Prometheus"; Port = 9090 }
)

$results = foreach ($test in $tests) {
    $result = Test-NetConnection $DmzHost -Port $test.Port -WarningAction SilentlyContinue
    [pscustomobject]@{
        Service = $test.Name
        Destination = $DmzHost
        Port = $test.Port
        SourceAddress = $result.SourceAddress
        TcpTestSucceeded = $result.TcpTestSucceeded
    }
}

$results | Format-Table -AutoSize
