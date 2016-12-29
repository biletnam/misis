PROCEDURE polin2(x1a: glmarray; x2a: glnarray; ya: glmbyn;
       m,n: integer; x1,x2: real; VAR y,dy: real);
(* Programs using POLIN2 must define the types
TYPE
   glmarray = ARRAY [1..m] OF real;
   glnarray = ARRAY [1..n] OF real;
   glmbyn = ARRAY [1..m,1..n] OF real;
in the main routine. *)
VAR
   k,j: integer;
   ymtmp: glmarray;
   yntmp: glnarray;
BEGIN
   FOR j := 1 TO m DO BEGIN
      FOR k := 1 TO n DO BEGIN
         yntmp[k] := ya[j,k]
      END;
      polint(x2a,yntmp,n,x2,ymtmp[j],dy)
   END;
   polint(x1a,ymtmp,m,x1,y,dy)
END;
