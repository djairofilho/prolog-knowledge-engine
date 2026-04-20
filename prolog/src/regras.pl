% Regras do sistema de recomendacao.
% Este arquivo assume que a base de fatos ja foi carregada por prolog/main.pl.

jogo_barato(Jogo) :-
    preco(Jogo, Preco),
    Preco =< 20.

jogo_preco_intermediario(Jogo) :-
    preco(Jogo, Preco),
    Preco > 20,
    Preco =< 50.

jogo_bem_avaliado(Jogo) :-
    avaliacao(Jogo, Nota),
    Nota >= 85.

jogo_excelente(Jogo) :-
    avaliacao(Jogo, Nota),
    Nota >= 90.

jogo_mal_avaliado(Jogo) :-
    avaliacao(Jogo, Nota),
    Nota =< 50.

jogo_popular(Jogo) :-
    popularidade(Jogo, Popularidade),
    Popularidade >= 5000.

jogo_muito_popular(Jogo) :-
    popularidade(Jogo, Popularidade),
    Popularidade >= 50000.

jogo_recente(Jogo) :-
    ano(Jogo, Ano),
    Ano >= 2022.

jogo_classico(Jogo) :-
    ano(Jogo, Ano),
    Ano =< 2015.

disponivel_na_plataforma(Jogo, Plataforma) :-
    plataforma(Jogo, Plataforma).

mesmo_genero(Jogo1, Jogo2) :-
    genero(Jogo1, Genero),
    genero(Jogo2, Genero),
    Jogo1 \= Jogo2.

melhor_avaliado_que(Jogo1, Jogo2) :-
    avaliacao(Jogo1, Nota1),
    avaliacao(Jogo2, Nota2),
    Nota1 > Nota2.

mais_popular_que(Jogo1, Jogo2) :-
    popularidade(Jogo1, Pop1),
    popularidade(Jogo2, Pop2),
    Pop1 > Pop2.

menos_popular_que(Jogo1, Jogo2) :-
    popularidade(Jogo1, Pop1),
    popularidade(Jogo2, Pop2),
    Pop1 < Pop2.

recomendado_custo_beneficio(Jogo) :-
    jogo_bem_avaliado(Jogo),
    jogo_popular(Jogo),
    (
        jogo_barato(Jogo)
    ;
        jogo_preco_intermediario(Jogo)
    ).

recomendado_por_genero_e_plataforma(Jogo, Genero, Plataforma) :-
    genero(Jogo, Genero),
    disponivel_na_plataforma(Jogo, Plataforma),
    jogo_bem_avaliado(Jogo),
    jogo_popular(Jogo).

recomendado_lancamento_promissor(Jogo, Plataforma) :-
    jogo_recente(Jogo),
    disponivel_na_plataforma(Jogo, Plataforma),
    jogo_bem_avaliado(Jogo),
    jogo_popular(Jogo).

recomendado_destaque(Jogo) :-
    jogo_excelente(Jogo),
    jogo_muito_popular(Jogo).

classificacao_jogo(Jogo, barato) :-
    jogo_barato(Jogo).

classificacao_jogo(Jogo, preco_intermediario) :-
    jogo_preco_intermediario(Jogo).

classificacao_jogo(Jogo, bem_avaliado) :-
    jogo_bem_avaliado(Jogo).

classificacao_jogo(Jogo, excelente) :-
    jogo_excelente(Jogo).

classificacao_jogo(Jogo, popular) :-
    jogo_popular(Jogo).

classificacao_jogo(Jogo, muito_popular) :-
    jogo_muito_popular(Jogo).

classificacao_jogo(Jogo, recente) :-
    jogo_recente(Jogo).

classificacao_jogo(Jogo, classico) :-
    jogo_classico(Jogo).

classificacao_jogo(Jogo, custo_beneficio) :-
    recomendado_custo_beneficio(Jogo).

classificacao_jogo(Jogo, destaque) :-
    recomendado_destaque(Jogo).

melhor_do_genero(Genero, Jogo) :-
    genero(Jogo, Genero),
    jogo_popular(Jogo),
    \+ (
        genero(OutroJogo, Genero),
        jogo_popular(OutroJogo),
        OutroJogo \= Jogo,
        (
            melhor_avaliado_que(OutroJogo, Jogo)
        ;
            (
                avaliacao(OutroJogo, Nota),
                avaliacao(Jogo, Nota),
                mais_popular_que(OutroJogo, Jogo)
            )
        )
    ).

pior_do_genero(Genero, Jogo) :-
    genero(Jogo, Genero),
    \+ (
        genero(OutroJogo, Genero),
        OutroJogo \= Jogo,
        (
            melhor_avaliado_que(Jogo, OutroJogo)
        ;
            (
                avaliacao(OutroJogo, Nota),
                avaliacao(Jogo, Nota),
                menos_popular_que(Jogo, OutroJogo)
            )
        )
    ).
