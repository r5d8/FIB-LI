:- use_module(library(clpfd)).

%ejemplo(_, Big, [S1...SN]): how to fit all squares of sizes S1...SN in a square of size Big?
ejemplo(0,  3,[2,1,1,1,1,1]).
ejemplo(1,  4,[2,2,2,1,1,1,1]).
ejemplo(2,  5,[3,2,2,2,1,1,1,1]).
ejemplo(3, 19,[10,9,7,6,4,4,3,3,3,3,3,2,2,2,1,1,1,1,1,1]).
ejemplo(4, 40,[24,16,16,10,9,8,8,7,7,6,6,3,3,3,2,1,1]).   %<-- aquest ja costa bastant de resoldre...

%Aquests dos ultims son molt durs!!! No et sortirÃ n amb aquesta tÃ¨cnica!!
%Aviat proporcionarem una tÃ¨cnica alternativa per resoldre aquests.
ejemplo(5,112,[50,42,37,35,33,29,27,25,24,19,18,17,16,15,11,9,8,7,6,4,2]).
ejemplo(6,175,[81,64,56,55,51,43,39,38,35,33,31,30,29,20,18,16,14,9,8,5,4,3,2,1]).


%% Possible output solution for example 3:
%%  10 10 10 10 10 10 10 10 10 10  9  9  9  9  9  9  9  9  9
%%  10 10 10 10 10 10 10 10 10 10  9  9  9  9  9  9  9  9  9
%%  10 10 10 10 10 10 10 10 10 10  9  9  9  9  9  9  9  9  9
%%  10 10 10 10 10 10 10 10 10 10  9  9  9  9  9  9  9  9  9
%%  10 10 10 10 10 10 10 10 10 10  9  9  9  9  9  9  9  9  9
%%  10 10 10 10 10 10 10 10 10 10  9  9  9  9  9  9  9  9  9
%%  10 10 10 10 10 10 10 10 10 10  9  9  9  9  9  9  9  9  9
%%  10 10 10 10 10 10 10 10 10 10  9  9  9  9  9  9  9  9  9
%%  10 10 10 10 10 10 10 10 10 10  9  9  9  9  9  9  9  9  9
%%  10 10 10 10 10 10 10 10 10 10  7  7  7  7  7  7  7  2  2
%%   6  6  6  6  6  6  4  4  4  4  7  7  7  7  7  7  7  2  2
%%   6  6  6  6  6  6  4  4  4  4  7  7  7  7  7  7  7  2  2
%%   6  6  6  6  6  6  4  4  4  4  7  7  7  7  7  7  7  2  2
%%   6  6  6  6  6  6  4  4  4  4  7  7  7  7  7  7  7  2  2
%%   6  6  6  6  6  6  4  4  4  4  7  7  7  7  7  7  7  2  2
%%   6  6  6  6  6  6  4  4  4  4  7  7  7  7  7  7  7  1  1
%%   3  3  3  3  3  3  4  4  4  4  3  3  3  3  3  3  3  3  3
%%   3  3  3  3  3  3  4  4  4  4  3  3  3  3  3  3  3  3  3
%%   3  3  3  3  3  3  1  1  1  1  3  3  3  3  3  3  3  3  3


main:- 
    ejemplo(4,Big,Sides),
    nl, write('Fitting all squares of size '), write(Sides), write(' into big square of size '), write(Big), nl,nl,
    length(Sides,N), 
    % VARIABLES
    length(RowVars,N), % get list of N prolog vars: Row coordinates of each small square
    length(ColVars,N),
    
    % DOMAINS
    insideBigSquare(N,Big,Sides,RowVars),
    insideBigSquare(N,Big,Sides,ColVars),
    
    % CONSTRAINTS
    nonoverlapping(N,Sides,RowVars,ColVars),
    
    % EXECUTION
    append(RowVars, ColVars, TotalVars),
    labeling([ff],TotalVars),
    
    % DISPLAY SOL
    displaySol(Big,Sides,RowVars,ColVars), halt.


displaySol(N,Sides,RowVars,ColVars):- 
    between(1,N,Row), nl, between(1,N,Col),
    nth1(K,Sides,S),    
    nth1(K,RowVars,RV),    RVS is RV+S-1,     between(RV,RVS,Row),
    nth1(K,ColVars,CV),    CVS is CV+S-1,     between(CV,CVS,Col),
    writeSide(S), fail.
displaySol(_,_,_,_):- nl,nl,!.

writeSide(S):- S<10, write('  '),write(S),!.
writeSide(S):-       write(' ' ),write(S),!.

insideBigSquare(0, _, _, _) :- !.
insideBigSquare(N,Big,[S|Sides],[V|Vars]) :- V #>= 1, N2 is Big - S + 1, V #=< N2, N3 is N-1, insideBigSquare(N3, Big, Sides, Vars).

nonoverlapping(0, _, _, _) :- !.
nonoverlapping(N,[S|Sides],[R|RowVars],[C|ColVars]) :- N2 is N-1, 
    nonwithnexts(S, R, C, Sides, RowVars, ColVars), nonoverlapping(N2, Sides, RowVars, ColVars).

nonwithnexts(_, _, _, _, [], []) :- !.
nonwithnexts(S, R, C, [S2|Sides], [R2|RowVars], [C2|ColVars]) :-
    Rmax = R + S-1, Cmax = C + S-1, R2max = R2 + S2-1, C2max = C2 + S2-1, 
    R2 #> Rmax #\/ R2max #< R #\/ C2 #> Cmax #\/ C2max #< C, nonwithnexts(S, R, C, Sides, RowVars, ColVars).





