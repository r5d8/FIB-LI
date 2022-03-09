%Factorial
fact(0, 1).
fact(N,F) :- N>0,
			 N1 is N-1,
			 fact(N1, F1),
			 F is N*F1.
			 
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

reverse_using_last([],[]) :- !
reverse_using_last([X], X) :- atomic(X), !.
reverse_using_last(L, R) :-
    last_elem(L, X),
    append(L1, X, L),
    reverse_using_last(L1, R1),
    append([X], R1, R).

%reverse_list([1,2,3,4,5], X).
