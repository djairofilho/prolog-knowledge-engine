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

### Nome da query

```prolog
recomendados_action_windows(Lista).
```

### Por dentro da query

```prolog
findall(Nome, (recomendado_por_genero_e_plataforma(Jogo, action, windows), nome(Jogo, Nome)), Lista).
```

### Resultado da query

```prolog
Lista = ['Counter-Strike 2', 'Grand Theft Auto V Legacy', 'Team Fortress 2' | ...].
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

### Nome da query

```prolog
recomendados_custo_beneficio(Lista).
```

### Por dentro da query

```prolog
findall(Nome-Preco-Nota, (recomendado_custo_beneficio(Jogo), nome(Jogo, Nome), preco(Jogo, Preco), avaliacao(Jogo, Nota)), Lista).
```

### Resultado da query

```prolog
Lista = ['Counter-Strike 2'-0.0-86, 'Grand Theft Auto V Legacy'-0.0-87, 'Team Fortress 2'-0.0-89 | ...].
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

### Nome da query

```prolog
lancamentos_promissores_windows(Lista).
```

### Por dentro da query

```prolog
findall(Nome-Ano, (recomendado_lancamento_promissor(Jogo, windows), nome(Jogo, Nome), ano(Jogo, Ano)), Lista).
```

### Resultado da query

```prolog
Lista = ['Black Myth: Wukong'-2024, 'ELDEN RING'-2022, 'Baldur''s Gate 3'-2023 | ...].
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

### Nome da query

```prolog
melhor_jogo_rpg(Nome, Nota, Popularidade).
```

### Por dentro da query

```prolog
melhor_do_genero(rpg, Jogo), nome(Jogo, Nome), avaliacao(Jogo, Nota), popularidade(Jogo, Popularidade).
```

### Resultado da query

```prolog
Nome = 'Persona 4 Golden',
Nota = 97,
Popularidade = 64224.
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

### Nome da query

```prolog
destaques_absolutos(Lista).
```

### Por dentro da query

```prolog
findall(Nome-Nota-Popularidade, (recomendado_destaque(Jogo), nome(Jogo, Nome), avaliacao(Jogo, Nota), popularidade(Jogo, Popularidade)), Lista).
```

### Resultado da query

```prolog
Lista = ['Terraria'-97-1102434, 'Garry''s Mod'-96-985010, 'Black Myth: Wukong'-96-825621 | ...].
```

## Pergunta 6

Como um jogo especifico se classifica na base?

### Ideia logica

Essa pergunta agrega varios rotulos logicos para o mesmo jogo:

- avalia o jogo contra varios predicados auxiliares;
- transforma as condicoes verdadeiras em classificacoes simbolicas;
- usa `setof/3` para devolver uma lista ordenada e sem repeticoes.

### Predicado principal

```prolog
classificacao_jogo(Jogo, Classificacao)
```

### Nome da query

```prolog
classificacoes_black_myth_wukong(Lista).
```

### Por dentro da query

```prolog
setof(Classificacao, Jogo^(nome(Jogo, 'Black Myth: Wukong'), classificacao_jogo(Jogo, Classificacao)), Lista).
```

### Resultado da query

```prolog
Lista = [bem_avaliado, destaque, excelente, muito_popular, popular, recente].
```

## Pergunta 7

Qual e o pior jogo de um genero segundo a base?

### Ideia logica

Essa pergunta espelha a busca pelo melhor jogo, mas agora procura o pior candidato:

- pertence ao genero consultado;
- nao existe outro jogo do mesmo genero com avaliacao ainda menor;
- em caso de empate, vence o menos popular.

### Predicado principal

```prolog
pior_do_genero(Genero, Jogo)
```

### Nome da query

```prolog
pior_jogo_rpg(Nome, Nota, Popularidade).
```

### Por dentro da query

```prolog
pior_do_genero(rpg, Jogo), nome(Jogo, Nome), avaliacao(Jogo, Nota), popularidade(Jogo, Popularidade).
```

### Resultado da query

```prolog
Nome = 'Shallow Space',
Nota = 23,
Popularidade = 181.
```

## Observacao final

As perguntas do projeto demonstram:

- composicao de regras;
- comparacao numerica;
- uso de predicados auxiliares;
- selecao por multiplos criterios.
