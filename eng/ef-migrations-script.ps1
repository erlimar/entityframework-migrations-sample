param(
    [Parameter(Mandatory=$true)]
    [string]$FromMigration,
    [Parameter(Mandatory=$true)]
    [string]$ToMigration)

$rootPath = Split-Path -Parent $MyInvocation.MyCommand.Path | Join-Path -ChildPath ".."

$srcPath = $rootPath | Join-Path -ChildPath "src" | Resolve-Path
$webApiPath = $rootPath | Join-Path -ChildPath "src\EntityFrameworkMigrations.WebApi" | Resolve-Path
$efStoragePath = $rootPath | Join-Path -ChildPath "src\EntityFrameworkMigrations.EFCoreStorage" | Resolve-Path
$scriptFilePath = $rootPath | Join-Path -ChildPath "migrations.script.sql"

"Generating migration script file..." | Write-Host -ForegroundColor Blue
Push-Location $srcPath
    dotnet ef migrations script $FromMigration $ToMigration `
        --startup-project $webApiPath --project $efStoragePath `
        --idempotent --output $scriptFilePath
Pop-Location

$scriptFilePath = $scriptFilePath | Resolve-Path

"Succesfuly generated migration script file $scriptFilePath" | Write-Host -ForegroundColor Green
