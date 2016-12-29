PROCEDURE lfit(x,y,sig: glndata; ndata: integer; VAR a: glmma; mma: integer;
      lista: gllista; mfit: integer; VAR covar: glcovar;
      ncvm: integer; VAR chisq: real);
(* Programs using routine LFIT must define the types
TYPE
   glndata = ARRAY [1..ndata] OF real;
   glmma = ARRAY [1..mma] OF real;
   gllista = ARRAY [1..mma] OF integer;
   glcovar = ARRAY [1..ncvm,1..ncvm] OF real;
   glnpbymp = ARRAY [1..ncvm,1..1] OF real;
in the main routine. *)
VAR
   k,kk,j,ihit,i: integer;
   ym,wt,sum,sig2i: real;
   beta: glnpbymp;
   afunc: glmma;
BEGIN
   kk := mfit+1;
   FOR j := 1 TO mma DO BEGIN
      ihit := 0;
      FOR k := 1 TO mfit DO BEGIN
         IF (lista[k] = j) THEN ihit := ihit+1
      END;
      IF (ihit = 0) THEN BEGIN
         lista[kk] := j;
         kk := kk+1
      END ELSE IF (ihit > 1) THEN BEGIN
         writeln('pause in routine LFIT');
         writeln('improper permutation in LISTA'); readln
      END
   END;
   IF (kk <> (mma+1)) THEN BEGIN
      writeln('pause in routine LFIT');
      writeln('improper permutation in LISTA'); readln
   END;
   FOR j := 1 TO mfit DO BEGIN
      FOR k := 1 TO mfit DO BEGIN
         covar[j,k] := 0.0
      END;
      beta[j,1] := 0.0
   END;
   FOR i := 1 TO ndata DO BEGIN
      funcs(x[i],afunc,mma);
      ym := y[i];
      IF (mfit < mma) THEN BEGIN
         FOR j := (mfit+1) TO mma DO BEGIN
            ym := ym-a[lista[j]]*afunc[lista[j]]
         END
      END;
      sig2i := 1.0/sqr(sig[i]);
      FOR j := 1 TO mfit DO BEGIN
         wt := afunc[lista[j]]*sig2i;
         FOR k := 1 TO j DO BEGIN
            covar[j,k] := covar[j,k]+wt*afunc[lista[k]]
         END;
         beta[j,1] := beta[j,1]+ym*wt
      END
   END;
   IF (mfit > 1) THEN BEGIN
      FOR j := 2 TO mfit DO BEGIN
         FOR k := 1 TO j-1 DO BEGIN
            covar[k,j] := covar[j,k]
         END
      END
   END;
   gaussj(covar,mfit,ncvm,beta,1,1);
   FOR j := 1 TO mfit DO BEGIN
      a[lista[j]] := beta[j,1]
   END;
   chisq := 0.0;
   FOR i := 1 TO ndata DO BEGIN
      funcs(x[i],afunc,mma);
      sum := 0.0;
      FOR j := 1 TO mma DO BEGIN
         sum := sum+a[j]*afunc[j]
      END;
      chisq := chisq+sqr((y[i]-sum)/sig[i])
   END;
   covsrt(covar,ncvm,mma,lista,mfit)
END;
