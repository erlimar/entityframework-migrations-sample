EntityFramewor Sample Migrations
================================

Este é um exemplo de desenvolvimento .NET com EntityFrameworkCore com suporte a
migrações. Também usamos Docker e exemplificamos como podemos executar a migração
em uma implantação que usa containers.

**Requisitos:**

- .NET SDK 8
- Docker com Docker Compose

> PS: Usamos [TheCleanArch](https://hibex-solutions.github.io/TheCleanArch/) também!

# Desenvolvendo

Restaure as ferramentas e dependências:
```sh
dotnet tool restore
dotnet restore
```

Execute os testes unitários:
```sh
dotnet test
```