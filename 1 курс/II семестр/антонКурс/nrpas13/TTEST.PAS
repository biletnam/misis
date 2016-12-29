PROCEDURE ttest(data1: glnarray; n1: integer;
      data2: glmarray; n2: integer; VAR t,prob: real);
(* Programs using routine TTEST must define the types
TYPE
   glnarray = ARRAY [1..n1] OF real;
   glmarray = ARRAY [1..n2] OF real;
in the main routine, with n2 less than or equal to n1. *)
VAR
   i: integer;
   var2,var1,svar,df,ave2,ave1: real;
BEGIN
   avevar(data1,n1,ave1,var1);
   IF (n2 > n1) THEN BEGIN
      writeln('pause in routine TTEST');
      writeln('The first array should be the larger'); readln
   END;
   FOR i := 1 TO n2 DO data1[i] := data2[i];
   avevar(data1,n2,ave2,var2);
   df := n1+n2-2;
   svar := ((n1-1)*var1+(n2-1)*var2)/df;
   t := (ave1-ave2)/sqrt(svar*(1.0/n1+1.0/n2));
   prob := betai(0.5*df,0.5,df/(df+sqr(t)))
END;
