PROCEDURE mnewt(ntrial: integer; VAR x: glnarray; n: integer;
      tolx,tolf: real);
(* Programs using routine MNEWT must define the types
TYPE
   glnarray = ARRAY [1..n] OF real;
   glnbyn = ARRAY [1..n,1..n] OF real;
   glindx = ARRAY [1..n] OF integer;
in the main routine. They must also supply a routine
PROCEDURE usrfun(x: glnarray; n: integer; VAR alpha: glnbyn;
       VAR beta: glnarray);   *)
LABEL 99;
VAR
   k,i: integer;
   errx,errf,d: real;
   beta: glnarray;
   alpha: glnbyn;
   indx: glindx;
BEGIN
   FOR  k := 1 TO ntrial DO BEGIN
      usrfun(x,n,alpha,beta);
      errf := 0.0;
      FOR i := 1 TO n DO errf := errf+abs(beta[i]);
      IF (errf <= tolf) THEN GOTO 99;
      ludcmp(alpha,n,np,indx,d);
      lubksb(alpha,n,np,indx,beta);
      errx := 0.0;
      FOR i := 1 TO n DO BEGIN
         errx := errx+abs(beta[i]);
         x[i] := x[i]+beta[i]
      END;
      IF (errx <= tolx) THEN GOTO 99
   END;
99:   END;
