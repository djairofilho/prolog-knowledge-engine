% Consultas sugeridas para demonstracao do projeto.
% Carregue o projeto com:
% ?- consult('prolog/main.pl').

% 1. Quais jogos de action para windows sao recomendados?
% ?- recomendado_por_genero_e_plataforma(Jogo, action, windows), nome(Jogo, Nome).

% 2. Quais jogos possuem bom custo-beneficio?
% ?- recomendado_custo_beneficio(Jogo), nome(Jogo, Nome), preco(Jogo, Preco), avaliacao(Jogo, Nota).

% 3. Quais lancamentos promissores existem para windows?
% ?- recomendado_lancamento_promissor(Jogo, windows), nome(Jogo, Nome), ano(Jogo, Ano).

% 4. Qual e o melhor jogo do genero action?
% ?- melhor_do_genero(action, Jogo), nome(Jogo, Nome), avaliacao(Jogo, Nota).

% 5. Quais jogos sao destaques absolutos da base?
% ?- recomendado_destaque(Jogo), nome(Jogo, Nome), avaliacao(Jogo, Nota), popularidade(Jogo, Popularidade).
