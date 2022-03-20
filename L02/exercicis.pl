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
interseccion([], _, []).    %Mid is L2
interseccion([X|L1], L2, [X|I]) :-
	subset(L2, [X]),
	interseccion(L1, L2, I).
interseccion([_|L1], L2, I) :-
	%false = subset(L2, [X]),
	interseccion(L1, L2, I).
	

%Exercici 4
last_elem([X], X) :- !.
last_elem([_|L], X) :- last_elem(L, X).

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

%----------------------------------------------------------
%No va
%Exercici 9

count_element(X, S, L) :-
    findall(X, member(X, L), R),
    length(R, S).

%card([]):- write([]).
card(L) :-
    findall([X,S], count_element(X, S, L), R),
    write(R).
%----------------------------------------------------------

%Exercici 10
esta_ordenada([]) :- true, !.
esta_ordenada([X]) :- atomic(X), true, !.
esta_ordenada([X, A|L]):- X=<A, esta_ordenada([A|L]).

%Exercici 11
ord(L1, L2) :- permutation(L1, L2), esta_ordenada(L2).

%----------------------------------------------------------
%No va
%Exercici 12
diccionario(A,N) :-
    subset(A, S), 
    length(S, N), 
    permutation(S, P),
    write(P).%,nl,false.
%----------------------------------------------------------

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

    
    
    
    
