PROCEDURE ftest(data1: gln1array; n1: integer;
      data2: gln2array; n2: integer; VAR f,prob: real);
(* Programs using routine FTEST must define the types
TYPE
   gln1array = ARRAY [1..n1] OF real;
   gln2array = ARRAY [1..n2] OF real;
in the main routine, with n2 less than or equal to n1. *)
VAR
   i: integer;
   var2,var1,df2,df1,ave2,ave1: real;
BEGIN
   IF (n2 > n1) THEN BEGIN
      writeln('pause in routine FTEST');
      writeln('first array must be the larger'); readln
   END;
   avevar(data1,n1,ave1,var1);
   FOR i := 1 TO n2 DO data1[i] := data2[i];
   avevar(data1,n2,ave2,var2);
   IF (var1 > var2) THEN BEGIN
      f := var1/var2;
      df1 := n1-1;
      df2 := n2-1
   END ELSE BEGIN
      f := var2/var1;
      df1 := n2-1;
      df2 := n1-1
   END;
   prob  :=  betai(0.5*df2,0.5*df1,df2/(df2+df1*f))
         +(1.0-betai(0.5*df1,0.5*df2,df1/(df1+df2/f)))
END;
