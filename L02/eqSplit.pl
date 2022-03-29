%% Write a Prolog predicate eqSplit(L,S1,S2) that, given a list of
%% integers L, splits it into two disjoint subsets S1 and S2 such that
%% the sum of the numbers in S1 is equal to the sum of S2. It should
%% behave as follows:
%%
%% ?- eqSplit([1,5,2,3,4,7],S1,S2), write(S1), write('    '), write(S2), nl, fail.
%%
%% [1,5,2,3]    [4,7]
%% [1,3,7]    [5,2,4]
%% [5,2,4]    [1,3,7]
%% [4,7]    [1,5,2,3]


% eqSplit(L,S1,S2):- ...

%sum([], S) :- S = 0, !.
sum([S], S) :- atomic(S).
sum([X|L], S) :- sum(L, S1), atomic(S1), S is S1+X.

%eqSplit([], _, []) :- false.
%eqSplit([], [], _) :- false.

%eqSplit([],S1,S2):- sum(S1, A), sum(S2, B), A = B, !.

%eqSplit([X|L],S1,S2):- S1 = [X], eqSplit(L, S1, S2).
%eqSplit([X|L],S1,S2):- S2 = [X], eqSplit(L, S1, S2).

%eqSplit([X|L],S1,S2):- append(S1, X), eqSplit(L, S1, S2).
%eqSplit([X|L],S1,S2):- append(S2, X), eqSplit(L, S1, S2).

interseccion([], _, []).

interseccion([X|L1], L2, [X|I]) :-
	member(X, L2),!,
	interseccion(L1, L2, I).
	
interseccion([_|L1], L2, I) :-
	interseccion(L1, L2, I).

disjointSubset([], _, []) :- !.
disjointSubset(L, [], L) :- !.
disjointSubset([X|L], S1, S2) :-
    member(X, S1), !,
    disjointSubset(L, S1, S2).

disjointSubset([X|L], S1, [X|S2]) :-
    disjointSubset(L, S1, S2).

eqSplit(L, S1, S2) :-   %permutation(L, L1),
                        %append(S1, S2, L1),
                        
                        subset(L, S1),
                        %subset(L, S2),
                        disjointSubset(L, S1, S2),
                        %findall(X, (member(X, S1), not(member(X, S2))), Lrep),
                        %interseccion(S1, S2, []),
                        sum(S1, A),
                        sum(S2, B),
                        A = B.
                        
