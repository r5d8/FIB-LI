persona(X) :- between(1, 5, X).
color_house(X) :- member(X, [verde, amarillo, rojo, azul, blanco]).
position(X) :- between(1, 5, X).
profesion(X) :- member(X, [medico, notario, pintor, escultor, actor]).
animal(X) :- member(X, [perro, ardilla, caracol, caballo, ??]).
bebida(X) :- member(X, [ron, coñac, cava, whisky, ??]).
nacionalidad(X) :- member(X, [frances, peruano, hungaro, chino, japones]).

caballo_next_actor(Pos_a, L) :- Pos_vecino is Pos_a + 1, position(Pos_vecino), member(Pos_vecino-caballo, L).
caballo_next_actor(Pos_a, L) :- Pos_vecino is Pos_a - 1, position(Pos_vecino), member(Pos_vecino-caballo, L).

hungaro_next_azul(Pos_hung, L) :- Pos_vecino is Pos_hung + 1, position(Pos_vecino), member(Pos_vecino-azul, L).
hungaro_next_azul(Pos_hung, L) :- Pos_vecino is Pos_hung - 1, position(Pos_vecino), member(Pos_vecino-azul, L).

medico_next_ardilla(Pos_m, L) :- Pos_vecino is Pos_m + 1, position(Pos_vecino), member(Pos_vecino-ardilla, L).
medico_next_ardilla(Pos_m, L) :- Pos_vecino is Pos_m - 1, position(Pos_vecino), member(Pos_vecino-ardilla, L).

%       num    , A    , B        , C     , D     , E
%       persona, color, profesion, animal, bebida, nacionalidad
solve([ [1, A1, B1, C1, D1, E1],
        [2, A2, B2, C2, D2, E2],
        [3, A3, B3, C3, D3, E3],
        [4, A4, B4, C4, D4, E4],
        [5, A5, B5, C5, D5, E5]]):-
        Col_r = rojo, N_p = peruano, member(Col_r-N_p, [A1-E1, A2-E2, A3-E3, A4-E4, A5-E5]),    %1
        An_p = perro, N_f = frances, member(An_p-N_f, [C1-E1, C2-E2, C3-E3, C4-E4, C5-E5]),   %2
        Prof_p = pintor, N_j = japones, member(Prof_p-N_j, [B1-E1, B2-E2, B3-E3, B4-E4, B5-E5]),  %3
        Beb_r = ron, N_c = chino, member(Beb_r-N_c, [D1-E1, D2-E2, D3-E3, D4-E4, D5-E5]),       %4
        E1 = hungaro,   %5
        Col_v = verde, Beb_con = coñac, member(Col_v-Beb_con, [A1-D1, A2-D2, A3-D3, A4-D4, A5-D5]),    %6
        position(Pos_x), Pos_y is Pos_x - 1, position(Pos_y), Col_b = blanco, %7
            member(Col_v-Pos_y, [A1-1, A2-2, A3-3, A4-4, A5-5]),
            member(Col_b-Pos_x, [A1-1, A2-2, A3-3, A4-4, A5-5]),
        Prof_e = escultor, An_car = caracol, member(Prof_e-An_car, [B1-C1, B2-C2, B3-C3, B4-C4, B5-C5]), %8
        Col_am = amarillo, Prof_a = actor, member(Col_am-Prof_a, [A1-B1, A2-B2, A3-B3, A4-B4, A5-B5]), %9
        D3 = cava, %10
        member(Pos_a-Prof_a, [1-B1, 2-B2, 3-B3, 4-B4, 5-B5]), %11
            caballo_next_actor(Pos_a, [1-C1, 2-C2, 3-C3, 4-C4, 5-C5]),
        member(Pos_hung-hungaro, [1-E1, 2-E2, 3-E3, 4-E4, 5-E5]),   %12
            hungaro_next_azul(Pos_hung, [1-A1, 2-A2, 3-A3, 4-A4, 5-A5]),
        Prof_n = notario, Beb_w = whisky, member(Prof_n-Beb_w, [B1-D1, B2-D2, B3-D3, B4-D4, B5-D5]), %13
        member(Pos_m-medico, [1-B1, 2-B2, 3-B3, 4-B4, 5-B5]),
            medico_next_ardilla(Pos_m, [1-C1, 2-C2, 3-C3, 4-C4, 5-C5]),
        
        
        member(ValueA, [A1, A2, A3, A4, A5]), color_house(ValueA),
        member(ValueB, [B1, B2, B3, B4, B5]), profesion(ValueB),
        member(ValueC, [C1, C2, C3, C4, C5]), animal(ValueC),
        member(ValueD, [D1, D2, D3, D4, D5]), bebida(ValueD),
        member(ValueE, [E1, E2, E3, E4, E5]), nacionalidad(ValueE),
            
        sort([A1, A2, A3, A4, A5], SA), length(SA, 5),
        sort([B1, B2, B3, B4, B5], SB), length(SB, 5),
        sort([C1, C2, C3, C4, C5], SC), length(SC, 5),
        sort([D1, D2, D3, D4, D5], SD), length(SD, 5),
        sort([E1, E2, E3, E4, E5], SE), length(SE, 5), 
        !.
            
