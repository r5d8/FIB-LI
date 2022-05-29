programa(L) :- append([begin|Is], [end], L), instruccions(Is).

instruccions(I) :- single_instruccio(I).
instruccions(L) :- append(I, [;|L2], L), single_instruccio(I), instruccions(L2).

single_instruccio([V1, =, V2, +, V3]) :- variable(V1), variable(V2), variable(V3).
single_instruccio(L) :- append([if, V1, =, V2, then|Is1], [else|P2], L), append(Is2, endif, P2), 
                        variable(V1), variable(V2), instruccions(Is1), instruccions(Is2).

variable(x).
variable(y).
variable(z).
