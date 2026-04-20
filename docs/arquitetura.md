# Arquitetura

## Visao Geral

O projeto segue um fluxo simples e academico:

```text
Dataset CSV bruto
        ->
ETL em Python
        ->
CSV tratado
        ->
Geracao automatica de fatos Prolog
        ->
Base de conhecimento
        ->
Regras logicas
        ->
Queries
```

## Separacao de Responsabilidades

### `data/raw/`

Guarda o dataset original baixado da fonte publica.

### `data/processed/`

Guarda os dados tratados prontos para alimentar a base de conhecimento.

### `etl/`

Guarda os scripts Python de download, limpeza e geracao da base Prolog.

### `prolog/generated/`

Guarda arquivos gerados automaticamente, principalmente a base de fatos.

Esses arquivos nao devem ser editados manualmente.

### `prolog/src/`

Guarda os arquivos escritos manualmente com regras e queries.

### `prolog/main.pl`

Arquivo central para carregar toda a estrutura Prolog do projeto.

## Beneficio da Estrutura

Essa organizacao deixa claro o que foi:

- baixado;
- tratado;
- gerado automaticamente;
- escrito manualmente como parte da modelagem logica.
