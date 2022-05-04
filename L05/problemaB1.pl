main:- EstadoInicial = [0, 0], EstadoFinal = [0, 4],
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

%Llenar Cuba 5
unPaso(1, [A5, A8], [5, A8]):- A5 \= 5. 

%Llenar Cuba 8
unPaso(1, [A5, A8], [A5, 8]):- A8 \= 8.

%Mover Cuba 5 -> Cuba 8
unPaso(1, [A5, A8], [B5, B8]):- Empty is 8 - A8, ToMove = min(A5, Empty),
                                B5 is A5 - ToMove, B8 is A8 + ToMove.
                                
%Mover Cuba 8 -> Cuba 5
unPaso(1, [A5, A8], [B5, B8]):- Empty is 5 - A5, ToMove = min(A8, Empty),
                                B8 is A8 - ToMove, B5 is A5 + ToMove.

%Vaciar Cuba 5
unPaso(1, [A5, A8], [0, A8]):- A5 \= 0. 

%Vaciar Cuba 8
unPaso(1, [A5, A8], [A5, 0]):- A8 \= 0.
