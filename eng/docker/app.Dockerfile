# .NET SDK 8
FROM --platform=$BUILDPLATFORM mcr.microsoft.com/dotnet/sdk:8.0 AS build
ARG TARGETARCH
WORKDIR /source

# Copia arquivos de projeto para restaurar dependências
COPY --link src/EntityFrameworkMigrations/*.csproj EntityFrameworkMigrations/
COPY --link src/EntityFrameworkMigrations.EFCoreStorage/*.csproj EntityFrameworkMigrations.EFCoreStorage/
COPY --link src/EntityFrameworkMigrations.WebApi/*.csproj EntityFrameworkMigrations.WebApi/
RUN dotnet restore -a $TARGETARCH EntityFrameworkMigrations.WebApi/EntityFrameworkMigrations.WebApi.csproj

# Copia fontes completos para publicação
COPY --link src/EntityFrameworkMigrations/ EntityFrameworkMigrations/
COPY --link src/EntityFrameworkMigrations.EFCoreStorage/ EntityFrameworkMigrations.EFCoreStorage/
COPY --link src/EntityFrameworkMigrations.WebApi/ EntityFrameworkMigrations.WebApi/

# Publica aplicação
FROM build AS publish
WORKDIR /source/EntityFrameworkMigrations.WebApi
RUN dotnet publish -a $TARGETARCH --no-restore -o /app \
    &&  rm /app/*.pdb /app/appsettings.*.json

# Imagem final de execução
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS final
ENV ASPNETCORE_HTTP_PORTS=80
EXPOSE 80
WORKDIR /app
COPY --link --from=publish /app .
USER $APP_UID
ENTRYPOINT ["./EntityFrameworkMigrations.WebApi"]