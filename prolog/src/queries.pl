% Consultas sugeridas para demonstracao do projeto.
% Carregue o projeto com:
% ?- consult('prolog/main.pl').

recomendados_action_windows(Lista) :-
    findall(
        Nome,
        (
            recomendado_por_genero_e_plataforma(Jogo, action, windows),
            nome(Jogo, Nome)
        ),
        Lista
    ).

recomendados_custo_beneficio(Lista) :-
    findall(
        Nome-Preco-Nota,
        (
            recomendado_custo_beneficio(Jogo),
            nome(Jogo, Nome),
            preco(Jogo, Preco),
            avaliacao(Jogo, Nota)
        ),
        Lista
    ).

lancamentos_promissores_windows(Lista) :-
    findall(
        Nome-Ano,
        (
            recomendado_lancamento_promissor(Jogo, windows),
            nome(Jogo, Nome),
            ano(Jogo, Ano)
        ),
        Lista
    ).

melhor_jogo_rpg(Nome, Nota, Popularidade) :-
    melhor_do_genero(rpg, Jogo),
    nome(Jogo, Nome),
    avaliacao(Jogo, Nota),
    popularidade(Jogo, Popularidade).

destaques_absolutos(Lista) :-
    findall(
        Nome-Nota-Popularidade,
        (
            recomendado_destaque(Jogo),
            nome(Jogo, Nome),
            avaliacao(Jogo, Nota),
            popularidade(Jogo, Popularidade)
        ),
        Lista
    ).

classificacoes_black_myth_wukong(Lista) :-
    setof(
        Classificacao,
        Jogo^(
            nome(Jogo, 'Black Myth: Wukong'),
            classificacao_jogo(Jogo, Classificacao)
        ),
        Lista
    ).

pior_jogo_rpg(Nome, Nota, Popularidade) :-
    pior_do_genero(rpg, Jogo),
    nome(Jogo, Nome),
    avaliacao(Jogo, Nota),
    popularidade(Jogo, Popularidade).

% Query 1 - Jogos action para windows recomendados pela base
% recomendados_action_windows(Lista).
% Executa:
% findall(Nome, (recomendado_por_genero_e_plataforma(Jogo, action, windows), nome(Jogo, Nome)), Lista).
% Resultado esperado:
% Lista = ['Counter-Strike 2', 'Grand Theft Auto V Legacy', 'Team Fortress 2' | ...].

% Query 2 - Jogos com bom custo-beneficio
% recomendados_custo_beneficio(Lista).
% Executa:
% findall(Nome-Preco-Nota, (recomendado_custo_beneficio(Jogo), nome(Jogo, Nome), preco(Jogo, Preco), avaliacao(Jogo, Nota)), Lista).
% Resultado esperado:
% Lista = ['Counter-Strike 2'-0.0-86, 'Grand Theft Auto V Legacy'-0.0-87, 'Team Fortress 2'-0.0-89 | ...].

% Query 3 - Lancamentos promissores para windows
% lancamentos_promissores_windows(Lista).
% Executa:
% findall(Nome-Ano, (recomendado_lancamento_promissor(Jogo, windows), nome(Jogo, Nome), ano(Jogo, Ano)), Lista).
% Resultado esperado:
% Lista = ['Black Myth: Wukong'-2024, 'ELDEN RING'-2022, 'Baldur''s Gate 3'-2023 | ...].

% Query 4 - Melhor jogo de rpg
% melhor_jogo_rpg(Nome, Nota, Popularidade).
% Executa:
% melhor_do_genero(rpg, Jogo), nome(Jogo, Nome), avaliacao(Jogo, Nota), popularidade(Jogo, Popularidade).
% Resultado esperado:
% Nome = 'Persona 4 Golden',
% Nota = 97,
% Popularidade = 64224.

% Query 5 - Destaques absolutos da base
% destaques_absolutos(Lista).
% Executa:
% findall(Nome-Nota-Popularidade, (recomendado_destaque(Jogo), nome(Jogo, Nome), avaliacao(Jogo, Nota), popularidade(Jogo, Popularidade)), Lista).
% Resultado esperado:
% Lista = ['Terraria'-97-1102434, 'Garry''s Mod'-96-985010, 'Black Myth: Wukong'-96-825621 | ...].

% Query 6 - Classificacao de um jogo especifico
% classificacoes_black_myth_wukong(Lista).
% Executa:
% setof(Classificacao, Jogo^(nome(Jogo, 'Black Myth: Wukong'), classificacao_jogo(Jogo, Classificacao)), Lista).
% Resultado esperado:
% Lista = [bem_avaliado, destaque, excelente, muito_popular, popular, recente].

% Query 7 - Pior jogo de rpg
% pior_jogo_rpg(Nome, Nota, Popularidade).
% Executa:
% pior_do_genero(rpg, Jogo), nome(Jogo, Nome), avaliacao(Jogo, Nota), popularidade(Jogo, Popularidade).
% Resultado esperado:
% Nome = 'Shallow Space',
% Nota = 23,
% Popularidade = 181.
