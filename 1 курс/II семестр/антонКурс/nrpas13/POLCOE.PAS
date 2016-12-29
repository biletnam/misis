PROCEDURE polcoe(x,y: glnarray; n: integer; VAR cof: glnarray);
(* Programs using routine POLCOE must define the type
TYPE
   glnarray = ARRAY [1..narray] OF real;
in the main routine. *)
VAR
   k,j,i: integer;
   phi,ff,b: real;
   s: glnarray;
BEGIN
   FOR i := 1 TO n DO BEGIN
      s[i] := 0.0;
      cof[i] := 0.0
   END;
   s[n] := -x[1];
   FOR i := 2 TO n DO BEGIN
      FOR j := n+1-i TO n-1 DO BEGIN
         s[j] := s[j]-x[i]*s[j+1]
      END;
      s[n] := s[n]-x[i]
   END;
   FOR j := 1 TO n DO BEGIN
      phi := n;
      FOR k := n-1 DOWNTO 1 DO BEGIN
         phi := k*s[k+1]+x[j]*phi
      END;
      ff := y[j]/phi;
      b := 1.0;
      FOR k := n DOWNTO 1 DO BEGIN
         cof[k] := cof[k]+b*ff;
         b := s[k]+x[j]*b
      END
   END
END;
