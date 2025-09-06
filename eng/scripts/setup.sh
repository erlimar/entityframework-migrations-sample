#!/bin/bash

# Abort if anything fails
set -e

ROOT_PATH=$(realpath "${BASH_SOURCE[0]%/*}/../..")
POSTGRES_PASSWORD=$(openssl rand -hex 20)
ENV_FILE_PATH=$(realpath "${ROOT_PATH}/db.env")

if [ -f "$ENV_FILE_PATH" ]; then
    echo "File db.env already exists."
else
    echo "Generating file db.env"
    echo "POSTGRES_USER=postgres" >$ENV_FILE_PATH
    echo "POSTGRES_PASSWORD=${POSTGRES_PASSWORD}" >>$ENV_FILE_PATH
    echo "PGUSER=postgres" >>$ENV_FILE_PATH
    echo "PGPASSWORD=${POSTGRES_PASSWORD}" >>$ENV_FILE_PATH
    echo "POSTGRES_DB=app_db" >>$ENV_FILE_PATH
fi

WEB_API_PROJECT_PATH=$(realpath "${ROOT_PATH}/src/EntityFrameworkMigrations.WebApi/EntityFrameworkMigrations.WebApi.csproj")
CONNECTION_STRING="Host=localhost;Database=<database>;Username=<username>;Password=<password>"

for line in $(cat $ENV_FILE_PATH); do
    # Skip empty lines and comments
    if [[ -n "$line" && ! "$line" =~ ^# ]]; then
        # Split the line into key and value
        name=$(echo "${line%%=*}" | xargs)
        value=$(echo "${line#*=}" | xargs)

        case "$name" in
        "POSTGRES_DB")
            CONNECTION_STRING="${CONNECTION_STRING/<database>/$value}"
            ;;
        "POSTGRES_USER")
            CONNECTION_STRING="${CONNECTION_STRING/<username>/$value}"
            ;;
        "POSTGRES_PASSWORD")
            CONNECTION_STRING="${CONNECTION_STRING/<password>/$value}"
            ;;
        esac
    fi
done

dotnet user-secrets --project "${WEB_API_PROJECT_PATH}" set "ConnectionStrings:AppDbContext" "$CONNECTION_STRING"
