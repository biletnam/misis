PROCEDURE cntab2(nn: narray; ni,nj: integer;
      VAR h,hx,hy,hygx,hxgy,uygx,uxgy,uxy: real);
(* Programs using routine CNTAB2 must define type
TYPE
   narray = ARRAY [1..ni,1..nj] OF integer;
in the calling routine. *)
CONST
   maxi=100;
   maxj=100;
   tiny=1.0e-30;
VAR
   j,i: integer;
   sum,p: real;
   sumi: ARRAY[1..maxi] OF real;
   sumj: ARRAY[1..maxj] OF real;
BEGIN
   sum := 0;
   FOR i := 1 TO ni DO BEGIN
      sumi[i] := 0.0;
      FOR j := 1 TO nj DO BEGIN
         sumi[i] := sumi[i]+nn[i,j];
         sum := sum+nn[i,j]
      END
   END;
   FOR j := 1 TO nj DO BEGIN
      sumj[j] := 0.0;
      FOR i := 1 TO ni DO BEGIN
         sumj[j] := sumj[j]+nn[i,j]
      END
   END;
   hx := 0.0;
   FOR i := 1 TO ni DO BEGIN
      IF (sumi[i] <> 0.0) THEN BEGIN
         p := sumi[i]/sum;
         hx := hx-p*ln(p)
      END
   END;
   hy := 0.0;
   FOR j := 1 TO nj DO BEGIN
      IF (sumj[j] <> 0.0) THEN BEGIN
         p := sumj[j]/sum;
         hy := hy-p*ln(p)
      END
   END;
   h := 0.0;
   FOR i := 1 TO ni DO BEGIN
      FOR j := 1 TO nj DO BEGIN
         IF (nn[i,j] <> 0) THEN BEGIN
            p := nn[i,j]/sum;
            h := h-p*ln(p)
         END
      END
   END;
   hygx := h-hx;
   hxgy := h-hy;
   uygx := (hy-hygx)/(hy+tiny);
   uxgy := (hx-hxgy)/(hx+tiny);
   uxy := 2.0*(hx+hy-h)/(hx+hy+tiny)
END;
