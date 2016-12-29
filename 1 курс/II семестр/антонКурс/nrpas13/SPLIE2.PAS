PROCEDURE splie2(x1a,x2a: glnarray; ya: glmbyn;
       m,n: integer; VAR y2a: glmbyn);
(* Programs using routine SPLIE2 must define the types
TYPE
   glnarray = ARRAY [1..nn] OF real;
   glmbyn = ARRAY [1..m,1..n] OF real;
in the main routine. The dimension nn of glnarray must be set to the larger
of n and m. *)
VAR
   k,j: integer;
   ytmp,y2tmp: glnarray;
BEGIN
   FOR j := 1 TO m DO BEGIN
      FOR k := 1 TO n DO BEGIN
         ytmp[k] := ya[j,k]
      END;
      spline(x2a,ytmp,n,1.0e30,1.0e30,y2tmp);
      FOR k := 1 TO n DO BEGIN
         y2a[j,k] := y2tmp[k]
      END
   END
END;
