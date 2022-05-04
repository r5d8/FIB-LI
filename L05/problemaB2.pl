%Estado: representado por 2 vecores y un entero:
%El primero continene los exploradores (Obejas)
%El segundo los caníbales (Lobos)
%El tenero es la orilla en la que se encuentra la piragua
% 0 es la orilla de inicio, 1, la final
main:- EstadoInicial = [[0, 0, 0],[0, 0, 0], 0], EstadoFinal = [[1, 1, 1],[1, 1, 1], 1],
        between(1,1000,CosteMax), % Buscamos soluci ́on de coste 0; si no, de 1, etc.
        camino( CosteMax, EstadoInicial, EstadoFinal, [EstadoInicial], Camino ),
        reverse(Camino,Camino1), write(Camino1), write(' con coste '), write(CosteMax), nl, halt.

camino( 0, E,E, C,C ). % Caso base: cuando el estado actual es el estado final.
camino( CosteMax, EstadoActual, EstadoFinal, CaminoHastaAhora, CaminoTotal ):-
        CosteMax>0,
        unPaso( CostePaso, EstadoActual, EstadoSiguiente ), % En B.1 y B.2, CostePaso es 1.
        \+member( EstadoSiguiente, CaminoHastaAhora ),
        CosteMax1 is CosteMax-CostePaso,
camino(CosteMax1,EstadoSiguiente,EstadoFinal, [EstadoSiguiente|CaminoHastaAhora], CaminoTotal).

count_0s(V, N) :- findall(0, member(0, V), L), length(L, N).
count_1s(V, N) :- findall(1, member(1, V), L), length(L, N).
mover_persona(P, Fin) :- Fin is 1-P.
comprobar_orillas(E, C) :- count_0s(E, Ne0), count_0s(C, Nc0), Ne0 >= Nc0,
                            count_1s(E, Ne1), count_1s(C, Nc1), Ne1 >= Nc1, !.
comprobar_orillas(E, C) :- count_0s(E, Ne0), Ne0 = 0,
                            count_1s(E, Ne1), count_1s(C, Nc1), Ne1 >= Nc1, !.
comprobar_orillas(E, C) :- count_0s(E, Ne0), count_0s(C, Nc0), Ne0 >= Nc0,
                            count_1s(E, Ne1), Ne1 = 0, !.

%Mover 1 explorador
unPaso(1, [E1, C1, P1], [E2, C1, P2]) :- append(Q1, Q2, E1), Q2 = [X|Xs], X = P1, mover_persona(X, Y), 
                                 append(Q1, [Y|Xs], E2), P2 = Y, comprobar_orillas(E2, C1).
%Mover 1 canibal
unPaso(1, [E1, C1, P1], [E1, C2, P2]) :- append(Q1, Q2, C1), Q2 = [X|Xs], X = P1, mover_persona(X, Y), 
                                 append(Q1, [Y|Xs], C2), P2 = Y, comprobar_orillas(E1, C2).
%Mover 2 exploradores

%Mover 2 canibales

%Mover 2 personas, 1 de cada
unPaso(1, [E1, C1, P1], [E2, C2, P2]) :- append(A1, A2, E1), A2 = [X|Xs], X = P1, mover_persona(X, Y), 
                                        append(A1, [Y|Xs], E2),  
                                        append(B1, B2, C1), B2 = [BX|BXs], BX = P1, mover_persona(BX, BY), 
                                        append(B1, [BY|BXs], C2),
                                        P2 = BY,
                                        comprobar_orillas(E2, C2).
