PROCEDURE svdfit(x,y,sig: glndata; ndata: integer; VAR a: glmma; mma: integer;
      VAR u: glmpbynp; VAR v: glnpbynp; VAR w: glnparray; mp,np:
      integer; VAR chisq: real);
(* Programs using routine SVDFIT must define the types
TYPE
   glndata = ARRAY [1..ndata] OF real;
   glmma = ARRAY [1..mma] OF real;
   glmpbynp = ARRAY [1..mp,1..np] OF real;
   glnpbynp = ARRAY [1..np,1..np] OF real;
   glnparray = ARRAY [1..np] OF real;
in the main routine. Implementations without conformant arrays require mma=np
and the declaration
   glnparray = glmma;
and also mp=ndata, with the declaration
   glmparray = glndata;
in the main routine for use by the procedure SVBKSB. All user programs must also
include a routine that computes the desired basis functions with the declaration
PROCEDURE func(x: real: VAR p: glmma; mma: integer);
which should return the values of first mma basis functions at x in p.
FPOLY and FLEG (renamed to FUNC) are possible choices. *)
CONST
   tol=1.0e-5;
VAR
   j,i: integer;
   wmax,tmp,thresh,sum: real;
   b: glndata;
   afunc: glmma;
BEGIN
   FOR i := 1 TO ndata DO BEGIN
      func(x[i],afunc,mma);
      tmp := 1.0/sig[i];
      FOR j := 1 TO mma DO u[i,j] := afunc[j]*tmp;
      b[i] := y[i]*tmp
   END;
   svdcmp(u,ndata,mma,mp,np,w,v);
   wmax := 0.0;
   FOR j := 1 TO mma DO IF (w[j] > wmax) THEN wmax := w[j];
   thresh := tol*wmax;
   FOR j := 1 TO mma DO IF (w[j] < thresh) THEN w[j] := 0.0;
   svbksb(u,w,v,ndata,mma,mp,np,b,a);
   chisq := 0.0;
   FOR i := 1 TO ndata DO BEGIN
      func(x[i],afunc,mma);
      sum := 0.0;
      FOR j := 1 TO mma DO sum := sum+a[j]*afunc[j];
      chisq := chisq+sqr((y[i]-sum)/sig[i])
   END
END;
