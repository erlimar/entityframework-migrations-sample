# Como contribuir com o projeto

Aqui você encontra informações sobre como desenvolver o projeto, e quaisquer
outras informações relevantes a um contribuidor.

## Primeiros passos

Assim que você obter o código do projeto para iniciar suas contribuições,
deve executar minimamente esses passos:

1. Inicialize as variáveis de ambiente locais:
```powershell
.\eng\scripts\setup.ps1
```

2. Execute o _Docker Compose_ para provisionar os pré-requisitos:
```sh
docker compose --env-file db.env  -f ./eng/docker/docker-compose.requirements.yaml up -d
```

Executados os passos 1 e 2 com sucesso, você terá:

- Banco de dados Postgres em localhost:5432
- Interface gerenciamento do banco: http://localhost:8080

3. Restaure as ferramentas e dependências do projeto para começar a codificar:
```sh
dotnet tool restore
dotnet restore
```

## No dia a dia

No dia a dia você repetirá uma série de tarefas dependendo do momento.

### Recrie sua migração de desenvolvimento

Sempre que houver alguma mudança no modelo, ou quando você juntou
seu código (_merge_) com outro, com ou sem conflito, você precisa
atualizar a migração da versão em desenvolvimento, e sua base de
dados local.

> :warning: Lembrando que isso irá remover a última migração em
> desenvolvimento que você já tem aplicada em sua base local.

Então:
```sh
.\eng\scripts\migration-recreate-develop.ps1
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
.\eng\scripts\migration-release.ps1 {ReleaseName}
```

## Teste a solução completa em containers

Se quiser ver a solução funcionando de forma completa, recomendamos executar
o _Docker Compose_ específico para isso.

> :information_source: Recomendamos estar com todos os recursos do Docker
> zerados (volume de banco vazio, nenhuma imagem do projeto anterior, etc.)
> para replicar um cenário de execução da aplicação de forma independente. 

```sh
docker compose --env-file db.env -f ./eng/docker/docker-compose.app.yaml up -d
```

Feito isso você terá:

- Web API da aplicação disponível em http://localhost:8080
- Use os endpoints descritos em `src/EntityFrameworkMigrations.WebApi/WebApi.http` para testar
