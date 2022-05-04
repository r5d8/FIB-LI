%Estado: representado por 1 vector de vectores y un entero:
%El vector continene parejas: coste, posicion
%El entero contiene la posicion de la linterna
% 0 es la orilla de inicio, 1, la final
main:- EstadoInicial = [[[1, 0], [2, 0], [5, 0], [8, 0]], 0], EstadoFinal = [[[1, 1], [2, 1], [5, 1], [8, 1]], 1],
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

%Mover 1 persona
unPaso(C, [P1, L1], [P2, L2]) :- append(A, [[C, L1]|As], P1), L2 is 1-L1, append(A, [[C, L2]|As], P2).

%Mover 2 personas
unPaso(C, [P1, L1], [P2, L2]) :- append(A1, [[C1, L1]|A1s], P1), L2 is 1-L1, append(A1, [[C1, L2]|A1s], P3),
                                append(A2, [[C2, L1]|A2s], P3), append(A2, [[C2, L2]|A2s], P2), C1 \= C2,
                                C = max(C1, C2).
