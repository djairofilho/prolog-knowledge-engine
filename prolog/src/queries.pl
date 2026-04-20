% Consultas executaveis para demonstracao do projeto.
% Carregue o projeto com:
% ?- consult('prolog/main.pl').

:- use_module(library(lists)).

consulta_1(Resultados) :-
    findall(
        Nome,
        (
            recomendado_por_genero_e_plataforma(Jogo, action, windows),
            nome(Jogo, Nome)
        ),
        Resultados
    ).

consulta_2(Resultados) :-
    findall(
        Nome-Preco-Nota,
        (
            recomendado_custo_beneficio(Jogo),
            nome(Jogo, Nome),
            preco(Jogo, Preco),
            avaliacao(Jogo, Nota)
        ),
        Resultados
    ).

consulta_3(Resultados) :-
    findall(
        Nome-Ano,
        (
            recomendado_lancamento_promissor(Jogo, windows),
            nome(Jogo, Nome),
            ano(Jogo, Ano)
        ),
        Resultados
    ).

consulta_4(Nome-Nota-Popularidade) :-
    melhor_do_genero(rpg, Jogo),
    nome(Jogo, Nome),
    avaliacao(Jogo, Nota),
    popularidade(Jogo, Popularidade).

consulta_5(Resultados) :-
    findall(
        Nome-Nota-Popularidade,
        (
            recomendado_destaque(Jogo),
            nome(Jogo, Nome),
            avaliacao(Jogo, Nota),
            popularidade(Jogo, Popularidade)
        ),
        Resultados
    ).

ranking_genero(Genero, RankingDesc) :-
    setof(
        Nota-Popularidade-Nome,
        Jogo^(
            genero(Jogo, Genero),
            jogo_popular(Jogo),
            nome(Jogo, Nome),
            avaliacao(Jogo, Nota),
            popularidade(Jogo, Popularidade)
        ),
        RankingAsc
    ),
    reverse(RankingAsc, RankingDesc).

top_3_do_genero(Genero, Top3) :-
    ranking_genero(Genero, Ranking),
    length(Top3, 3),
    append(Top3, _, Ranking).
