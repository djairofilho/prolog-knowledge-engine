# Dataset

## Fonte

Dataset publico usado:

Steam Games Dataset 2025

Link:

https://www.kaggle.com/datasets/artermiloff/steam-games-dataset

Arquivo baixado para uso local:

```text
data/raw/games_march2025_cleaned.csv
```

O arquivo bruto baixado da Kaggle nao deve ser versionado no Git, porque e grande.

## Tabela-Fonte

O projeto usa uma unica tabela-fonte:

```text
games_march2025_cleaned.csv
```

Essa versao foi escolhida porque o proprio dataset informa que ela ja remove duplicatas e versoes de playtest.

## Campos Originais Usados

Campos lidos do CSV bruto:

```text
appid
name
release_date
price
windows
mac
linux
publishers
genres
pct_pos_total
num_reviews_total
positive
negative
```

Os campos `positive` e `negative` sao usados apenas como apoio para calcular avaliacao quando `pct_pos_total` estiver ausente.

## Campos Tratados

Arquivo gerado:

```text
data/processed/games_clean.csv
```

Campos finais:

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

## Criterios de Limpeza

- Mantem apenas jogos com nome valido.
- Mantem apenas jogos com ano de lancamento valido.
- Usa o primeiro genero listado como genero principal.
- Usa o primeiro publisher listado como publisher principal.
- Converte a data de lancamento para o campo numerico `ano`.
- Cria `plataformas` a partir dos campos booleanos `windows`, `mac` e `linux`.
- Usa `pct_pos_total` como avaliacao percentual.
- Usa `positive` e `negative` como fallback para calcular avaliacao.
- Usa `num_reviews_total` como popularidade.
- Mantem apenas jogos com pelo menos 50 reviews.

## Resultado Atual

O ETL gerou:

```text
27647 registros em data/processed/games_clean.csv
27647 jogos exportados para prolog/generated/base_conhecimento.pl
```
