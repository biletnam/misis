PROCEDURE chint(a,b: real; c: glcarray; VAR cint: glcarray; n: integer);
(* Programs using routine CHINT must define the type glcarray as in
routine CHEBFT. *)
VAR
   j: integer;
   sum,fac,con: real;
BEGIN
   con := 0.25*(b-a);
   sum := 0.0;
   fac := 1.0;
   FOR j := 2 TO n-1 DO BEGIN
      cint[j] := con*(c[j-1]-c[j+1])/(j-1);
      sum := sum+fac*cint[j];
      fac := -fac
   END;
   cint[n] := con*c[n-1]/(n-1);
   sum := sum+fac*cint[n];
   cint[1] := 2.0*sum
END;
