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
