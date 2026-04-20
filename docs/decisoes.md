# Decisoes do Projeto

## Objetivo da Modelagem

O projeto foi modelado como um sistema de recomendacao simbolico baseado em conteudo.

Isso significa que as recomendacoes nao sao feitas por aprendizado de maquina, mas por regras logicas em Prolog construidas a partir dos atributos dos jogos.

## Tabela-Fonte

Foi escolhida uma unica tabela-fonte do dataset:

```text
games_march2025_cleaned.csv
```

Essa tabela foi usada como origem para o ETL e para a geracao da base de conhecimento.

## Campos Utilizados

Os campos finais usados na base tratada sao:

```text
game_id
nome
genero
preco
avaliacao
ano
plataformas
publisher
popularidade
```

Esses campos misturam variaveis qualitativas e quantitativas, atendendo ao requisito do projeto.

## Criterios Logicos Adotados

Para transformar os dados em recomendacoes simbolicas, os seguintes limites foram adotados:

### Jogo barato

Um jogo e considerado barato quando:

```text
preco =< 20
```

Esse valor foi escolhido para representar jogos acessiveis e facilitar consultas de custo-beneficio.

### Jogo de preco intermediario

Um jogo e considerado de preco intermediario quando:

```text
20 < preco =< 50
```

Essa faixa ajuda a diferenciar jogos baratos de jogos premium.

### Jogo bem avaliado

Um jogo e considerado bem avaliado quando:

```text
avaliacao >= 80
```

Esse limite representa jogos com recepcao majoritariamente positiva.

### Jogo excelente

Um jogo e considerado excelente quando:

```text
avaliacao >= 90
```

Esse criterio destaca jogos com desempenho muito forte em satisfacao dos usuarios.

### Jogo popular

Um jogo e considerado popular quando:

```text
popularidade >= 10000
```

A popularidade foi baseada no numero total de reviews.

### Jogo muito popular

Um jogo e considerado muito popular quando:

```text
popularidade >= 100000
```

Esse nivel destaca jogos com grande volume de interacao no dataset.

### Jogo recente

Um jogo e considerado recente quando:

```text
ano >= 2020
```

Esse criterio permite consultas focadas em lancamentos mais novos.

## Estrategia de Recomendacao

As recomendacoes principais do projeto combinam:

- genero;
- plataforma;
- avaliacao;
- preco;
- popularidade;
- ano de lancamento.

Em vez de consultar fatos diretamente, a ideia e compor regras auxiliares como:

- `jogo_barato/1`
- `jogo_bem_avaliado/1`
- `jogo_popular/1`
- `jogo_recente/1`

E depois reutilizar essas regras em predicados mais expressivos, como:

- `recomendado_custo_beneficio/1`
- `recomendado_por_genero_e_plataforma/3`
- `recomendado_lancamento_promissor/2`

## Criterio de Desempate

Quando for necessario escolher o melhor jogo entre varios candidatos, o desempate deve seguir:

1. maior avaliacao;
2. em caso de empate, maior popularidade.

Esse criterio sera usado em consultas como melhor jogo de um genero.
