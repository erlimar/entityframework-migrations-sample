param(
    [Parameter(Mandatory=$true)]
    [string]$MigrationName)

$ErrorActionPreference = "Stop"

$rootPath = Split-Path -Parent $MyInvocation.MyCommand.Path | Join-Path -ChildPath "..\.."

$webApiPath = $rootPath | Join-Path -ChildPath "src\EntityFrameworkMigrations.WebApi" | Resolve-Path
$efStoragePath = $rootPath | Join-Path -ChildPath "src\EntityFrameworkMigrations.EFCoreStorage" | Resolve-Path

"Add migration $MigrationName..." | Write-Host -ForegroundColor Blue
dotnet ef migrations add $MigrationName --startup-project $webApiPath --project $efStoragePath
