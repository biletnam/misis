PROCEDURE eclazz(VAR nf: glnarray; n: integer);
(* Programs using routine ECLAZZ must supply a boolean function
equiv(i,j:integer):boolean which indicates (TRUE or FALSE) whether
i and j belong to the same equivalence class. They must also
define the type
TYPE
   glnarray = ARRAY [1..n] OF integer;
in the main routine. *)
VAR
   kk,jj: integer;
BEGIN
   nf[1] := 1;
   FOR jj := 2 TO n DO BEGIN
      nf[jj] := jj;
      FOR kk := 1 TO jj-1 DO BEGIN
          nf[kk] := nf[nf[kk]];
          IF (equiv(jj,kk)) THEN nf[nf[nf[kk]]] := jj
      END
   END;
   FOR jj := 1 TO n DO nf[jj] := nf[nf[jj]]
END;
