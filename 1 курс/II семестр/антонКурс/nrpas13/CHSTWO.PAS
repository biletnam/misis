PROCEDURE chstwo(bins1,bins2: barray; nbins,knstrn: integer;
       VAR df,chsq,prob: real);
(* Programs using routine CHSTWO must define type
TYPE
   barray = ARRAY [1..nbins] OF real;
in the main routine.   *)
VAR
   j: integer;
BEGIN
   df := nbins-1-knstrn;
   chsq := 0.0;
   FOR j := 1 TO nbins DO BEGIN
      IF ((bins1[j] = 0.0) AND (bins2[j] = 0.0)) THEN BEGIN
         df := df-1.0
      END ELSE BEGIN
         chsq := chsq+sqr(bins1[j]-bins2[j])/
               (bins1[j]+bins2[j])
      END
   END;
   prob := gammq(0.5*df,0.5*chsq)
END;
