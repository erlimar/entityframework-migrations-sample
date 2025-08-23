$ErrorActionPreference = "Stop"

$rootPath = Split-Path -Parent $MyInvocation.MyCommand.Path | Join-Path -ChildPath ".."

$srcPath = $rootPath | Join-Path -ChildPath "src" | Resolve-Path
$webApiPath = $rootPath | Join-Path -ChildPath "src\EntityFrameworkMigrations.WebApi" | Resolve-Path
$efStoragePath = $rootPath | Join-Path -ChildPath "src\EntityFrameworkMigrations.EFCoreStorage" | Resolve-Path
$bundleFilePath = $rootPath | Join-Path -ChildPath "artifacts\migrations.bundle.exe"

"Generating migration bundle..." | Write-Host -ForegroundColor Blue
dotnet ef migrations bundle `
    --startup-project $webApiPath --project $efStoragePath `
    --self-contained `
    --output $bundleFilePath --force

$bundleFilePath = $bundleFilePath | Resolve-Path

"Succesfuly generated migration bundle $bundleFilePath" | Write-Host -ForegroundColor Green
