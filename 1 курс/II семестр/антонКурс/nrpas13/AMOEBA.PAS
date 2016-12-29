PROCEDURE amoeba(VAR p: glmpnp; VAR y: glmp; ndim: integer;
       ftol: real; VAR iter: integer);
(* Programs using routine AMOEBA must supply an external function
func(pr:glnp):real whose minimum is to be found. They must
also define types
TYPE
   glmpnp = ARRAY [1..mp,1..np] OF real;
   glmp = ARRAY [1..mp] OF real;
   glnp = ARRAY [1..np] OF real;
where mp and np are physical dimensions *)
LABEL 99;
CONST
   alpha=1.0;
   beta=0.5;
   gamma=2.0;
   itmax=500;
VAR
   mpts,j,inhi,ilo,ihi,i: integer;
   yprr,ypr,rtol: real;
   pr,prr,pbar: glnp;
BEGIN
   mpts := ndim+1;
   iter := 0;
   WHILE true DO BEGIN
      ilo := 1;
      IF (y[1] > y[2]) THEN BEGIN
         ihi := 1;
         inhi := 2
      END ELSE BEGIN
         ihi := 2;
         inhi := 1
      END;
      FOR i := 1 TO mpts DO BEGIN
         IF (y[i] < y[ilo]) THEN  ilo := i;
         IF (y[i] > y[ihi]) THEN BEGIN
            inhi := ihi;
            ihi := i
         END ELSE IF  (y[i] > y[inhi]) THEN
            IF (i <> ihi) THEN  inhi := i
      END;
      rtol := 2.0*abs(y[ihi]-y[ilo])/(abs(y[ihi])+abs(y[ilo]));
      IF (rtol < ftol) THEN GOTO 99;
      IF (iter = itmax) THEN BEGIN
         writeln('pause in AMOEBA - too many iterations'); readln
      END;
      iter := iter+1;
      FOR j := 1 TO ndim DO pbar[j] := 0.0;
      FOR i := 1 TO mpts DO
         IF (i <> ihi) THEN FOR j := 1 TO ndim DO pbar[j] := pbar[j]+p[i,j];
      FOR j := 1 TO ndim DO BEGIN
         pbar[j] := pbar[j]/ndim;
         pr[j] := (1.0+alpha)*pbar[j]-alpha*p[ihi,j]
      END;
      ypr := func(pr);
      IF (ypr <= y[ilo]) THEN BEGIN
         FOR j := 1 TO ndim DO prr[j] := gamma*pr[j]+(1.0-gamma)*pbar[j];
         yprr := func(prr);
         IF (yprr < y[ilo]) THEN BEGIN
            FOR j := 1 TO ndim DO p[ihi,j] := prr[j];
            y[ihi] := yprr
         END ELSE BEGIN
            FOR j := 1 TO ndim DO p[ihi,j] := pr[j];
            y[ihi] := ypr
         END
      END ELSE IF  (ypr >= y[inhi]) THEN BEGIN
         IF (ypr < y[ihi]) THEN BEGIN
            FOR j := 1 TO ndim DO p[ihi,j] := pr[j];
            y[ihi] := ypr
         END;
         FOR j := 1 TO ndim DO prr[j] := beta*p[ihi,j]+(1.0-beta)*pbar[j];
         yprr := func(prr);
         IF (yprr < y[ihi]) THEN BEGIN
            FOR j := 1 TO ndim DO p[ihi,j] := prr[j];
            y[ihi] := yprr
         END ELSE BEGIN
            FOR i := 1 TO mpts DO
               IF (i <> ilo) THEN BEGIN
                  FOR j := 1 TO ndim DO BEGIN
                     pr[j] := 0.5*(p[i,j]+p[ilo,j]);
                     p[i,j] := pr[j]
                  END;
                  y[i] := func(pr)
               END
         END
      END ELSE BEGIN
         FOR j := 1 TO ndim DO p[ihi,j] := pr[j];
         y[ihi] := ypr
      END
   END;
99:   END;
