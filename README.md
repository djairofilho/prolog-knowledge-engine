# Knowledge Engine para Recomendacao de Jogos

Projeto academico da disciplina de Logica e Matematica Discreta.

O objetivo e construir um pequeno motor de conhecimento em Prolog a partir de um dataset publico de jogos. A base deve permitir responder perguntas por meio de fatos, regras logicas e queries, funcionando como um recomendador simbolico baseado em conteudo.

## Tema

Sistema de recomendacao de jogos usando Prolog.

O sistema utiliza atributos como genero, preco, avaliacao, ano, plataforma, publisher e popularidade para recomendar jogos com base em regras declarativas.

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
│   ├── clean_dataset.py
│   └── generate_prolog.py
│
├── prolog/
│   ├── base_conhecimento.pl
│   ├── regras.pl
│   └── queries.pl
│
├── docs/
│   ├── dataset.md
│   ├── perguntas.md
│   └── decisoes.md
│
├── PROJETO_IA.md
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

### `etl/generate_prolog.py`

Script Python responsavel por:

- ler `data/processed/games_clean.csv`;
- transformar cada jogo em fatos Prolog;
- gerar ou atualizar `prolog/base_conhecimento.pl`.

### `prolog/base_conhecimento.pl`

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

### `prolog/regras.pl`

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

### `prolog/queries.pl`

Arquivo com perguntas de exemplo para testar o sistema.

Exemplos:

```prolog
% Quais jogos tem bom custo-beneficio?
% recomendado_custo_beneficio(Jogo), nome(Jogo, Nome).

% Quais jogos de RPG sao bem avaliados?
% genero(Jogo, rpg), jogo_bem_avaliado(Jogo), nome(Jogo, Nome).
```

### `docs/dataset.md`

Anotacoes sobre o dataset usado:

- fonte;
- link;
- tabela escolhida;
- campos originais;
- campos selecionados;
- criterios de limpeza.

### `docs/perguntas.md`

Documento para registrar as perguntas respondidas pelo sistema.

O projeto deve ter pelo menos 3 perguntas implementadas em Prolog. Para uma entrega mais forte, elas devem usar composicao de regras, comparacoes, agregacoes ou ordenacao.

### `docs/decisoes.md`

Registro das principais decisoes do projeto, como:

- campos escolhidos;
- criterios para considerar um jogo barato;
- criterios para considerar um jogo bem avaliado;
- regras de recomendacao adotadas.

### `PROJETO_IA.md`

Arquivo de contexto para orientar uma IA ou assistente de codigo sobre o projeto, sua arquitetura e proximos passos.

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

## Ordem Recomendada de Implementacao

1. Escolher o dataset publico de jogos.
2. Colocar o arquivo original em `data/raw/games.csv`.
3. Definir os campos oficiais do projeto.
4. Implementar `etl/clean_dataset.py`.
5. Gerar `data/processed/games_clean.csv`.
6. Implementar `etl/generate_prolog.py`.
7. Gerar `prolog/base_conhecimento.pl`.
8. Implementar regras em `prolog/regras.pl`.
9. Escrever pelo menos 3 perguntas em `prolog/queries.pl`.
10. Documentar dataset, perguntas e decisoes em `docs/`.

## Como Executar

Depois que os scripts forem implementados:

```bash
python etl/clean_dataset.py
python etl/generate_prolog.py
```

No SWI-Prolog:

```prolog
consult('prolog/regras.pl').
```

Depois execute as queries documentadas em `prolog/queries.pl`.

## Boas Praticas

- Manter `data/raw/games.csv` sem alteracoes manuais.
- Gerar `data/processed/games_clean.csv` sempre via ETL.
- Gerar `prolog/base_conhecimento.pl` automaticamente.
- Separar fatos, regras e queries em arquivos diferentes.
- Usar nomes normalizados para identificadores Prolog.
- Criar regras compostas, nao apenas filtros simples.
- Manter a arquitetura pequena, clara e facil de apresentar.

