# Programa
```{shell}
swipl -s programa.pl
```

Un cop a dins de la interfici, per compilar fer:
```{shell}
?- [programa]
```

# Funcions que hi ha definides a prolog:

## Aritmètica

### is
Evalua el resultat de la dreta. Si no és evaluable, retorna error. Si ho és, ho unifica amb la dreta
Si pongo un igual, solo se unifica, sin evaluar.
Si intentas evaluar un numero pero una varable no está instanciada, da error, no intenta unificar.

```{prolog}
?- X = 27+1, Y is X+1

> X = 27+1
> Y = 29
```

```{prolog}
?- X is Y+2

> ERROR!!!
```

### Factorial
Definició de la funció factorial
```{prolog}
fact(0, 1).
fact(N,F) :- N>0,
			 N1 is N-1,
			 fact(N1, F1),
			 F is N*F1.
```

## Funcions de llistes

### member

```{prolog}
member(X,[a, b, c, d]).
```

#### Implementación interna
```{prolog}
mymember(x, [X|_]).
mymember(X, [_|L]) :- myember(X,L).
```

### append
El método append, que se usa para concatenar listas, también sirve para dividirlas en 2 trozos, de todas las maneras posibles.
```{prolog}
append([a, b], [b, c, d], L).
```

#### Implementación interna
```{prolog}
myappend([], L, L).
myappend([X|L1], L2, [X|L3]) :- myappend(L1, L2, L3)
```

### subset
Hace subconjuntos a partir de listas
```{prolog}
subset(L, S).
```

#### Implementación interna
```{prolog}
subconjunto([], []).
subconjunto([X|L], [X|S]) :- subconjunto(L, S).
subconjunto([X|L], S) :- subconjunto(L, S).
```

### permutation
Hace permutaciones a partir de una lista
```{prolog}
permutation(L, P).
```

#### Implementación interna
```{prolog}
mypermutation([], []).
mypermutation([X|L], P) :- mypermutation(L, P1),
							   append(Pa, Pb, P1),
							   append(Pa, [X|Pb], P).
```

## select
select(?Elem, ?List1, ?List2)
Is true when List1, with Elem removed, results in List2. This implementation is determinsitic if the last element of List1 has been selected.

## Sentencies per a escriure totes les solucions
- write(X) escriu X. Si es vol posar més d'un paràmetre, posar un '-' entre mig
- nl fa un "new line"
- false retorna que és als, i obliga  afer backtrack

###Exemple:

```{prolog}
append(L1, L2, [a, b]), write(L1-L2), nl, false.

> []-[a,b]
> [a]-[b]
> [a,b]-[]
```

### Operadores

- ! (operador de corte)
- not (negación por fallo finito). Es finito porque si la llamada es infinita, elnot es infinito.
    (negate by inite failure)
    Implementación:
    
    not(X) :- X,!,fail.
    not(_).
- findall
    Funcionamiento:
    findall(X, (condicion), S).
    
    Condicion puede ser una linea prolog, S es un conjunto con la solucion.
    
    Ejemplo:
    findall(X, (between(1, 7, X), 0 is X mod 2), S).
    

# Ejemplo juego: dados

Tienes 3 dados: V, A, R. Cada uno tiene 2 veces los 3 numeros del 0 al 9, si repetirse entre dados.
Juego: que el otro escoja un dado, y tirais unas cuantas veces, a ver quien gana.
Truco: ganar circular. Se considera ganar el hecho que 5 de los 9 resultados posibles sea mayor en uno de los dados


Pseudo-código para generar dados (algunas lineas no estan completas, para facilitar la lectura):
```{prolog}
dados :-
    permutation([1,2,3,4,5,6,7,8,9], [r1,r2,r3,v1,v2,v3,a1,a2,a3]),
    gana([r1,r2,r3], [v1,v2,v3]),
    gana(V, A),
    gana(A, R),
    write([r1...a3]), nl, halt.
    
gana(D1, D2) :- 
    findall(X-Y, (member(X, D1), member(Y, D2), X>Y), L), 
    length(L, K), K>=5.
```
Código para generar dados acabado:

```{prolog}
dados :-
    permutation([1,2,3,4,5,6,7,8,9], [R1,R2,R3,V1,V2,V3,A1,A2,A3]),
    gana([R1,R2,R3], [V1,V2,V3]),
    gana([V1,V2,V3], [A1,A2,A3]),
    gana([A1,A2,A3], [R1,R2,R3]),
    write([R1,R2,R3,V1,V2,V3,A1,A2,A3]), nl, halt.
    
gana(D1, D2) :- 
    findall(X-Y, (member(X, D1), member(Y, D2), X>Y), L), 
    length(L, K), K>=5.
```
