
# start process
function StartProcess($fileName, $arguments, $workingDirectory)
{
	# start process info
	$processInfo = New-Object System.Diagnostics.ProcessStartInfo
	$processInfo.FileName = $fileName
	$processInfo.RedirectStandardError = $true
	$processInfo.RedirectStandardOutput = $true
	$processInfo.UseShellExecute = $false
	$processInfo.Arguments = $arguments
	$processInfo.WorkingDirectory = $workingDirectory
	$processInfo.CreateNoWindow = $true

    # Creating string builders to store stdout and stderr.
    $oStdOutBuilder = New-Object -TypeName System.Text.StringBuilder
    $oStdErrBuilder = New-Object -TypeName System.Text.StringBuilder

	# run process
	$process = New-Object System.Diagnostics.Process
	$process.StartInfo = $processInfo

    $sScripBlock = {
        if (! [String]::IsNullOrEmpty($EventArgs.Data)) {
            $Event.MessageData.AppendLine($EventArgs.Data)
        }
    }
	
	$oStdOutEvent = Register-ObjectEvent -InputObject $process `
        -Action $sScripBlock -EventName 'OutputDataReceived' `
        -MessageData $oStdOutBuilder
    $oStdErrEvent = Register-ObjectEvent -InputObject $process `
        -Action $sScripBlock -EventName 'ErrorDataReceived' `
        -MessageData $oStdErrBuilder


	$process.Start() | Out-Null
    $process.BeginErrorReadLine()
    $process.BeginOutputReadLine()
	$process.WaitForExit()

    # Unregistering events to retrieve process output.
    Unregister-Event -SourceIdentifier $oStdOutEvent.Name
    Unregister-Event -SourceIdentifier $oStdErrEvent.Name

	if ($process.ExitCode -ne 0)
	{
		if ($oStdOutBuilder.Length -gt 0)
		{
			Write-Host $oStdOutBuilder.ToString()
		}

		if ($oStdErrBuilder.Length -gt 0)
		{
			Write-Host $oStdErrBuilder.ToString()
		}

        Write-Error ("Failed to run '" + $fileName + "' with arguments '$arguments' returned error code " + $process.ExitCode)

        exit 1
	}
}


$rootDir = $ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath("..")
$packageDir = [System.IO.Path]::Combine($rootDir, "package")
$pandocFile = Join-Path $env:LOCALAPPDATA -ChildPath 'Pandoc\pandoc.exe'

# fail, if pandoc file doesn't exist
if (!(Test-Path -path $pandocFile))
{
	Write-Error "Error: Pandoc file '$pandocFile' doesn't exist!"
	exit 1
}


# Build readme files
# ------------------

Write-Host "Building readme html from readme github markdown..."

# build readme html from readme markdown using pandoc
$readmeMarkdownFile = Resolve-Path '..\README.md'
$readmeHtmlFile = Join-Path -Path $packageDir -ChildPath "README.html"
$pandocArgs = "-f markdown_github -c ""github-pandoc.css"" -t html5 ""$readmeMarkdownFile"" -o ""$readmeHtmlFile"""
StartProcess $pandocFile $pandocArgs $packageDir

# read github pandoc css and readme html
$githubPandocFile = Resolve-Path 'github-pandoc.css'
$githubPandocCss = [System.IO.File]::ReadAllText($githubPandocFile)
$readmeHtml = [System.IO.File]::ReadAllText($readmeHtmlFile)

# embed github pandoc css and remove stylesheet link
$readmeHtml = $readmeHtml -replace '<style[^<>]+>(.*?)</style>', "<style type=""text/css"">`$1`r`n$githubPandocCss</style>" -replace '<link\s+rel="stylesheet"\s+href="github-pandoc.css">', ''
[System.IO.File]::WriteAllText($readmeHtmlFile, $readmeHtml)

Write-Host "Done."


# build amiga guide from html
$readmeGuide = [regex]::Replace($readmeHtml, '<style[^<>]+>(.*?)</style>', '', [System.Text.RegularExpressions.RegexOptions]::Singleline)
$readmeGuide = [regex]::Replace($readmeGuide, "`r", '', [System.Text.RegularExpressions.RegexOptions]::Singleline)

$readmeGuide = $readmeGuide -replace '<h\d[^<>]*>(.*?)</h\d>', '@node "$1" "$1"' -replace '</p>',"`n" -replace '<[^>]*>', ''

$readmeGuide = "@database ""ADF_Device.guide""`n" + $readmeGuide

$readmeGuideFile = Join-Path -Path $packageDir -ChildPath "README.guide"
[System.IO.File]::WriteAllText($readmeGuideFile, $readmeGuide)
