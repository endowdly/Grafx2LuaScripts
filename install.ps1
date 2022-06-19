#requires -version 5.0

using namespace System.IO

param (
    
    # Specifies a path to one or more locations. Wildcards are permitted.
    [Parameter(Mandatory = $true,
        Position = 0,
        ParameterSetName = "ParameterSetName",
        ValueFromPipeline = $true,
        ValueFromPipelineByPropertyName = $true,
        HelpMessage = "Path to one or more locations.")]
    [ValidateNotNullOrEmpty()]
    [ValidateScript({
            $di = [DirectoryInfo] $_
        
            $di.Exists -and $di.Name -eq 'grafx2'         
        })]
    [string[]]
    $Destination
    , 
    [switch] $Force)

data message {
    @{
        TerminatingError = @{
            PathNotFound = '{0} not found -- cannot automatically install!'
        }

        Information      = @{
            CheckRequiredPaths = 'Looking for required paths...'
            CreateMissingDirs  = 'Making missing directories...'
            CopyTarget         = 'Copying targets...'
        }
        Verbose          = @{ 
            Looking = 'Looking for {0} at -> {1}'
            Found   = '{0} found'
            Exists  = '{0} already exists'
        }
    }

}

data path -SupportedCommand Convert-Path {
    @{ 
        From = @{ 
            SourceDir  = (Convert-Path .) + '\lua\' 
            LuaLibPath = 'lualib_bundle.lua'
            TargetDir  = 'src\'
            TargetPath = 'main.lua'
        }

        To   = @{
            # Grafx2Dir     = (Convert-Path ~) + '\scoop\apps\grafx2\current' 
            ScriptDir     = 'share\grafx2\scripts\'
            ScriptLibsDir = 'libs\'
            SourceDir     = 'src\'
            TargetDir     = 'endo\' 
        }
    }
}

$InformationPreference = 'Continue'
$ErrorActionPreference = 'Stop'

function Invoke-Combine { [Path]::Combine.Invoke($args) }


filter Test-FileSystemInfo {

    Write-Verbose ($message.Verbose.Looking -f $_.Name, $_.FullName) 

    if ($_.Exists) {
        Write-Verbose ($message.Verbose.Found -f $_.Name) 
        return
    }

    if ($_ -is [DirectoryInfo]) {
        Write-Error -Exception ([DirectoryNotFoundException] ($message.TerminatingError.PathNotFound -f $_.Name))
    }

    if ($_ -is [FileInfo]) {
        Write-Error -Exception ([FileNotFoundException] ($message.TerminatingError.PathNotFound -f $_.Name)) 
    }
}


filter New-MissingDir {

    Write-Verbose ($message.Verbose.Looking -f $_.Name, $_.FullName)

    if (!$_.Exists) {
        New-Item -Path $_.FullName -ItemType Directory | Out-Null
    }
    else {
        Write-Verbose ($message.Verbose.Exists -f $_.Name)
    }

}


$fromTargetDir = Invoke-Combine $path.From.SourceDir $path.From.TargetDir
$targetPath = Invoke-Combine $fromTargetDir $path.From.TargetPath
$luaLibPath = Invoke-Combine $path.From.SourceDir $path.From.LuaLibPath
$toScriptDir = $Destination.ForEach{ Invoke-Combine $_ $path.To.ScriptDir }
$toScriptLibsDir = $toScriptDir.ForEach{ Invoke-Combine $_ $path.To.ScriptLibsDir }
$toTargetDir = $toScriptDir.ForEach{ Invoke-Combine $_ $path.To.TargetDir }

Write-Information $message.Information.CheckRequiredPaths

[DirectoryInfo[]] $Destination + 
[DirectoryInfo[]] $toScriptDir + 
[DirectoryInfo[]] @(
    $path.From.SourceDir
    $fromTargetDir
) | Test-FileSystemInfo 

[FileInfo[]] @(
    $targetPath
    $luaLibPath
) | Test-FileSystemInfo 

Write-Information $message.Information.CreateMissingDirs

[DirectoryInfo[]] $toScriptLibsDir +
[DirectoryInfo[]] $toTargetDir |
New-MissingDir

Write-Information $message.Information.CopyTarget

$toScriptLibsDir.ForEach{
    Copy-Item -Path $fromTargetDir -Filter *.lua -Destination $_ -Recurse -ErrorAction Continue -Force:$Force
    Copy-Item -Path $luaLibPath -Destination $_ -ErrorAction Continue -Force:$Force
}
$toTargetDir.ForEach{
    Copy-Item -Path $targetPath -Destination $_ -ErrorAction Continue -Force:$Force
}

exit 0