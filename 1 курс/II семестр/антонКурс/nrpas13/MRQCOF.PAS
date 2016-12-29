PROCEDURE mrqcof(x,y,sig: glndata; ndata: integer;
       VAR a: glmma; mma: integer; lista: gllista;
       mfit: integer; VAR alpha: glnalbynal;
       VAR beta: glmma; nalp: integer; VAR chisq: real);
(* Programs using routine MRQMIN must provide a
PROCEDURE funcs(xx:real; a:glmma; yfit:real; dyda:glmma; mma:integer);
that evaluates the fitting function yfit and its derivatives dyda
with respect to the parameters a at point xx.  Also they
must define the types
TYPE
   glndata = ARRAY [1..ndata] OF real;
   glmma = ARRAY [1..mma] OF real;
   gllista = ARRAY [1..mma] OF integer;
   glnalbynal = ARRAY [1..nalp,1..nalp] OF real;
in the main routine *)
VAR
   k,j,i: integer;
   ymod,wt,sig2i,dy: real;
   dyda: glmma;
BEGIN
   FOR j := 1 TO mfit DO BEGIN
      FOR k := 1 TO j DO BEGIN
         alpha[j,k] := 0.0
      END;
      beta[j] := 0.0
   END;
   chisq := 0.0;
   FOR i := 1 TO ndata DO BEGIN
      funcs(x[i],a,ymod,dyda,mma);
      sig2i := 1.0/(sig[i]*sig[i]);
      dy := y[i]-ymod;
      FOR j := 1 TO mfit DO BEGIN
         wt := dyda[lista[j]]*sig2i;
         FOR k := 1 TO j DO BEGIN
            alpha[j,k] := alpha[j,k]+wt*dyda[lista[k]]
         END;
         beta[j] := beta[j]+dy*wt
      END;
      chisq := chisq+dy*dy*sig2i
   END;
   FOR j := 2 TO mfit DO BEGIN
      FOR k := 1 TO j-1 DO BEGIN
         alpha[k,j] := alpha[j,k]
      END
   END
END;
