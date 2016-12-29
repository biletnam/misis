PROCEDURE memcof(data: glnarray; n,m: integer; VAR pm: real;
      VAR cof: glmarray; wk1,wk2: glnarray; wkm: glmarray);
(* Programs using routine MEMCOF must define the data types
TYPE
   glnarray = ARRAY [1..n] OF real;
   glmarray = ARRAY [1..m] OF real;
and must provide workspace arrays wk1,wk2,wkm with the dimensions
shown in the arguments above. *)
LABEL 99;
VAR
   k,j,i: integer;
   pneum,p,denom: real;
BEGIN
   p := 0.0;
   FOR j := 1 TO n DO BEGIN
      p := p+sqr(data[j])
   END;
   pm := p/n;
   wk1[1] := data[1];
   wk2[n-1] := data[n];
   FOR j := 2 TO n-1 DO BEGIN
      wk1[j] := data[j];
      wk2[j-1] := data[j]
   END;
   FOR k := 1 TO m DO BEGIN
      pneum := 0.0;
      denom := 0.0;
      FOR j := 1 TO n-k DO BEGIN
         pneum := pneum+wk1[j]*wk2[j];
         denom := denom+sqr(wk1[j])+sqr(wk2[j])
      END;
      cof[k] := 2.0*pneum/denom;
      pm := pm*(1.0-sqr(cof[k]));
      IF (k <> 1) THEN BEGIN
         FOR i := 1 TO k-1 DO BEGIN
            cof[i] := wkm[i]-cof[k]*wkm[k-i]
         END
      END;
      IF (k = m) THEN GOTO 99;
      FOR i := 1 TO k DO BEGIN
         wkm[i] := cof[i]
      END;
      FOR j := 1 TO n-k-1 DO BEGIN
         wk1[j] := wk1[j]-wkm[k]*wk2[j];
         wk2[j] := wk2[j+1]-wkm[k]*wk1[j+1]
      END
   END;
99:   END;
