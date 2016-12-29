PROCEDURE pcshft(a,b: real; VAR d: glcarray; n: integer);
(* Programs using routine PCSHFT must define the type
glcarray as in routine CHEBFT. *)
VAR
   k,j: integer;
   fac,cnst: real;
BEGIN
   cnst := 2.0/(b-a);
   fac := cnst;
   FOR j := 2 TO n DO BEGIN
      d[j] := d[j]*fac;
      fac := fac*cnst
   END;
   cnst := 0.5*(a+b);
   FOR j := 1 TO n-1 DO BEGIN
      FOR k := n-1 DOWNTO j DO BEGIN
         d[k] := d[k]-cnst*d[k+1]
      END
   END
END;
