EntityFramework Sample Migrations
=================================

Este é um exemplo de desenvolvimento .NET usando [EntityFrameworkCore](https://github.com/dotnet/efcore)
com suporte a migrações. Também usamos [Docker](https://www.docker.com) e exemplificamos como podemos
executar a migração em uma implantação que usa _container_.

**Requisitos:**

- .NET SDK 8
- Docker com Docker Compose

> PS: Usamos [TheCleanArch](https://hibex-solutions.github.io/TheCleanArch/) também!

# Planning

- Criar script para inicializar ambiente de desenvolvimento (inclusive com dados secretos)
- Criar Docker Compose exclusivo para execução da solução inteira
  - Aplicação
  - Migração
  - Aguardar dependências por health check
- Criar API básica
- Criar modelo de dados com migração
- Executar migração no desenvolvimento por RunMigrations no Startup
- Adicionar suporte a Swagger na API
- Executar migração de Release localmente via bundle
- Criar imagem de migração
- Executar migração em container via Docker Compose

# Desenvolvendo

Inicialize as variáveis de ambiente local:
```powershell
.\setup.ps1
```

Restaure as ferramentas e dependências:
```sh
dotnet tool restore
dotnet restore
```

Execute os testes unitários:
```sh
dotnet test
```