param(
    [Parameter(Mandatory=$true)]
    [string]$MigrationName)

$ErrorActionPreference = "Stop"

$rootPath = Split-Path -Parent $MyInvocation.MyCommand.Path | Join-Path -ChildPath "..\.."

$webApiPath = $rootPath | Join-Path -ChildPath "src\EntityFrameworkMigrations.WebApi" | Resolve-Path
$efStoragePath = $rootPath | Join-Path -ChildPath "src\EntityFrameworkMigrations.EFCoreStorage" | Resolve-Path

"Updating database to migration $MigrationName..." | Write-Host -ForegroundColor Blue
dotnet ef database update $MigrationName --startup-project $webApiPath --project $efStoragePath
