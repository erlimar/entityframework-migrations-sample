$rootPath = Split-Path -Parent $MyInvocation.MyCommand.Path | Join-Path -ChildPath ".."

$srcPath = $rootPath | Join-Path -ChildPath "src" | Resolve-Path
$webApiPath = $rootPath | Join-Path -ChildPath "src\EntityFrameworkMigrations.WebApi" | Resolve-Path
$efStoragePath = $rootPath | Join-Path -ChildPath "src\EntityFrameworkMigrations.EFCoreStorage" | Resolve-Path

"Removing last migration..." | Write-Host -ForegroundColor Blue
Push-Location $srcPath
    dotnet ef migrations remove --startup-project $webApiPath --project $efStoragePath
Pop-Location
