PROCEDURE chebft(a,b: real; VAR c: glcarray; n: integer);
(* Programs using the routine CHEBFT must define the type
TYPE
   glcarray=ARRAY [1..n] OF real;
in the calling routine, and must externally define a function
func(y:real):real which is to be analyzed. *)
CONST
   pi=3.141592653589793;
VAR
   k,j: integer;
   y,fac,bpa,bma: real;
   sum: double;
   f: glcarray;
BEGIN
   bma := 0.5*(b-a);
   bpa := 0.5*(b+a);
   FOR k := 1 TO n DO BEGIN
      y := cos(pi*(k-0.5)/n);
      f[k] := func(y*bma+bpa)
   END;
   fac := 2.0/n;
   FOR j := 1 TO n DO BEGIN
      sum := 0.0;
      FOR k := 1 TO n DO BEGIN
         sum := sum+f[k]*cos((pi*(j-1))*((k-0.5)/n))
      END;
      c[j] := sngl(fac*sum)
   END
END;
