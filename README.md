Exemplo de uso de Migrações com EntityFramework
===============================================

Este é um exemplo de desenvolvimento .NET usando [EntityFrameworkCore](https://github.com/dotnet/efcore)
com suporte a migrações. Também usamos [Docker](https://www.docker.com) e exemplificamos como podemos
executar a migração em uma implantação que usa _container_.

**Requisitos:**

- [.NET SDK 8](https://dotnet.microsoft.com/pt-br/download/dotnet/8.0)
- [Docker com Docker Compose](https://docs.docker.com/compose/)
- [PowerShell](https://github.com/PowerShell/PowerShell)

> PS: Usamos [TheCleanArch](https://hibex-solutions.github.io/TheCleanArch/) também!

# Contribuindo

## Quando acabar de obter o código

Inicialize as variáveis de ambiente local:
```powershell
.\eng\setup.ps1
```

Execute os pré-requisitos no Docker:
```sh
docker compose up -d
```

Quando os requisitos forem levantados, você terá:

- Banco de dados Postgres em localhost:5432
- Interface gerenciamento do banco: http://localhost:8080

Restaure as ferramentas e dependências:
```sh
dotnet tool restore
dotnet restore
```

## No dia a dia

### Recrie sua migração de desenvolvimento

Sempre que houver alguma mudança no modelo, ou quando você juntou
seu código (_merge_) com outro, com ou sem conflito, você precisa
atualizar a migração da versão em desenvolvimento, e sua base de
dados local.

> :warning: Lembrando que isso irá remover a última migração em
> desenvolvimento que você já tem aplicada em sua base local.

Então:
```sh
.\eng\migration-recreate-develop.ps1
```

### Libere uma nova versão da migração

Sempre que o desenvolvimento atual estiver finalizado, e então você
deseja liberar uma versão da sua aplicação, deve haver também uma
nova versão das suas migrações.

> :warning: Lembrando que isso irá remover a última migração em
> desenvolvimento que você já tem aplicada em sua base local, e irá
> recriá-la com o nome que você informar.

Então:
```sh
.\eng\migration-release.ps1 {ReleaseName}
```
