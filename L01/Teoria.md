F sat?
F insat?
F taut?		ssi !F insat
F conseq G	ssi F i !G insat
F eqival G	sss ...	insat


Formula nos la dan como un conjunto de clausulas: CNF (Forma Normal Conjuntiva)
Una cláusula es una disyunción con simbolos negados y sin negar

p1 v p2 v... v pn v !q1 v ... v !qm
literales+			literales-


CONFLICTO: las decisiones tomadas noson compatubles entre si (al resolver una cláusula)
Cuando nohay ni prpagaciónni conflico, hay un modelo
