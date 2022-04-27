persona(X) :- between(1, 5, X).
color_house(X) :- member(X, [verde, amarillo, rojo, azul, blanco]).
position(X) :- between(1, 5, X).
profesion(X) :- member(X, [medico, notario, pintor, escultor, actor]).
animal(X) :- member(X, [perro, ardilla, caracol, caballo, ??]).
bebida(X) :- member(X, [ron, coñac, cava, whisky, ??]).
nacionalidad(X) :- member(X, [frances, peruano, hungaro, chino, japones]).

solve([ [1, A1, B1, C1, D1],
        [2, A2, B2, C2, D2],
        [3, A3, B3, C3, D3],
        [4, A4, B4, C4, D4],
        [5, A5, B5, C5, D5]]):-
        
            
