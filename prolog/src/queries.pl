% Consultas sugeridas para demonstracao do projeto.
% Carregue o projeto com:
% ?- consult('prolog/main.pl').

query1(Lista) :-
    findall(
        Nome,
        (
            recomendado_por_genero_e_plataforma(Jogo, action, windows),
            nome(Jogo, Nome)
        ),
        Lista
    ).

% 1. Quais jogos de action para windows sao recomendados?
% ?- query1(Lista).
% Executa:
% ?- findall(Nome, (recomendado_por_genero_e_plataforma(Jogo, action, windows), nome(Jogo, Nome)), Lista).
% Resposta esperada:
% Lista = ['Counter-Strike 2', 'Grand Theft Auto V Legacy', 'Team Fortress 2' | ...].

% 2. Quais jogos possuem bom custo-beneficio?
% ?- findall(Nome-Preco-Nota, (recomendado_custo_beneficio(Jogo), nome(Jogo, Nome), preco(Jogo, Preco), avaliacao(Jogo, Nota)), Lista).

% 3. Quais lancamentos promissores existem para windows?
% ?- findall(Nome-Ano, (recomendado_lancamento_promissor(Jogo, windows), nome(Jogo, Nome), ano(Jogo, Ano)), Lista).

% 4. Qual e o melhor jogo do genero rpg?
% ?- melhor_do_genero(rpg, Jogo), nome(Jogo, Nome), avaliacao(Jogo, Nota), popularidade(Jogo, Popularidade).

% 5. Quais jogos sao destaques absolutos da base?
% ?- findall(Nome-Nota-Popularidade, (recomendado_destaque(Jogo), nome(Jogo, Nome), avaliacao(Jogo, Nota), popularidade(Jogo, Popularidade)), Lista).

% 6. Como um jogo especifico se classifica na base?
% ?- setof(Classificacao, Jogo^(nome(Jogo, 'Black Myth: Wukong'), classificacao_jogo(Jogo, Classificacao)), Lista).

% 7. Qual e o pior jogo do genero rpg?
% ?- pior_do_genero(rpg, Jogo), nome(Jogo, Nome), avaliacao(Jogo, Nota), popularidade(Jogo, Popularidade).
