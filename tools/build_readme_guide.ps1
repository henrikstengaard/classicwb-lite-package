# write text file encoded for Amiga
function WriteAmigaTextLines($path, $lines)
{
	$iso88591 = [System.Text.Encoding]::GetEncoding("ISO-8859-1");
	$utf8 = [System.Text.Encoding]::UTF8;

	$amigaTextBytes = [System.Text.Encoding]::Convert($utf8, $iso88591, $utf8.GetBytes($lines -join "`n"))
	[System.IO.File]::WriteAllText($path, $iso88591.GetString($amigaTextBytes), $iso88591)
}


# paths
$rootDir = $ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath("..")
$packageDir = Join-Path $rootDir -ChildPath "package"
$markdownFile = Join-Path -Path $rootDir -ChildPath "README.md"
$guideFileName = "{0}.guide" -f [System.IO.Path]::GetFileNameWithoutExtension($markdownFile)

# read markdown
$markdownLines = @()
$markdownLines += Get-Content $markdownFile

# get title and headers
$title = $markdownLines | ForEach-Object { $_ | Select-String -Pattern "#\s+(.+)" -AllMatches | ForEach-Object { $_.Matches } | ForEach-Object { $_.Groups[1].Value.Trim() } } | Select-Object -First 1
$headers = @()
$headers += $markdownLines | ForEach-Object { $_ | Select-String -Pattern "[#]+\s+(.+)" -AllMatches | ForEach-Object { $_.Matches } | ForEach-Object { $_.Groups[1].Value.Trim() } } | Select-Object -Skip 1

# build guide lines 
$guideLines = @("@database ""$guideFileName""", "@`$VER: $guideFileName (2017.03.24)", "@wordwrap", "@title ""$title""", "")
$guideLines += $markdownLines
$guideLines += @("", "@endnode", "")

# build guide index from headers
$guideIndex = ($headers | ForEach-Object { "@{{""{0}"" link {0}}}" -f $_ }) -join "`n"

$setTitle = $false
$setIndex = $false

for($i = 0; $i -lt $guideLines.Count; $i++)
{
    if ($guideLines[$i] -match '^#')
    {
        if (!$setTitle)
        {
            $guideLines[$i] = $guideLines[$i] -replace "^#\s+(.+)", "@node Main ""$title"""
            $setTitle = $true
        }
        else
        {
            $guideLines[$i] = $guideLines[$i] -replace "^[#]+\s+(.*)", "@endnode`n@node `$1 ""`$1"""

            if (!$setIndex)
            {
                $guideLines[$i] = "$guideIndex`n`n" + $guideLines[$i]
                $setIndex = $true
            }
        }
    }
}

# write guide lines
$guideFile = Join-Path -Path $packageDir -ChildPath $guideFileName
WriteAmigaTextLines $guideFile $guideLines
