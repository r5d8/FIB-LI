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
interseccion([], L2, []).
interseccion([X|L1], L2, [X|I]) :-
	subset(L2, [X]),
	interseccion(L1, L2, I).
interseccion([X|L1], L2, I) :-
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
%dados(P, N, L):-
%    findall(, (between(1,6,X),))
