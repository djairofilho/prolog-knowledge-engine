# Knowledge Engine para Recomendacao de Jogos

Projeto academico da disciplina de Logica e Matematica Discreta.

O objetivo e construir um pequeno motor de conhecimento em Prolog a partir de um dataset publico de jogos. A base deve permitir responder perguntas por meio de fatos, regras logicas e queries, funcionando como um recomendador simbolico baseado em conteudo.

## Tema

Sistema de recomendacao de jogos usando Prolog.

O sistema utiliza atributos como genero, preco, avaliacao, ano, plataforma, publisher e popularidade para recomendar jogos com base em regras declarativas.

## Fonte dos Dados

Dataset utilizado:

[Steam Games Dataset 2025 (Kaggle)](https://www.kaggle.com/datasets/artermiloff/steam-games-dataset)

Tabela-fonte utilizada no projeto:

```text
games_march2025_cleaned.csv
```

Esse arquivo pertence ao dataset acima e foi escolhido como fonte unica da base de conhecimento.

## Arquitetura

Fluxo principal do projeto:

```text
Dataset CSV bruto
        ↓
Limpeza e selecao de campos em Python
        ↓
CSV tratado
        ↓
Geracao automatica de fatos Prolog
        ↓
Base de conhecimento
        ↓
Regras logicas
        ↓
Queries de recomendacao
```

## Estrutura de Pastas

```text
projeto/
│
├── data/
│   ├── raw/
│   │   └── games.csv
│   │
│   └── processed/
│       └── games_clean.csv
│
├── etl/
│   ├── download_dataset.py
│   ├── clean_dataset.py
│   └── generate_prolog.py
│
├── prolog/
│   ├── generated/
│   │   └── base_conhecimento.pl
│   ├── src/
│   │   ├── regras.pl
│   │   └── queries.pl
│   └── main.pl
│
├── docs/
│   ├── arquitetura.md
│   ├── dataset.md
│   ├── perguntas.md
│   └── decisoes.md
│
└── README.md
```

## Responsabilidade dos Arquivos

### `data/raw/games.csv`

Arquivo CSV original do dataset publico.

Este arquivo deve representar a tabela-fonte escolhida para o projeto. A ideia e manter o dado bruto separado dos dados tratados.

### `data/processed/games_clean.csv`

Arquivo CSV tratado, gerado pelo script de limpeza.

Deve conter apenas os campos selecionados para o projeto, ja padronizados e prontos para serem convertidos em fatos Prolog.

### `etl/clean_dataset.py`

Script Python responsavel por:

- ler o CSV bruto;
- selecionar entre 6 e 10 campos;
- tratar valores ausentes;
- padronizar textos;
- converter dados numericos;
- gerar `data/processed/games_clean.csv`.

### `etl/download_dataset.py`

Script Python responsavel por baixar o arquivo `games_march2025_cleaned.csv` do dataset da Kaggle para `data/raw/`.

O dataset bruto e grande, por isso nao deve ser versionado no Git.

### `etl/generate_prolog.py`

Script Python responsavel por:

- ler `data/processed/games_clean.csv`;
- transformar cada jogo em fatos Prolog;
- gerar ou atualizar `prolog/generated/base_conhecimento.pl`.

### `prolog/generated/base_conhecimento.pl`

Arquivo com os fatos Prolog gerados automaticamente.

Exemplo esperado:

```prolog
nome(hades, 'Hades').
genero(hades, roguelike).
preco(hades, 49.99).
avaliacao(hades, 97).
ano(hades, 2020).
plataforma(hades, pc).
publisher(hades, supergiant_games).
popularidade(hades, 120000).
```

### `prolog/src/regras.pl`

Arquivo com as regras logicas do recomendador.

Exemplos de regras que podem existir:

```prolog
jogo_bem_avaliado(Jogo) :-
    avaliacao(Jogo, Nota),
    Nota >= 85.

jogo_barato(Jogo) :-
    preco(Jogo, Preco),
    Preco =< 30.

recomendado_custo_beneficio(Jogo) :-
    jogo_bem_avaliado(Jogo),
    jogo_barato(Jogo).
```

### `prolog/src/queries.pl`

Arquivo com perguntas de exemplo para testar o sistema.

Exemplos:

```prolog
% Quais jogos tem bom custo-beneficio?
% recomendado_custo_beneficio(Jogo), nome(Jogo, Nome).

% Quais jogos de RPG sao bem avaliados?
% genero(Jogo, rpg), jogo_bem_avaliado(Jogo), nome(Jogo, Nome).
```

### `prolog/main.pl`

Arquivo principal para carregar toda a base Prolog do projeto.

Ele deve consultar:

- a base gerada em `prolog/generated/`;
- as regras em `prolog/src/`;
- as queries em `prolog/src/`.

### `docs/dataset.md`

Anotacoes sobre o dataset usado:

- fonte;
- link;
- tabela escolhida;
- campos originais;
- campos selecionados;
- criterios de limpeza.

### `docs/arquitetura.md`

Documento com a explicacao da arquitetura do projeto e da separacao entre ETL, base gerada e logica escrita manualmente.

### `docs/perguntas.md`

Documento para registrar as perguntas respondidas pelo sistema.

O projeto deve ter pelo menos 3 perguntas implementadas em Prolog. Para uma entrega mais forte, elas devem usar composicao de regras, comparacoes, agregacoes ou ordenacao.

### `docs/decisoes.md`

Registro das principais decisoes do projeto, como:

- campos escolhidos;
- criterios para considerar um jogo barato;
- criterios para considerar um jogo bem avaliado;
- regras de recomendacao adotadas.

## Campos Sugeridos

Uma selecao inicial equilibrada entre variaveis qualitativas e quantitativas:

| Campo | Tipo | Uso |
|---|---|---|
| `game_id` | identificador | chave do jogo no Prolog |
| `nome` | qualitativo | nome exibido |
| `genero` | qualitativo | recomendacao por preferencia |
| `preco` | quantitativo | filtros de orcamento |
| `avaliacao` | quantitativo | qualidade percebida |
| `ano` | quantitativo | jogos recentes ou classicos |
| `plataforma` | qualitativo | compatibilidade |
| `publisher` | qualitativo | afinidade com empresa |
| `popularidade` | quantitativo | numero de avaliacoes ou reviews |

## Passos pensados para fazer atividade

1. Escolher o dataset publico de jogos.
2. Colocar o arquivo original em `data/raw/games.csv`.
3. Definir os campos oficiais do projeto.
4. Implementar `etl/clean_dataset.py`.
5. Gerar `data/processed/games_clean.csv`.
6. Implementar `etl/generate_prolog.py`.
7. Gerar `prolog/generated/base_conhecimento.pl`.
8. Implementar regras em `prolog/src/regras.pl`.
9. Escrever pelo menos 3 perguntas em `prolog/src/queries.pl`.
10. Documentar dataset, perguntas e decisoes em `docs/`.

## Como Executar

Sincronize o ambiente com `uv`:

```bash
uv sync
```

Baixe o CSV bruto da Kaggle:

```bash
uv run python etl/download_dataset.py
```

Fonte oficial do dataset:

[Steam Games Dataset 2025 (Kaggle)](https://www.kaggle.com/datasets/artermiloff/steam-games-dataset)

Gere o CSV tratado e a base Prolog:

```bash
uv run python etl/clean_dataset.py
uv run python etl/generate_prolog.py
```

No SWI-Prolog:

```prolog
consult('prolog/main.pl').
```

Depois execute as queries documentadas em `prolog/src/queries.pl`.

Em modo de linha de comando, um comando valido e:

```bash
swipl -q -s prolog/main.pl
```

## Como Executar as Queries

1. Abra o projeto no terminal.
2. Inicie o SWI-Prolog:

```bash
swipl -q -s prolog/main.pl
```

3. No prompt do Prolog, execute consultas como estas:

```prolog
recomendado_custo_beneficio(Jogo), nome(Jogo, Nome).
```

Resposta esperada:

```prolog
Jogo = app_730,
Nome = 'Counter-Strike 2' ;
```

```prolog
recomendado_por_genero_e_plataforma(Jogo, action, windows), nome(Jogo, Nome).
```

Resposta esperada:

```prolog
Jogo = app_730,
Nome = 'Counter-Strike 2' ;
```

```prolog
recomendado_lancamento_promissor(Jogo, windows), nome(Jogo, Nome).
```

Resposta esperada:

```prolog
Jogo = app_730449,
Nome = 'Black Myth: Wukong' ;
```

```prolog
melhor_do_genero(rpg, Jogo), nome(Jogo, Nome).
```

Resposta esperada:

```prolog
Jogo = app_1113000,
Nome = 'Persona 4 Golden'.
```

```prolog
recomendado_destaque(Jogo), nome(Jogo, Nome).
```

Resposta esperada:

```prolog
Jogo = app_105600,
Nome = 'Terraria' ;
```

Observacao:

- o Prolog normalmente mostra uma resposta por vez;
- digite `;` para pedir a proxima;
- pressione Enter para encerrar a consulta atual.

4. Para recarregar os arquivos depois de alguma alteracao:

```prolog
make.
```

5. Para sair do SWI-Prolog:

```prolog
halt.
```

## Boas Praticas

- Manter `data/raw/games.csv` sem alteracoes manuais.
- Gerar `data/processed/games_clean.csv` sempre via ETL.
- Gerar `prolog/generated/base_conhecimento.pl` automaticamente.
- Separar arquivos gerados de arquivos escritos manualmente.
- Usar nomes normalizados para identificadores Prolog.
- Criar regras compostas, nao apenas filtros simples.
- Manter a arquitetura pequena, clara e facil de apresentar.
