%Factorial
fact(0, 1).
fact(N,F) :- N>0,
			 N1 is N-1,
			 fact(N1, F1),
			 F is N*F1.

%Juego dados
juego_dados :-
    permutation([1,2,3,4,5,6,7,8,9], [R1,R2,R3,V1,V2,V3,A1,A2,A3]),
    gana([R1,R2,R3], [V1,V2,V3]),
    gana([V1,V2,V3], [A1,A2,A3]),
    gana([A1,A2,A3], [R1,R2,R3]),
    write([R1,R2,R3,V1,V2,V3,A1,A2,A3]), nl.
    %si poso false al final, retorna tot
    
gana(D1, D2) :- 
    findall(X-Y, (member(X, D1), member(Y, D2), X>Y), L), 
    length(L, K), K>=5.

%Exercici 1
prod([X], X).
prod([X|L], P) :-
			prod(L, P1),
			P is P1*X.

%Exercici 2
pescalar([],[],0).
pescalar([X|L1],[Y|L2],P) :-
	pescalar(L1, L2, P1),
	P is (X*Y)+P1.
	
%Exercici 3
interseccion([], _, []).

interseccion([X|L1], L2, [X|I]) :-
	member(X, L2),!,
	interseccion(L1, L2, I).
	
interseccion([X|L1], L2, I) :-
    not(member(X, L2)),
	interseccion(L1, L2, I).

%union([], L2, L2).
%union([X|L1], L2, U) :-
    %member(X, L2), !,
    %union(L1, L2, U).
%union([X|L1], L2, [X|U]) :-
    %union(L1, L2, U).
    
%union usant sort per a eliminar repetits
union(L1, L2, U) :- append(L1, L2, Ut), sort(Ut, U).
    
%Exercici 4
%last_elem([X], X) :- !.
%last_elem([_|L], X) :- last_elem(L, X).
last_elem(L, X) :- append(_, [X], L).

reverse_list([], []).
reverse_list([X|L1], S) :-
    reverse_list(L1, R1),
    append(R1,[X],S).

%reverse_list([1,2,3,4,5], X).

%Exercici 5
fib(1, 1):- !.
fib(2, 1):- !.
fib(N,F):-
    N > 2,
    N1 is N-1,
    N2 is N-2,
    fib(N1, F1),
    fib(N2, F2),
    F is F1+F2.
    
%findall(X-F, (between(1,8,X), fib(X, F)), S).

%Exercici 6
dados(P, 1, L) :-
    between(1, 6, P),
    L = [P].
dados(P, N, [X|L]) :-
    N>1,
    N1 is N-1,
    between(1,6,X),
    P1 is P-X,
    dados(P1, N1, L).
    
%Exercici 7
suma_lista(X, []) :- X = 0, !.
suma_lista(X, [T|L]):-
    suma_lista(K, L),
    X is T + K.

suma_demas([]) :- false.
suma_demas(L):-
    append(L1, [X|L2], L),
    append(L1, L2, AUX),
    suma_lista(X, AUX), !.  %! al final, pq amb 1 ja va be

%Exercici 8
suma_antes([]) :- false.
suma_antes(L) :-
     append(L1, [X|_], L),
     suma_lista(X, L1), !.

%Exercici 9

count_element(X, S, L) :-
    findall(X, member(X, L), R),
    length(R, S).

%Fa el mateix que la intersecció, però amb 2 elements
suprimir_rep([], []).

suprimir_rep([X|L], R) :-
    member(X, L), !,
    suprimir_rep(L, R).

suprimir_rep([X|L], [X|R]) :-
    suprimir_rep(L, R).
    
%card([]):- write([]).
card(L) :-
    findall([X,S], (member(X, L), count_element(X, S, L)), R),
    suprimir_rep(R, NewR),
    write(NewR).
%Si es vol escriure com a l'enunciat, canviar el suprimir

%Exercici 10
esta_ordenada([]) :- true, !.
esta_ordenada([X]) :- atomic(X), true, !.
esta_ordenada([X, A|L]):- X=<A, esta_ordenada([A|L]).

%Exercici 11
ord(L1, L2) :- permutation(L1, L2), esta_ordenada(L2).

%----------------------------------------------------------
%No va del tot. Conté repetits.
%Exercici 12
%diccionario(A,N) :-
    %subset(A, S), 
    %%length(S, N), 
    %permutation(S, P),
    %write(P).%,nl,false.

chooseNelem(_, N, _) :- N < 0, !, fail.
chooseNelem(A, N, _) :- length(A, X), X < N, !, fail.
chooseNelem(A, N, A) :- length(A, N).
chooseNelem([X|A], N, [X|C]):-
    N1 is N-1,
    chooseNelem(A, N1, C).
chooseNelem([_|A], N, C):-
    chooseNelem(A, N, C).
    
diccionario(A,N) :-
    chooseNelem(A, N, C),
    permutation(C, P),
    write(P), nl, fail.

    
%----------------------------------------------------------

%----------------------------------------------------------
%No va
%Exercici 14
sendmoremoney() :-
    between(0, 9, S), between(0, 9, E), between(0, 9, N), between(0, 9, D),
    between(0, 9, M), between(0, 9, O), between(0, 9, R), between(0, 9, Y), 
    X is S*1000 + E*100 + N*10 + D,
    Y is M*1000 + O*100 + R*10 + E,
    Z is M*10000 + O*1000 + N*100 + E*10 + Y, 
    Z is X+Y,
    not(S==E), not(E==N), not(N==D), not(D==M), not(M==O), not(O==R), not(R==Y), not(Y==S),
    write([S,E,N,D,M,O,R,Y]).
%----------------------------------------------------------

%Exercici 16
%f(_, _).

reverse_domino(f(X, Y), f(Y, X)).

%chain_domino(f(X, _), f(X, _)) :- !.
%chain_domino(f(X, _), f(_, X)) :- !.
chain_domino(f(_, X), f(X, _)) :- !.
%chain_domino(f(_, X), f(_, X)) :- !.
chain_domino(f(_, _), f(_, _)) :- fail.

domino_order([], []).
domino_order([X], [X]).
domino_order([A, B|L], [A, B| O]) :-
    chain_domino(A, B),
    domino_order([B|L], [B|O]), !.

%No s'ha de fer reverse del primer, pq sinó pot fallar
%domino_order([A, B|L], [R, B| O]) :-
    %reverse_domino(A, R),
    %chain_domino(R, B),
    %domino_order([B|L], [B|O]), !.

domino_order([A, B|L], [A, R| O]) :-
    reverse_domino(B, R),
    chain_domino(A, R),
    domino_order([R|L], [R|O]), !.
    
dom(L) :- 
    permutation(L, P),
    domino_order(P, O),
    write(O).

dom(L) :- 
    permutation(L, [X|P]),
    reverse_domino(X,R),
    domino_order([R|P], O),
    write(O).
    
dom(_) :- write("no hay cadena"), nl.
    
%----------------------------------------------------------
%No va
%Exercici 17
cancer() :-
    between(0, 10, S1), between(0, 10, N1), S1 > N1,
    T1 is N1 + S1, T1 =< 10,
    between(0, 10, S2), between(0, 10, N2), S2 > N2,
    T2 is N2 + S2, T2 =< 10,
    N is N1+N2, S is S1+S2, N > S,
    write("YES, it's true!"), nl,
    write("Group 1: Smokers = "), write(S1), write("; Non smokers = "), write(N1), nl,
    write("Group 2: Smokers = "), write(S2), write("; Non smokers = "), write(N2), nl, !.
%----------------------------------------------------------

%Exercici 20 
%problema amb []
flatten([], []) :- !.
flatten([X], [X]) :- atomic(X), !.
flatten([X], F) :- flatten(X, F).

flatten([[]|L], F) :- flatten(L, F).

flatten([X|L], F) :-
    atomic(X),!,
    flatten(L, F1),
    append([X], F1, F).
flatten([X|L], F) :-
    flatten(X, F0),
    flatten(L, F1),
    append(F0, F1, F).
    
