# Perguntas do Projeto

As perguntas abaixo exploram a base de conhecimento de forma mais rica do que filtros simples.
Elas combinam regras, comparacoes e, em um caso, ordenacao com `setof/3`.

## Pergunta 1

Quais jogos de um determinado genero e de uma determinada plataforma sao recomendados?

### Ideia logica

Combina:

- genero;
- plataforma;
- boa avaliacao;
- popularidade.

### Predicado principal

```prolog
recomendado_por_genero_e_plataforma(Jogo, Genero, Plataforma)
```

### Consulta sugerida para apresentacao

```prolog
recomendado_por_genero_e_plataforma(Jogo, action, windows), nome(Jogo, Nome)
```

## Pergunta 2

Quais jogos apresentam bom custo-beneficio?

### Ideia logica

Combina:

- jogo barato ou de preco intermediario;
- jogo bem avaliado;
- jogo popular.

### Predicado principal

```prolog
recomendado_custo_beneficio(Jogo)
```

### Consulta sugerida para apresentacao

```prolog
recomendado_custo_beneficio(Jogo), nome(Jogo, Nome), preco(Jogo, Preco), avaliacao(Jogo, Nota)
```

## Pergunta 3

Quais jogos recentes devem ser recomendados para uma plataforma especifica?

### Ideia logica

Combina:

- ano recente;
- boa avaliacao;
- popularidade;
- plataforma.

### Predicado principal

```prolog
recomendado_lancamento_promissor(Jogo, Plataforma)
```

### Consulta sugerida para apresentacao

```prolog
recomendado_lancamento_promissor(Jogo, windows), nome(Jogo, Nome), ano(Jogo, Ano)
```

## Pergunta 4

Qual e o melhor jogo de um genero segundo a base?

### Ideia logica

Essa pergunta exige comparacao entre candidatos.

O melhor jogo e definido como aquele que:

- pertence ao genero consultado;
- e popular dentro da base;
- nao possui outro jogo do mesmo genero com avaliacao maior;
- em caso de empate, vence o mais popular.

### Predicado principal

```prolog
melhor_do_genero(Genero, Jogo)
```

### Consulta sugerida para apresentacao

```prolog
melhor_do_genero(rpg, Jogo), nome(Jogo, Nome), avaliacao(Jogo, Nota), popularidade(Jogo, Popularidade)
```

## Pergunta 5

Quais jogos excelentes e muito populares valem recomendacao imediata?

### Ideia logica

Combina:

- avaliacao muito alta;
- grande popularidade.

### Predicado principal

```prolog
recomendado_destaque(Jogo)
```

### Consulta sugerida para apresentacao

```prolog
recomendado_destaque(Jogo), nome(Jogo, Nome), avaliacao(Jogo, Nota), popularidade(Jogo, Popularidade)
```

## Consulta extra para fortalecer a entrega

Quais sao os jogos mais fortes de um genero quando ordenamos os candidatos por avaliacao e popularidade?

### Ideia logica

Essa consulta adiciona ordenacao explicita sobre a base:

- seleciona apenas jogos populares do genero informado;
- monta tuplas com nota, popularidade e nome;
- usa `setof/3` para gerar uma lista ordenada;
- inverte a ordem para destacar os melhores primeiro.

### Predicados

```prolog
ranking_genero(Genero, RankingDesc)
top_3_do_genero(Genero, Top3)
```

## Observacao

As perguntas principais demonstram:

- composicao de regras;
- comparacao numerica;
- uso de predicados auxiliares;
- selecao por multiplos criterios.

A consulta extra reforca o criterio de sofisticacao ao incluir ordenacao declarativa com Prolog.

As consultas auxiliares `consulta_1/1` ate `consulta_5/1` continuam uteis para gerar listas agregadas durante testes e demonstracoes.
