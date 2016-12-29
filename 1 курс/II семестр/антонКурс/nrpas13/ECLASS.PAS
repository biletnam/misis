PROCEDURE eclass(VAR nf: glnarray; n: integer;
       lista,listb: glmarray; m: integer);
(* Programs using routine ECLASS must define the types
TYPE
   glnarray = ARRAY [1..n] OF integer;
   glmarray = ARRAY [1..m] OF integer;
in the main routine. *)
VAR
   l,k,j: integer;
BEGIN
   FOR k := 1 TO n DO BEGIN
      nf[k] := k
   END;
   FOR l := 1 TO m DO BEGIN
      j := lista[l];
      WHILE (nf[j] <> j) DO j := nf[j];
      k := listb[l];
      WHILE (nf[k] <> k) DO k := nf[k];
      IF (j <> k) THEN nf[j] := k
   END;
   FOR j := 1 TO n DO WHILE (nf[j] <> nf[nf[j]]) DO nf[j] := nf[nf[j]];
END;
