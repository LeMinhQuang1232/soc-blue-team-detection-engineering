param(
    [Parameter(Mandatory = $false)]
    [string]$RepoPath = (Get-Location).Path,

    [switch]$Apply
)

$ErrorActionPreference = "Stop"

$RepoRoot = (Resolve-Path $RepoPath).Path

if (-not (Test-Path (Join-Path $RepoRoot ".git"))) {
    throw "RepoPath is not a Git repository: $RepoRoot"
}

$Projects = @(
    [PSCustomObject]@{
        Name = "Wazuh Log Onboarding"
        Path = "01-siem\wazuh-log-onboarding"
    },
    [PSCustomObject]@{
        Name = "Wazuh Detection Engineering"
        Path = "01-siem\wazuh-detection-engineering"
    },
    [PSCustomObject]@{
        Name = "LimaCharlie EDR Detection and Response"
        Path = "02-edr-endpoint-security\limacharlie-edr-lab"
    },
    [PSCustomObject]@{
        Name = "Firewall IDS and Infrastructure Monitoring"
        Path = "03-network-security\firewall-ids-monitoring-lab"
    }
)

$ImageExtensions = @(
    ".png",
    ".jpg",
    ".jpeg",
    ".gif",
    ".webp"
)

$Timestamp = Get-Date -Format "yyyyMMdd-HHmmss"

$BackupRoot = Join-Path `
    $env:TEMP `
    "soc-evidence-update-backup-$Timestamp"

$Utf8NoBom = [System.Text.UTF8Encoding]::new($false)

$ImagePattern = @'
(?<!\[)(!\[[^\]]*\]\((?<target><[^>]+>|[^)\s]+)(?:\s+["'][^"']*["'])?\))
'@.Trim()

$ImageRegex = [regex]::new($ImagePattern)

function Get-RelativePath {
    param(
        [Parameter(Mandatory = $true)]
        [string]$BasePath,

        [Parameter(Mandatory = $true)]
        [string]$TargetPath
    )

    $ResolvedBase = [System.IO.Path]::GetFullPath($BasePath)
    $ResolvedTarget = [System.IO.Path]::GetFullPath($TargetPath)

    if (-not $ResolvedBase.EndsWith("\")) {
        $ResolvedBase += "\"
    }

    $BaseUri = [System.Uri]::new($ResolvedBase)
    $TargetUri = [System.Uri]::new($ResolvedTarget)

    $RelativeUri = $BaseUri.MakeRelativeUri($TargetUri)

    return [System.Uri]::UnescapeDataString(
        $RelativeUri.ToString()
    ).Replace("/", "\")
}

function Convert-ToMarkdownPath {
    param(
        [Parameter(Mandatory = $true)]
        [string]$Path
    )

    $Normalized = $Path.Replace("\", "/")

    $EncodedParts = foreach ($Part in ($Normalized -split "/")) {
        if ($Part -eq "." -or $Part -eq "..") {
            $Part
        }
        else {
            [System.Uri]::EscapeDataString($Part)
        }
    }

    return $EncodedParts -join "/"
}

function Backup-File {
    param(
        [Parameter(Mandatory = $true)]
        [string]$FilePath
    )

    if (-not $Apply) {
        return
    }

    if (-not (Test-Path -LiteralPath $FilePath)) {
        return
    }

    $RelativePath = Get-RelativePath `
        -BasePath $RepoRoot `
        -TargetPath $FilePath

    $BackupPath = Join-Path $BackupRoot $RelativePath
    $BackupParent = Split-Path $BackupPath -Parent

    New-Item `
        -Path $BackupParent `
        -ItemType Directory `
        -Force |
    Out-Null

    Copy-Item `
        -LiteralPath $FilePath `
        -Destination $BackupPath `
        -Force
}

function Write-Utf8File {
    param(
        [Parameter(Mandatory = $true)]
        [string]$Path,

        [Parameter(Mandatory = $true)]
        [string]$Content
    )

    $Parent = Split-Path $Path -Parent

    New-Item `
        -Path $Parent `
        -ItemType Directory `
        -Force |
    Out-Null

    [System.IO.File]::WriteAllText(
        $Path,
        $Content,
        $Utf8NoBom
    )
}

function Update-ClickableImages {
    param(
        [Parameter(Mandatory = $true)]
        [string]$MarkdownFile
    )

    $OriginalContent = [System.IO.File]::ReadAllText(
        $MarkdownFile
    )

    if ($OriginalContent.Contains("`r`n")) {
        $NewLine = "`r`n"
    }
    else {
        $NewLine = "`n"
    }

    $Lines = [regex]::Split(
        $OriginalContent,
        "\r?\n"
    )

    $UpdatedLines = New-Object `
        System.Collections.Generic.List[string]

    $InCodeFence = $false
    $ReplacementCount = 0

    foreach ($Line in $Lines) {
        $UpdatedLine = $Line
        $Trimmed = $Line.TrimStart()

        if ($Trimmed -match '^(```|~~~)') {
            $InCodeFence = -not $InCodeFence
            $UpdatedLines.Add($UpdatedLine)
            continue
        }

        if (-not $InCodeFence) {
            $Matches = $ImageRegex.Matches($UpdatedLine)

            if ($Matches.Count -gt 0) {
                $UpdatedLine = $ImageRegex.Replace(
                    $UpdatedLine,
                    {
                        param($Match)

                        $ImageMarkup = $Match.Groups[1].Value
                        $Target = $Match.Groups["target"].Value

                        return "[$ImageMarkup]($Target)"
                    }
                )

                $ReplacementCount += $Matches.Count
            }
        }

        $UpdatedLines.Add($UpdatedLine)
    }

    $UpdatedContent = $UpdatedLines -join $NewLine

    if (
        $Apply -and
        $UpdatedContent -ne $OriginalContent
    ) {
        Backup-File -FilePath $MarkdownFile

        Write-Utf8File `
            -Path $MarkdownFile `
            -Content $UpdatedContent
    }

    return $ReplacementCount
}

function Get-ProjectEvidenceLinks {
    param(
        [Parameter(Mandatory = $true)]
        [string]$ProjectPath
    )

    $Links = New-Object `
        System.Collections.Generic.List[string]

    $Links.Add(
        "- [Complete screenshot evidence index](screenshots/evidence-index.md)"
    )

    $OptionalDocuments = @(
        @{
            File = "report.md"
            Text = "Technical report"
        },
        @{
            File = "evidence-log.md"
            Text = "Evidence log"
        },
        @{
            File = "validation-tests.md"
            Text = "Validation tests"
        },
        @{
            File = "validation-summary.md"
            Text = "Validation summary"
        },
        @{
            File = "troubleshooting.md"
            Text = "Troubleshooting notes"
        }
    )

    foreach ($Document in $OptionalDocuments) {
        $DocumentPath = Join-Path `
            $ProjectPath `
            $Document.File

        if (Test-Path -LiteralPath $DocumentPath) {
            $Links.Add(
                "- [$($Document.Text)]($($Document.File))"
            )
        }
    }

    return $Links
}

function Update-ProjectReadme {
    param(
        [Parameter(Mandatory = $true)]
        [string]$ProjectPath
    )

    $ReadmePath = Join-Path $ProjectPath "README.md"

    if (-not (Test-Path -LiteralPath $ReadmePath)) {
        Write-Warning "README not found: $ReadmePath"
        return $false
    }

    $EvidenceLinks = Get-ProjectEvidenceLinks `
        -ProjectPath $ProjectPath

    $BlockLines = New-Object `
        System.Collections.Generic.List[string]

    $BlockLines.Add(
        "<!-- EVIDENCE-NAVIGATION:START -->"
    )

    $BlockLines.Add(
        "## Evidence Navigation"
    )

    $BlockLines.Add("")

    foreach ($Link in $EvidenceLinks) {
        $BlockLines.Add($Link)
    }

    $BlockLines.Add("")
    $BlockLines.Add(
        "<!-- EVIDENCE-NAVIGATION:END -->"
    )

    $Block = $BlockLines -join "`n"

    $OriginalContent = [System.IO.File]::ReadAllText(
        $ReadmePath
    )

    $NavigationPattern = [regex]::new(
        '(?s)<!-- EVIDENCE-NAVIGATION:START -->.*?<!-- EVIDENCE-NAVIGATION:END -->'
    )

    if ($NavigationPattern.IsMatch($OriginalContent)) {
        $UpdatedContent = $NavigationPattern.Replace(
            $OriginalContent,
            $Block
        )
    }
    else {
        $UpdatedContent = (
            $OriginalContent.TrimEnd() +
            "`n`n" +
            $Block +
            "`n"
        )
    }

    if (
        $Apply -and
        $UpdatedContent -ne $OriginalContent
    ) {
        Backup-File -FilePath $ReadmePath

        Write-Utf8File `
            -Path $ReadmePath `
            -Content $UpdatedContent
    }

    return ($UpdatedContent -ne $OriginalContent)
}

function New-EvidenceIndex {
    param(
        [Parameter(Mandatory = $true)]
        [PSCustomObject]$Project
    )

    $ProjectPath = Join-Path `
        $RepoRoot `
        $Project.Path

    $ScreenshotsPath = Join-Path `
        $ProjectPath `
        "screenshots"

    if (-not (Test-Path -LiteralPath $ScreenshotsPath)) {
        Write-Warning "Screenshots directory not found: $ScreenshotsPath"

        return [PSCustomObject]@{
            ImageCount = 0
            IndexPath = $null
        }
    }

    $Images = Get-ChildItem `
        -LiteralPath $ScreenshotsPath `
        -Recurse `
        -File |
    Where-Object {
        $_.Extension.ToLowerInvariant() -in $ImageExtensions
    } |
    Sort-Object FullName

    $ImageEntries = foreach ($Image in $Images) {
        $RelativePath = Get-RelativePath `
            -BasePath $ScreenshotsPath `
            -TargetPath $Image.FullName

        $RelativeDirectory = Split-Path `
            $RelativePath `
            -Parent

        if (
            [string]::IsNullOrWhiteSpace(
                $RelativeDirectory
            )
        ) {
            $RelativeDirectory = "Root"
        }

        [PSCustomObject]@{
            File = $Image
            RelativePath = $RelativePath.Replace("\", "/")
            Directory = $RelativeDirectory.Replace("\", "/")
        }
    }

    $Groups = $ImageEntries |
        Group-Object Directory |
        Sort-Object Name

    $Lines = New-Object `
        System.Collections.Generic.List[string]

    $Lines.Add(
        "# $($Project.Name) - Screenshot Evidence Index"
    )

    $Lines.Add("")

    $Lines.Add(
        "This page provides a direct path to every screenshot stored in this project. Project READMEs and reports display only the most important evidence so that the documentation remains readable."
    )

    $Lines.Add("")

    $Lines.Add(
        "**Total screenshot files:** $($Images.Count)"
    )

    $Lines.Add("")

    $Lines.Add("## Evidence Sections")
    $Lines.Add("")
    $Lines.Add("| Section | Screenshots |")
    $Lines.Add("|---|---:|")

    foreach ($Group in $Groups) {
        $Lines.Add(
            "| ``$($Group.Name)`` | $($Group.Count) |"
        )
    }

    $Lines.Add("")

    foreach ($Group in $Groups) {
        $Lines.Add(
            "## $($Group.Name)"
        )

        $Lines.Add("")

        $IsRawEvidence = (
            $Group.Name -match
            '(?i)(^|/)raw-evidence($|/)'
        )

        foreach ($Entry in $Group.Group) {
            $MarkdownPath = Convert-ToMarkdownPath `
                -Path $Entry.RelativePath

            $FileName = $Entry.File.Name
            $AltText = (
                [System.IO.Path]::GetFileNameWithoutExtension(
                    $FileName
                ) -replace '[-_]', ' '
            )

            if ($IsRawEvidence) {
                $Lines.Add(
                    "- [``$($Entry.RelativePath)``]($MarkdownPath)"
                )
            }
            else {
                $Lines.Add(
                    "### $FileName"
                )

                $Lines.Add("")

                $Lines.Add(
                    "[![$AltText]($MarkdownPath)]($MarkdownPath)"
                )

                $Lines.Add("")

                $Lines.Add(
                    "[Open full-size screenshot]($MarkdownPath)"
                )

                $Lines.Add("")
            }
        }

        $Lines.Add("")
    }

    $IndexPath = Join-Path `
        $ScreenshotsPath `
        "evidence-index.md"

    $IndexContent = (
        $Lines -join "`n"
    ).TrimEnd() + "`n"

    if ($Apply) {
        if (Test-Path -LiteralPath $IndexPath) {
            Backup-File -FilePath $IndexPath
        }

        Write-Utf8File `
            -Path $IndexPath `
            -Content $IndexContent
    }

    return [PSCustomObject]@{
        ImageCount = $Images.Count
        IndexPath = $IndexPath
    }
}

Write-Host ""
Write-Host "Repository:" $RepoRoot

if ($Apply) {
    New-Item `
        -Path $BackupRoot `
        -ItemType Directory `
        -Force |
    Out-Null

    Write-Host "Mode: APPLY"
    Write-Host "Backup:" $BackupRoot
}
else {
    Write-Host "Mode: AUDIT ONLY"
    Write-Host "No files will be changed."
}

Write-Host ""

$MarkdownRoots = @(
    Join-Path $RepoRoot "01-siem"
    Join-Path $RepoRoot "02-edr-endpoint-security"
    Join-Path $RepoRoot "03-network-security"
)

$MarkdownFiles = foreach ($Root in $MarkdownRoots) {
    if (Test-Path -LiteralPath $Root) {
        Get-ChildItem `
            -LiteralPath $Root `
            -Recurse `
            -File `
            -Filter "*.md"
    }
}

$MarkdownFiles = $MarkdownFiles |
    Sort-Object FullName `
    -Unique

$TotalClickableChanges = 0

foreach ($MarkdownFile in $MarkdownFiles) {
    $Count = Update-ClickableImages `
        -MarkdownFile $MarkdownFile.FullName

    if ($Count -gt 0) {
        $RelativeFile = Get-RelativePath `
            -BasePath $RepoRoot `
            -TargetPath $MarkdownFile.FullName

        Write-Host (
            "[IMAGE LINKS] {0}: {1}" -f
            $RelativeFile,
            $Count
        )

        $TotalClickableChanges += $Count
    }
}

Write-Host ""

$TotalIndexedImages = 0

foreach ($Project in $Projects) {
    $ProjectPath = Join-Path `
        $RepoRoot `
        $Project.Path

    if (-not (Test-Path -LiteralPath $ProjectPath)) {
        Write-Warning "Project not found: $($Project.Path)"
        continue
    }

    $IndexResult = New-EvidenceIndex `
        -Project $Project

    $TotalIndexedImages += $IndexResult.ImageCount

    if ($null -ne $IndexResult.IndexPath) {
        $RelativeIndex = Get-RelativePath `
            -BasePath $RepoRoot `
            -TargetPath $IndexResult.IndexPath

        Write-Host (
            "[EVIDENCE INDEX] {0}: {1} image(s)" -f
            $RelativeIndex,
            $IndexResult.ImageCount
        )
    }

    $ReadmeChanged = Update-ProjectReadme `
        -ProjectPath $ProjectPath

    if ($ReadmeChanged) {
        Write-Host (
            "[README NAVIGATION] {0}" -f
            $Project.Path
        )
    }
}

Write-Host ""
Write-Host "Summary"
Write-Host "-------"
Write-Host "Bare image embeds found: $TotalClickableChanges"
Write-Host "Images added to indexes: $TotalIndexedImages"

if ($Apply) {
    Write-Host ""
    Write-Host "Update completed."
    Write-Host "Backup directory:"
    Write-Host $BackupRoot
}
else {
    Write-Host ""
    Write-Host "Audit completed."
    Write-Host "Run again with -Apply to modify files."
}
