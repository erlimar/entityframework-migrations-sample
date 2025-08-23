$rootPath = Split-Path -Parent $MyInvocation.MyCommand.Path | Join-Path -ChildPath ".."

$srcPath = $rootPath | Join-Path -ChildPath "src" | Resolve-Path
$webApiPath = $rootPath | Join-Path -ChildPath "src\EntityFrameworkMigrations.WebApi" | Resolve-Path
$efStoragePath = $rootPath | Join-Path -ChildPath "src\EntityFrameworkMigrations.EFCoreStorage" | Resolve-Path

"Listing migrations..." | Write-Host -ForegroundColor Blue
Push-Location $srcPath
    dotnet ef migrations list --startup-project $webApiPath --project $efStoragePath
Pop-Location
