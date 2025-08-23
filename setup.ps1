$postgresPassword = -join ((48..57+64..90+95+97..122) | Get-Random -Count 20 | ForEach-Object {[char]$_})

if (Test-Path .env.local) {
    "File .env.local already exists." | Write-Host
} else {
    "Generating file .env.local" | Write-Host
    $envLocalContent = @"
POSTGRES_USER=postgres
POSTGRES_PASSWORD=${postgresPassword}
PGUSER=postgres
PGPASSWORD=${postgresPassword}
POSTGRES_DB=app_db
"@
    $envLocalContent | Out-File -FilePath .env.local -Encoding utf8
}
