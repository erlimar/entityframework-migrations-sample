param(
    [Parameter(Mandatory=$true)]
    [string]$ReleaseName)

$ErrorActionPreference = "Stop"

$rootPath = Split-Path -Parent $MyInvocation.MyCommand.Path

$migrationStableVersionFilePath = $rootPath | Join-Path -ChildPath "..\migration-stable-version.txt"

$efMigrationsRemoveScript = $rootPath | Join-Path -ChildPath "ef-migrations-remove.ps1" | Resolve-Path
$efMigrationsAddScript = $rootPath | Join-Path -ChildPath "ef-migrations-add.ps1" | Resolve-Path
$efDatabaseUpdateToStable = $rootPath | Join-Path -ChildPath "ef-database-update-to-stable.ps1" | Resolve-Path
$efDatabaseUpdateScript = $rootPath | Join-Path -ChildPath "ef-database-update.ps1" | Resolve-Path

& $efDatabaseUpdateToStable
& $efMigrationsRemoveScript
& $efMigrationsAddScript $ReleaseName
& $efDatabaseUpdateScript $ReleaseName

$ReleaseName | Out-File -FilePath $migrationStableVersionFilePath -NoNewline