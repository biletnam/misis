PROCEDURE splin2(x1a,x2a: glnarray; ya,y2a: glmbyn;
       m,n: integer; x1,x2: real; VAR y: real);
(* Programs using routine SPLIN2 must define the types
TYPE
   glnarray = ARRAY [1..nn] OF real;
   glmbyn = ARRAY [1..m,1..n] OF real;
in the main routine. The dimension nn of glnarray must be set
to the larger of n and m *)
VAR
   k,j: integer;
   ytmp,y2tmp,yytmp: glnarray;
BEGIN
   FOR j := 1 TO m DO BEGIN
      FOR k := 1 TO n DO BEGIN
         ytmp[k] := ya[j,k];
         y2tmp[k] := y2a[j,k]
      END;
      splint(x2a,ytmp,y2tmp,n,x2,yytmp[j])
   END;
   spline(x1a,yytmp,m,1.0e30,1.0e30,y2tmp);
   splint(x1a,yytmp,y2tmp,m,x1,y)
END;
