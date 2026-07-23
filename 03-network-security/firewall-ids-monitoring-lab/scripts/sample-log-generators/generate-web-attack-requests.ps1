[CmdletBinding()]
param(
    [string]$Target = "http://192.168.20.10"
)

$ErrorActionPreference = "Stop"
$requests = @(
    "$Target/",
    "$Target/search?q=normal",
    "$Target/search?q=union%20select%20password%20from%20users",
    "$Target/search?q=%3Cscript%3Ealert(1)%3C%2Fscript%3E"
)

foreach ($uri in $requests) {
    Write-Host "Requesting $uri"
    & curl.exe --max-time 10 $uri
}
