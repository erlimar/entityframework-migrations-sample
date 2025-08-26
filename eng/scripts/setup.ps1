$rootPath = Split-Path -Parent $MyInvocation.MyCommand.Path | Join-Path -ChildPath "..\.."

$postgresPassword = -join ((48..57+64..90+95+97..122) | Get-Random -Count 20 | ForEach-Object {[char]$_})

$envFilePath = $rootPath | Join-Path -ChildPath "db.env" 

if (Test-Path $envFilePath) {
    "File db.env already exists." | Write-Host
} else {
    "Generating file db.env" | Write-Host
    $envLocalContent = @"
POSTGRES_USER=postgres
POSTGRES_PASSWORD=${postgresPassword}
PGUSER=postgres
PGPASSWORD=${postgresPassword}
POSTGRES_DB=app_db
"@
    $envLocalContent | Out-File -FilePath $envFilePath -Encoding utf8
}

$webApiProjectPath = $rootPath 
| Join-Path -ChildPath "src/EntityFrameworkMigrations.WebApi/EntityFrameworkMigrations.WebApi.csproj" 
| Resolve-Path

$envFilePath = $envFilePath | Resolve-Path


$connectionString = "Host=localhost;Database=<database>;Username=<username>;Password=<password>";

foreach ($line in Get-Content $envFilePath) {
    # Skip empty lines and comments
    if (-not [string]::IsNullOrWhiteSpace($line) -and $line -notlike "#*") {
        # Split the line into key and value
        $parts = $line -split "=", 2
        $name = $parts[0].Trim()
        $value = $parts[1].Trim()

        if ($name -eq "POSTGRES_DB") {
            $connectionString = $connectionString -replace "<database>", $value
        }

        if ($name -eq "POSTGRES_USER") {
            $connectionString = $connectionString -replace "<username>", $value
        }

        if ($name -eq "POSTGRES_PASSWORD") {
            $connectionString = $connectionString -replace "<password>", $value
        }
    }
}

dotnet user-secrets --project $webApiProjectPath set "ConnectionStrings:AppDbContext" $connectionString