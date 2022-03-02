# Funcions que hi ha definides a prolog:

## member

```{prolog}
member(X,[a, b, c, d]).
```

### Implementación interna
```{prolog}
mymember(x, [X|_]).
mymember(X, [_|L]) :- myember(X,L).
```

## append
```{prolog}
append([a, b], [b, c, d], L).
```

### Implementación interna
```{prolog}
myappend([], L, L).
myappend([X|L1], L2, [X|L3]) :- myappend(L1, L2, L3)
```

# Sentencies per a escriure totes les solucions
- write(X) escriu X. Si es vol posar més d'un paràmetre, posar un '-' entre mig
- nl fa un "new line"
- false retorna que és als, i obliga  afer backtrack

Exemple:

```{prolog}
append(L1, L2, [a, b]), write(L1-L2), nl, false.

> []-[a,b]
> [a]-[b]
> [a,b]-[]
```
