%Estado: representado por 2 vecores y un entero:
%El primero continene los exploradores que estan en la orilla de inicio (Obejas)
%El segundo los caníbales que estan en la orilla de inicio (Lobos)
%El tenero es la orilla en la que se encuentra la piragua
% 0 es la orilla de inicio, 1, la final
main:- EstadoInicial = [3, 3, 0], EstadoFinal = [0, 0, 1],
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

comprobar_orillas(E, C) :- E >= C, E2 is 3-E, C2 is 3-C, E2 >= C2, !.
comprobar_orillas(0, _) :- !.
comprobar_orillas(3, _) :- !.

%Mover 1 explorador
unPaso(1, [E1, C1, 0], [E2, C1, 1]) :- E1 > 0, E2 is E1-1, comprobar_orillas(E2, C1).
unPaso(1, [E1, C1, 1], [E2, C1, 0]) :- E1 < 3, E2 is E1+1, comprobar_orillas(E2, C1).

%Mover 1 canibal
unPaso(1, [E1, C1, 0], [E1, C2, 1]) :- C1 > 0, C2 is C1-1, comprobar_orillas(E1, C2).
unPaso(1, [E1, C1, 1], [E1, C2, 0]) :- C1 < 3, C2 is C1+1, comprobar_orillas(E1, C2).

%Mover 2 exploradores
unPaso(1, [E1, C1, 0], [E2, C1, 1]) :- E1 > 1, E2 is E1-2, comprobar_orillas(E2, C1).
unPaso(1, [E1, C1, 1], [E2, C1, 0]) :- E1 < 2, E2 is E1+2, comprobar_orillas(E2, C1).

%Mover 2 canibales
unPaso(1, [E1, C1, 0], [E1, C2, 1]) :- C1 > 1, C2 is C1-2, comprobar_orillas(E1, C2).
unPaso(1, [E1, C1, 1], [E1, C2, 0]) :- C1 < 2, C2 is C1+2, comprobar_orillas(E1, C2).

%Mover 2 personas, 1 de cada
unPaso(1, [E1, C1, 0], [E2, C2, 1]) :- E1 > 0, E2 is E1-1, C1 > 0, C2 is C1-1, comprobar_orillas(E2, C2).
unPaso(1, [E1, C1, 1], [E2, C2, 0]) :- E1 < 3, E2 is E1+1, C1 < 3, C2 is C1+1, comprobar_orillas(E2, C2).
