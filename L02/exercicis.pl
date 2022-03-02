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
	
			
