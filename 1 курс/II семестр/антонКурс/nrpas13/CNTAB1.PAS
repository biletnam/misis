PROCEDURE cntab1(nn: narray; ni,nj: integer;
       VAR chisq,df,prob,cramrv,ccc: real);
(* Programs using routine CNTAB1 must define type
TYPE
   narray = ARRAY [1..ni,1..nj] OF integer;
in the calling routine. *)
CONST
   maxi=100;
   maxj=100;
   tiny=1.0e-30;
VAR
   nnj,nni,j,i,min: integer;
   sum,expctd: real;
   sumi: ARRAY[1..maxi] OF real;
   sumj: ARRAY[1..maxj] OF real;
BEGIN
   sum := 0;
   nni := ni;
   nnj := nj;
   FOR i := 1 TO ni DO BEGIN
      sumi[i] := 0.0;
      FOR j := 1 TO nj DO BEGIN
         sumi[i] := sumi[i]+nn[i,j];
         sum := sum+nn[i,j];
      END;
      IF (sumi[i] = 0.0) THEN nni := nni-1;
   END;
   FOR j := 1 TO nj DO BEGIN
      sumj[j] := 0.0;
      FOR i := 1 TO ni DO BEGIN
         sumj[j] := sumj[j]+nn[i,j];
      END;
      IF (sumj[j] = 0.0) THEN nnj := nnj-1;
   END;
   df := nni*nnj-nni-nnj+1;
   chisq := 0.0;
   FOR i := 1 TO ni DO BEGIN
      FOR j := 1 TO nj DO BEGIN
         expctd := sumj[j]*sumi[i]/sum;
         chisq := chisq+sqr(nn[i,j]-expctd)/(expctd+tiny)
      END
   END;
   prob := gammq(0.5*df,0.5*chisq);
   IF ((nni-1) < (nnj-1)) THEN BEGIN
      min := nni-1
   END ELSE BEGIN
      min := nnj-1
   END;
   cramrv := sqrt(chisq/(sum*min));
   ccc := sqrt(chisq/(chisq+sum))
END;
