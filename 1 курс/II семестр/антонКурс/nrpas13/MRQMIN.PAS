PROCEDURE mrqmin(x,y,sig: glndata; ndata: integer;
       VAR a: glmma; mma: integer; lista: gllista;
       mfit: integer; VAR covar,alpha: glncabynca;
       nca: integer; VAR chisq,alamda: real);
(* Programs using routine MRQMIN must define the types
TYPE
   glndata = ARRAY [1..ndata] OF real;
   glmma = ARRAY [1..mma] OF real;
   gllista = ARRAY [1..mma] OF integer;
   glncabynca = ARRAY [1..nca,1..nca] OF real;
and the variables
VAR
   glochisq: real;
   glbeta: glmma;
in the main routine. Also note that this routine calls MRQCOF, which
requires a user-defined procedure FUNCS, described in that routine.   *)
LABEL 99;
VAR
   k,kk,j,ihit: integer;
   atry,da: glmma;
   oneda: glncabynca;
BEGIN
   IF (alamda < 0.0) THEN BEGIN
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
            writeln('pause 1 in routine MRQMIN');
            writeln('Improper permutation in LISTA'); readln
         END
      END;
      IF (kk <> (mma+1)) THEN BEGIN
         writeln('pause 2 in routine MRQMIN');
         writeln('Improper permutation in LISTA'); readln
      END;
      alamda := 0.001;
      mrqcof(x,y,sig,ndata,a,mma,lista,mfit,alpha,glbeta,nca,chisq);
      glochisq := chisq;
      FOR j := 1 TO mma DO BEGIN
         atry[j] := a[j]
      END
   END;
   FOR j := 1 TO mfit DO BEGIN
      FOR k := 1 TO mfit DO BEGIN
         covar[j,k] := alpha[j,k]
      END;
      covar[j,j] := alpha[j,j]*(1.0+alamda);
      oneda[j,1] := glbeta[j]
   END;
   gaussj(covar,mfit,nca,oneda,1,1);
   FOR j := 1 TO mfit DO da[j] := oneda[j,1];
   IF (alamda = 0.0) THEN BEGIN
      covsrt(covar,nca,mma,lista,mfit);
      GOTO 99
   END;
   FOR j := 1 TO mfit DO BEGIN
      atry[lista[j]] := a[lista[j]]+da[j]
   END;
   mrqcof(x,y,sig,ndata,atry,mma,lista,mfit,covar,da,nca,chisq);
   IF (chisq < glochisq) THEN BEGIN
      alamda := 0.1*alamda;
      glochisq := chisq;
      FOR j := 1 TO mfit DO BEGIN
         FOR k := 1 TO mfit DO BEGIN
            alpha[j,k] := covar[j,k]
         END;
         glbeta[j] := da[j];
         a[lista[j]] := atry[lista[j]]
      END
   END ELSE BEGIN
      alamda := 10.0*alamda;
      chisq := glochisq
   END;
99:   END;
