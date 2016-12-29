PROCEDURE tutest(data1: glnarray; n1: integer; data2: glmarray;
        n2: integer; VAR t,prob: real);
(* Programs using routine TUTEST must define the types
TYPE
   glnarray = ARRAY [1..n1] OF real;
   glmarray = ARRAY [1..n2] OF real;
in the main routine, with n2 less than or equal to n1.   *)
VAR
   var2,var1,df,ave2,ave1: real;
   i: integer;
BEGIN
   IF (n2 > n1) THEN BEGIN
      writeln('pause in routine TUTEST');
      writeln('first array must be the larger'); readln
   END;
   avevar(data1,n1,ave1,var1);
   FOR i := 1 TO n2 DO data1[i] := data2[i];
   avevar(data1,n2,ave2,var2);
   t := (ave1-ave2)/sqrt(var1/n1+var2/n2);
   df := sqr(var1/n1+var2/n2)/
      (sqr(var1/n1)/(n1-1)+sqr(var2/n2)/(n2-1));
   prob := betai(0.5*df,0.5,df/(df+sqr(t)))
END;
