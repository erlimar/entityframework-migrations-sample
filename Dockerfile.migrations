FROM debian:bookworm-slim AS base

# Estágio 1 - Instala .NET SDK 8.0
RUN export DEBIAN_FRONTEND=noninteractive && \
    apt update && apt full-upgrade -y && apt install wget -y && \
    wget https://packages.microsoft.com/config/debian/12/packages-microsoft-prod.deb -O packages-microsoft-prod.deb && \
    dpkg -i packages-microsoft-prod.deb && \
    rm packages-microsoft-prod.deb && \
    apt update && \
    apt install dotnet-sdk-8.0 -y

# Estágio 2 - Compila as ferramentas
FROM base AS build
WORKDIR /source

# Copia arquivos de projeto para restaurar dependências
COPY --link src/EntityFrameworkMigrations/*.csproj EntityFrameworkMigrations/
COPY --link src/EntityFrameworkMigrations.EFCoreStorage/*.csproj EntityFrameworkMigrations.EFCoreStorage/
COPY --link src/EntityFrameworkMigrations.WebApi/*.csproj EntityFrameworkMigrations.WebApi/
COPY --link .config .config
COPY --link src/*.props .

# Restaura as ferramentas
RUN dotnet tool restore && \
    dotnet restore EntityFrameworkMigrations.WebApi

# Copia fontes completos para publicação
COPY --link src/EntityFrameworkMigrations/ EntityFrameworkMigrations/
COPY --link src/EntityFrameworkMigrations.EFCoreStorage/ EntityFrameworkMigrations.EFCoreStorage/
COPY --link src/EntityFrameworkMigrations.WebApi/ EntityFrameworkMigrations.WebApi/

# Compila os projetos
RUN dotnet build EntityFrameworkMigrations.EFCoreStorage && \
    dotnet build EntityFrameworkMigrations.WebApi

# Publica pacote de migração do banco
RUN dotnet ef migrations bundle \
    --project EntityFrameworkMigrations.EFCoreStorage \
    --startup-project EntityFrameworkMigrations.WebApi \
    --self-contained --target-runtime linux-x64 \
    --output ./artifacts/efbundle --force

# Estágio 3 - Aplicação final
FROM debian:bookworm-slim AS final

# Instala pré-requisitos do .NET 8.0
RUN export DEBIAN_FRONTEND=noninteractive && \
    apt update && \
    apt install -y \
        libc6 \
        libgcc-s1 \
        libgssapi-krb5-2 \
        libicu72 \
        libssl3 \
        libstdc++6 \
        zlib1g

WORKDIR /db-migrations
COPY --link --from=build /source/artifacts .
ENTRYPOINT ["./efbundle"]