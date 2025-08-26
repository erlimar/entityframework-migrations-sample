$ErrorActionPreference = "Stop"

$rootPath = Split-Path -Parent $MyInvocation.MyCommand.Path | Join-Path -ChildPath "..\.."
$migrationStable = Get-Content -Path ($rootPath | Join-Path -ChildPath "migration-stable-version.txt" | Resolve-Path) -Raw

$webApiPath = $rootPath | Join-Path -ChildPath "src\EntityFrameworkMigrations.WebApi" | Resolve-Path
$efStoragePath = $rootPath | Join-Path -ChildPath "src\EntityFrameworkMigrations.EFCoreStorage" | Resolve-Path

"Updating database to stable migration $migrationStable..." | Write-Host -ForegroundColor Blue
dotnet ef database update $migrationStable --startup-project $webApiPath --project $efStoragePath
