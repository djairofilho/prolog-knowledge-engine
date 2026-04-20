# Knowledge Engine para Recomendacao de Jogos

Projeto academico da disciplina de Logica e Matematica Discreta.

O objetivo e construir um motor de conhecimento em Prolog a partir de um dataset publico de jogos. A base responde perguntas por meio de fatos, regras logicas e consultas executaveis, funcionando como um recomendador simbolico baseado em conteudo.

## Tema

Sistema de recomendacao de jogos usando Prolog.

O projeto utiliza atributos como genero, preco, avaliacao, ano, plataforma, publisher e popularidade para recomendar jogos com base em regras declarativas.

## Fonte dos Dados

Fonte oficial do dataset:

- [Steam Games Dataset 2025 - Kaggle](https://www.kaggle.com/datasets/artermiloff/steam-games-dataset)

Tabela-fonte utilizada:

```text
games_march2025_cleaned.csv
```

Esse arquivo e a unica fonte de dados usada na base de conhecimento.

## Arquitetura

Fluxo principal:

```text
Dataset CSV bruto
-> limpeza e selecao de campos em Python
-> CSV tratado
-> geracao automatica de fatos Prolog
-> base de conhecimento
-> regras logicas
-> consultas executaveis
```

## Estrutura de Pastas

```text
projeto/
|-- data/
|   |-- raw/
|   |   `-- games_march2025_cleaned.csv
|   `-- processed/
|       `-- games_clean.csv
|-- docs/
|   |-- arquitetura.md
|   |-- dataset.md
|   |-- decisoes.md
|   `-- perguntas.md
|-- etl/
|   |-- clean_dataset.py
|   |-- download_dataset.py
|   `-- generate_prolog.py
|-- prolog/
|   |-- generated/
|   |   `-- base_conhecimento.pl
|   |-- src/
|   |   |-- queries.pl
|   |   `-- regras.pl
|   `-- main.pl
|-- pyproject.toml
|-- uv.lock
`-- README.md
```

## Responsabilidade dos Arquivos

### `data/raw/games_march2025_cleaned.csv`

Arquivo CSV bruto baixado da Kaggle. Ele representa a tabela-fonte unica do projeto e nao deve ser editado manualmente.

### `data/processed/games_clean.csv`

CSV tratado pelo ETL. Contem apenas os campos selecionados e padronizados para a geracao da base Prolog.

### `etl/download_dataset.py`

Baixa o arquivo `games_march2025_cleaned.csv` para `data/raw/`.

### `etl/clean_dataset.py`

Le o CSV bruto, seleciona os campos do projeto, trata ausencias, padroniza valores e gera `data/processed/games_clean.csv`.

### `etl/generate_prolog.py`

Converte o CSV tratado em fatos Prolog e gera `prolog/generated/base_conhecimento.pl`.

### `prolog/generated/base_conhecimento.pl`

Arquivo gerado automaticamente com os fatos da base.

Exemplo:

```prolog
nome(app_1145360, 'Hades').
genero(app_1145360, action).
preco(app_1145360, 73.99).
avaliacao(app_1145360, 98).
ano(app_1145360, 2020).
plataforma(app_1145360, windows).
publisher(app_1145360, supergiant_games).
popularidade(app_1145360, 251000).
```

### `prolog/src/regras.pl`

Contem as regras logicas do recomendador, como:

- jogo barato;
- jogo bem avaliado;
- jogo popular;
- recomendado por genero e plataforma;
- melhor jogo de um genero;
- destaque absoluto da base.

### `prolog/src/queries.pl`

Contem consultas executaveis para demonstracao do projeto. Alem das cinco consultas principais, o arquivo inclui uma consulta com ordenacao declarativa usando `setof/3`.

### `prolog/main.pl`

Ponto de entrada do projeto Prolog. Carrega a base gerada, as regras e as consultas.

### `docs/`

Documentacao de apoio:

- `dataset.md`: origem e recorte do dataset;
- `arquitetura.md`: organizacao do projeto;
- `decisoes.md`: criterios adotados nas regras;
- `perguntas.md`: perguntas do trabalho e sua logica.

## Campos Selecionados

O projeto trabalha com 9 campos, misturando variaveis qualitativas e quantitativas:

| Campo | Tipo | Uso |
|---|---|---|
| `game_id` | identificador | chave do jogo na base |
| `nome` | qualitativo | exibicao |
| `genero` | qualitativo | preferencia do usuario |
| `preco` | quantitativo | custo-beneficio |
| `avaliacao` | quantitativo | qualidade percebida |
| `ano` | quantitativo | recencia |
| `plataformas` | qualitativo | compatibilidade |
| `publisher` | qualitativo | contexto editorial |
| `popularidade` | quantitativo | relevancia na base |

## Como Executar

Sincronize o ambiente com `uv`:

```bash
uv sync
```

Baixe o CSV bruto da Kaggle:

```bash
uv run python etl/download_dataset.py
```

Gere o CSV tratado e a base Prolog:

```bash
uv run python etl/clean_dataset.py
uv run python etl/generate_prolog.py
```

Carregue o projeto no SWI-Prolog:

```bash
swipl -q -s prolog/main.pl
```

Se preferir abrir o interpretador primeiro:

```prolog
consult('prolog/main.pl').
```

## Regras principais

Alguns criterios da base:

- `jogo_barato/1`: preco menor ou igual a `20`;
- `jogo_preco_intermediario/1`: preco entre `20` e `50`;
- `jogo_bem_avaliado/1`: nota maior ou igual a `85`;
- `jogo_popular/1`: popularidade maior ou igual a `5000`;
- `jogo_muito_popular/1`: popularidade maior ou igual a `50000`;
- `jogo_recente/1`: ano maior ou igual a `2022`.

## Consultas do Projeto

As consultas abaixo podem ser executadas diretamente no prompt do Prolog.

### Consulta 1

Jogos `action` para `windows` recomendados pela base:

```prolog
recomendado_por_genero_e_plataforma(Jogo, action, windows), nome(Jogo, Nome).
```

Resposta esperada:

```prolog
Jogo = app_730,
Nome = 'Counter-Strike 2' ;
```

### Consulta 2

Jogos com bom custo-beneficio:

```prolog
recomendado_custo_beneficio(Jogo), nome(Jogo, Nome), preco(Jogo, Preco), avaliacao(Jogo, Nota).
```

Resposta esperada:

```prolog
Jogo = app_730,
Nome = 'Counter-Strike 2',
Preco = 0.0,
Nota = 86 ;
```

### Consulta 3

Lancamentos promissores para `windows`:

```prolog
recomendado_lancamento_promissor(Jogo, windows), nome(Jogo, Nome), ano(Jogo, Ano).
```

Resposta esperada:

```prolog
Jogo = app_2358720,
Nome = 'Black Myth: Wukong',
Ano = 2024 ;
```

### Consulta 4

Melhor jogo de `rpg` segundo os criterios da base:

```prolog
melhor_do_genero(rpg, Jogo), nome(Jogo, Nome), avaliacao(Jogo, Nota), popularidade(Jogo, Popularidade).
```

Resposta esperada:

```prolog
Jogo = app_1113000,
Nome = 'Persona 4 Golden',
Nota = 97,
Popularidade = 64224.
```

### Consulta 5

Destaques absolutos da base:

```prolog
recomendado_destaque(Jogo), nome(Jogo, Nome), avaliacao(Jogo, Nota), popularidade(Jogo, Popularidade).
```

Resposta esperada:

```prolog
Jogo = app_105600,
Nome = 'Terraria',
Nota = 97,
Popularidade = 1102434 ;
```

As consultas acima sao as mesmas documentadas em `prolog/src/queries.pl`, para facilitar a demonstracao no SWI-Prolog.

## Dicas de uso no SWI-Prolog

- digite `;` para pedir mais respostas quando a consulta nao retorna lista pronta;
- use `make.` para recarregar os arquivos apos alguma alteracao;
- use `halt.` para sair do interpretador.

## Relacao com o enunciado

O projeto foi estruturado para atender ao trabalho da disciplina:

- uma unica tabela-fonte do dataset publico;
- entre 6 e 10 campos selecionados;
- mistura de atributos qualitativos e quantitativos;
- ETL em Python;
- base gerada automaticamente em Prolog;
- perguntas respondidas com consultas em Prolog;
- regras que vao alem de filtros simples.
