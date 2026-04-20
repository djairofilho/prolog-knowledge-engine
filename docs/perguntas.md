# Perguntas do Projeto

As perguntas abaixo foram definidas para explorar a base de conhecimento de forma mais rica do que simples filtros.

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

## Pergunta 4

Qual e o melhor jogo de um genero segundo a base?

### Ideia logica

Essa pergunta exige comparacao entre candidatos.

O melhor jogo e definido como aquele que:

- pertence ao genero consultado;
- nao possui outro jogo do mesmo genero com avaliacao maior;
- em caso de empate, vence o mais popular.

### Predicado principal

```prolog
melhor_do_genero(Genero, Jogo)
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

## Observacao

As perguntas 1, 2, 3 e 4 sao as mais importantes para a entrega, porque demonstram:

- composicao de regras;
- comparacao numerica;
- uso de predicados auxiliares;
- selecao baseada em multiplos criterios.
