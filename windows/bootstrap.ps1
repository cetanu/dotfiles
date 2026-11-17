$ErrorActionPreference = "Stop"

$WindowsDir = $PSScriptRoot
$RepoRoot = Split-Path -Parent $WindowsDir

# Prevent mise from merging the Unix-oriented root mise.toml.
$env:MISE_CEILING_PATHS = $RepoRoot

mise -C $WindowsDir trust
mise -C $WindowsDir bootstrap @args
