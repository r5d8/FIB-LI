:- use_module(library(clpfd)).

%% A (6-sided) "letter dice" has on each side a different letter.
%% Find four of them, with the 24 letters abcdefghijklmnoprstuvwxy such
%% that you can make all the following words: bake, onyx, echo, oval,
%% gird, smug, jump, torn, luck, viny, lush, wrap.

%Some helpful predicates:

word( [b,a,k,e] ).
word( [o,n,y,x] ).
word( [e,c,h,o] ).
word( [o,v,a,l] ).
word( [g,i,r,d] ).
word( [s,m,u,g] ).
word( [j,u,m,p] ).
word( [t,o,r,n] ).
word( [l,u,c,k] ).
word( [v,i,n,y] ).
word( [l,u,s,h] ).
word( [w,r,a,p] ).

num(X,N):- nth1( N, [a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,r,s,t,u,v,w,x,y], X ).

main:-
    %Vars
    length(D1,6),
    length(D2,6),
    length(D3,6),
    length(D4,6),
    
    %Domini
    D1 ins 1..24,
    D2 ins 1..24,
    D3 ins 1..24,
    D4 ins 1..24,
    
    %Constraints
    append(D1, D2, D12), append(D3, D4, D34), append(D12, D34, Dtot),
    all_different(Dtot),
    
    %word(W),
    %createsWord(W, [D1, D2, D3, D4]),
    
    parejasDistintas(P),
    incompatibles_en_dados(P, D1),
    incompatibles_en_dados(P, D2),
    incompatibles_en_dados(P, D3),
    incompatibles_en_dados(P, D4),
    
    romper_simetria_1(D1, D2),
    sortedOK(D1), sortedOK(D2), sortedOK(D3), sortedOK(D4), 
    
    %solve
    labeling([ff], Dtot),
    
    %Write sol
    writeN(D1), 
    writeN(D2), 
    writeN(D3), 
    writeN(D4), halt.
    
writeN(D):- findall(X,(member(N,D),num(X,N)),L), write(L), nl, !.

%createsWord([],[]).
%createsWord([L|W], Dices) :- append(P1, [D|P2], Dices), member(Face, D), Face #= L, append(P1, P2, P), createsWord(W, P).

parejasDistintas(L) :- findall(NA-NB, (word(W), member(A, W), member(B, W), num(A, NA), num(B, NB), NA < NB), L).

%romper_simetria_1([A|_], [B|_], [C|_], [D|_]) :- A #= 2, B #= 1, C #= 11, D #= 5. %b, a, k, e
romper_simetria_1([A|_], [B|_]) :- A #= 2, B #= 1. %b, a. k, e no les poso pq potser no estarà sorted sinó!!

%Es pot trencar simetria fent tb que estigui sorted
sortedOK([_]).                                          %%%% OK!
sortedOK([X,Y|L]):- X #< Y, sortedOK([Y|L]).

incompatibles_en_dados([], _).
incompatibles_en_dados([N-M|Pl], [A,B,C,D,E,F]) :- 
    incompatibles_en_dados(Pl, [A,B,C,D,E,F]),
    A #\= N #\/ B #\= M, A #\= N #\/ C #\= M, A #\= N #\/ D #\= M, A #\= N #\/ E #\= M, A #\= N #\/ F #\= M,
                         B #\= N #\/ C #\= M, B #\= N #\/ D #\= M, B #\= N #\/ E #\= M, B #\= N #\/ F #\= M,
                                              C #\= N #\/ D #\= M, C #\= N #\/ E #\= M, C #\= N #\/ F #\= M,
                                                                   D #\= N #\/ E #\= M, D #\= N #\/ F #\= M,
                                                                                        E #\= N #\/ F #\= M.
