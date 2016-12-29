PROCEDURE svdvar(v: glnpbynp; ma,np: integer; w: glnparray;
       VAR cvm: glcvm; ncvm: integer);
(* Programs using routine SVDVAR must define the types
TYPE
   glnpbynp = ARRAY [1..np,1..np] OF real;
   glnparray = ARRAY [1..np] OF real;
   glcvm = ARRAY [1..ncvm,1..ncvm] OF real;
in the calling program. *)
VAR
   k,j,i: integer;
   sum: real;
   wti: glnparray;
BEGIN
   FOR i := 1 TO ma DO BEGIN
      wti[i] := 0.0;
      IF (w[i] <> 0.0) THEN  wti[i] := 1.0/(w[i]*w[i])
   END;
   FOR i := 1 TO ma DO BEGIN
      FOR j := 1 TO i DO BEGIN
         sum := 0.0;
         FOR k := 1 TO ma DO BEGIN
            sum := sum+v[i,k]*v[j,k]*wti[k]
         END;
         cvm[i,j] := sum;
         cvm[j,i] := sum
      END
   END
END;
