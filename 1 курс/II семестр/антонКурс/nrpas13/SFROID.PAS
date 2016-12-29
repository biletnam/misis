PROGRAM sfroid(input,output);
LABEL 99;
CONST
   ne=3;
   m=41;
   nb=1;
   nsi=ne;
   nyj=ne;
   nyk=m;
   nci=ne;
   ncj=3;      (* ncj=ne-nb+1 *)
   nck=42;      (* nck=m+1 *)
   nsj=7;      (* nsj=2*ne+1 *)
TYPE
   glyarray = ARRAY [1..ne,1..m] OF real;
   glcarray = ARRAY [1..nci,1..ncj,1..nck] OF real;
   glsarray = ARRAY [1..nsi,1..nsj] OF real;
   glscalv = ARRAY [1..ne] OF real;
   glindex = ARRAY [1..ne] OF integer;
VAR
   mm,n: integer;
   i,itmax,k: integer;
   h,c2,anorm: real;
   conv,deriv,fac1,fac2: real;
   q1,slowc: real;
   scalv: glscalv;
   indexv: glindex;
   y: glyarray;
   c: glcarray;
   s: glsarray;
   x: ARRAY [1..m] OF real;
(*$I MODFILE.PAS *)
(*$I PLGNDR.PAS *)
(*$I DIFEQ.PAS *)
(*$I RED.PAS *)
(*$I PINVS.PAS *)
(*$I BKSUB.PAS *)
(*$I SOLVDE.PAS *)
BEGIN
   itmax := 100;
   c2 := 0.0;
   conv := 5.0e-6;
   slowc := 1.0;
   h := 1.0/(m-1);
   writeln('Enter m n');
   readln(mm,n);
   IF (((n+mm) MOD 2) = 1) THEN BEGIN
      indexv[1] := 1;
      indexv[2] := 2;
      indexv[3] := 3
   END ELSE BEGIN
      indexv[1] := 2;
      indexv[2] := 1;
      indexv[3] := 3
   END;
   anorm := 1.0;
   IF (mm <> 0) THEN BEGIN
      q1 := n;
      FOR i := 1 TO mm DO BEGIN
         anorm := -0.5*anorm*(n+i)*(q1/i);
         q1 := q1-1.0
      END
   END;
   FOR k := 1 TO (m-1) DO BEGIN
      x[k] := (k-1)*h;
      fac1 := 1.0-sqr(x[k]);
      fac2 := exp((-mm/2.0)*ln(fac1));
      y[1,k] := plgndr(n,mm,x[k])*fac2;
      deriv := -((n-mm+1)*plgndr(n+1,mm,x[k])-
         (n+1)*x[k]*plgndr(n,mm,x[k]))/fac1;
      y[2,k] := mm*x[k]*y[1,k]/fac1+deriv*fac2;
      y[3,k] := n*(n+1)-mm*(mm+1)
   END;
   x[m] := 1.0;
   y[1,m] := anorm;
   y[3,m] := n*(n+1)-mm*(mm+1);
   y[2,m] := (y[3,m]-c2)*y[1,m]/(2.0*(mm+1.0));
   scalv[1] := abs(anorm);
   IF (y[2,m] > abs(anorm)) THEN scalv[2] := y[2,m] ELSE scalv[2] := abs(anorm);
   IF (y[3,m] > 1.0) THEN scalv[3] := y[3,m] ELSE scalv[3] := 1.0;
   WHILE true DO BEGIN
      writeln('Enter c**2 or 999 to end.');
      readln(c2);
      IF (c2 = 999) THEN GOTO 99;
      solvde(itmax,conv,slowc,scalv,indexv,ne,nb,m,y,nyj,nyk,
         c,nci,ncj,nck,s,nsi,nsj);
      writeln;
      writeln('m = ',mm:2,'  n = ',n:2,'  c**2 = ',c2:7:3,
         ' lam = ',y[3,1]+mm*(mm+1):10:6);
   END;
99:   END.
