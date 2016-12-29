PROCEDURE chsone(bins,ebins: barray; nbins,knstrn: integer;
       VAR df,chsq,prob: real);
(* Programs using routine CHSONE must define the types
TYPE
   barray = ARRAY [1..nbins] OF real;
in the main routine.   *)
VAR
   j: integer;
BEGIN
   df := nbins-1-knstrn;
   chsq := 0.0;
   FOR j := 1 TO nbins DO BEGIN
      IF (ebins[j] <= 0.0) THEN BEGIN
         writeln('pause in CHSONE - bad expected number')
      END;
      chsq := chsq+sqr(bins[j]-ebins[j])/ebins[j]
   END;
   prob := gammq(0.5*df,0.5*chsq)
END;
