#requires -version 5.0

using namespace System.IO

data messages {
    @{
        TerminatingError = @{
            PathNotFound = '{0} not found -- cannot automatically install!'
        }

        Information =@{
            CheckRequiredPaths = 'Looking for required paths...'
            CreateMissingDirs = 'Making missing directories...'
            CopyTarget = 'Copying targets...'
        }
        Verbose = @{ 
            Looking = 'Looking for {0} at -> {1}'
            Found = '{0} found'
            Exists = '{0} already exists'
        }
    }

}

data config -SupportedCommand Convert-Path {
    @{ 
        From = @{ 
            SourceDir  = (Convert-Path .) + '\lua\' 
            LuaLibPath = 'lualib_bundle.lua'
            TargetDir     = 'src\'
            TargetPath = 'main.lua'
        }

        To   = @{
            Grafx2Dir     = (Convert-Path ~) + '\AppData\Local\Grafx2\' 
            ScriptDir     = 'share\grafx2\scripts\'
            ScriptLibsDir = 'libs\'
            SourceDir     = 'src\'
            TargetDir     = 'endo\' 
        }
    }
}

$VerbosePreference = 'Continue'
$InformationPreference = 'Continue'
$ErrorActionPreference = 'Stop'

function Invoke-Combine { [Path]::Combine.Invoke($args) }

$fromTargetDir = Invoke-Combine $config.From.SourceDir $config.From.TargetDir
$targetPath = Invoke-Combine $fromTargetDir $config.From.TargetPath
$luaLibPath = Invoke-Combine $config.From.SourceDir $config.From.LuaLibPath
$toScriptDir = Invoke-Combine $config.To.Grafx2Dir $config.To.ScriptDir
$toScriptLibsDir = Invoke-Combine $toScriptDir $config.To.ScriptLibsDir
$toTargetDir = Invoke-Combine $toScriptDir $config.To.TargetDir

enum IOType {
    File
    Dir
}

function Get-Info ($x, $k) {
    switch ($x) {
        File { [FileInfo] $k }
        Dir { [DirectoryInfo] $k }
    }
}

filter Search-Path ([IOType] $x) {
    $k = $_ 
    $y = Info $x $k

    Write-Verbose ($messages.Verbose.Looking -f $y.Name, $y.FullName) 

    if (!$y.Exists) {
        Write-Error -Exception ([DirectoryNotFoundException] ($messages.TerminatingError.PathNotFound -f $y.Name))
    }

    Write-Verbose ($messages.Verbose.Found -f $y.Name)
}


filter New-IfMissing {
    $k = $_ 
    $x = [IOType]::Dir
    $y = Info $x $k

    Write-Verbose ($messages.Verbose.Looking -f $y.Name, $y.FullName)

    if (!$y.Exists) {
        New-Item -Path $y.FullName -ItemType Directory -Verbose | Out-Null
    }
    else {
        Write-Verbose ($messages.Verbose.Exists -f $y.Name)
    }

}

Write-Information $messages.Information.CheckRequiredPaths

@(
    $config.To.Grafx2Dir
    $config.From.SourceDir
    $fromTargetDir
    $toScriptDir
) | Search-Path Dir

@(
    $targetPath
    $luaLibPath
) | Search-Path File

Write-Information $messages.Information.CreateMissingDirs

@(
    $toScriptLibsDir
    $toTargetDir
) | New-IfMissing

Write-Information $messages.Information.CopyTarget

Copy-Item -Path $fromTargetDir -Filter *.lua -Destination $toScriptLibsDir -Recurse -Verbose -ErrorAction Continue
Copy-Item -Path $luaLibPath -Destination $toScriptLibsDir -Verbose -ErrorAction Continue
Copy-Item -Path $targetPath -Destination $toTargetDir -Verbose -ErrorAction Continue

exit 0