PROCEDURE covsrt(VAR covar: glcovar; ncvm: integer; ma: integer;
       lista: gllista; mfit: integer);
(* Programs using routine COVSRT must define the types
TYPE
   glcovar = ARRAY [1..ncvm,1..ncvm] OF real;
   gllista = ARRAY [1..mfit] OF integer;
in the calling program. *)
VAR
   j,i: integer;
   swap: real;
BEGIN
   FOR j := 1 TO ma-1 DO BEGIN
      FOR i := j+1 TO ma DO BEGIN
         covar[i,j] := 0.0
      END
   END;
   FOR i := 1 TO mfit-1 DO BEGIN
      FOR j := i+1 TO mfit DO BEGIN
         IF (lista[j] > lista[i])  THEN BEGIN
            covar[lista[j],lista[i]] := covar[i,j]
         END ELSE BEGIN
            covar[lista[i],lista[j]] := covar[i,j]
         END
      END
   END;
   swap := covar[1,1];
   FOR j := 1 TO ma DO BEGIN
      covar[1,j] := covar[j,j];
      covar[j,j] := 0.0
   END;
   covar[lista[1],lista[1]] := swap;
   FOR j := 2 TO mfit DO BEGIN
      covar[lista[j],lista[j]] := covar[1,j]
   END;
   FOR j := 2 TO ma DO BEGIN
      FOR i := 1 TO j-1 DO BEGIN
         covar[i,j] := covar[j,i]
      END
   END
END;
