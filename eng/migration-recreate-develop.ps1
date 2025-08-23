$ErrorActionPreference = "Stop"

$rootPath = Split-Path -Parent $MyInvocation.MyCommand.Path

$efMigrationsRemoveScript = $rootPath | Join-Path -ChildPath "ef-migrations-remove.ps1" | Resolve-Path
$efMigrationsAddScript = $rootPath | Join-Path -ChildPath "ef-migrations-add.ps1" | Resolve-Path
$efDatabaseUpdateToStable = $rootPath | Join-Path -ChildPath "ef-database-update-to-stable.ps1" | Resolve-Path
$efDatabaseUpdateScript = $rootPath | Join-Path -ChildPath "ef-database-update.ps1" | Resolve-Path

& $efDatabaseUpdateToStable
& $efMigrationsRemoveScript
& $efMigrationsAddScript Develop
& $efDatabaseUpdateScript Develop
