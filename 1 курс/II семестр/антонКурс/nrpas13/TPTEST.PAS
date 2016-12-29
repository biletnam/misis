PROCEDURE tptest(data1,data2: glnparray; n: integer; VAR t,prob: real);
(* Programs using routine TPTEST must define type
TYPE
   glnparray := ARRAY [1..np];
in the main routine, with np >= n. *)
VAR
   j: integer;
   var2,var1,sd,df,cov,ave2,ave1: real;
BEGIN
   avevar(data1,n,ave1,var1);
   avevar(data2,n,ave2,var2);
   cov := 0.0;
   FOR j := 1 TO n DO BEGIN
      cov := cov+(data1[j]-ave1)*(data2[j]-ave2);
   END;
   df := n-1;
   cov := cov/df;
   sd := sqrt((var1+var2-2.0*cov)/n);
   t := (ave1-ave2)/sd;
   prob := betai(0.5*df,0.5,df/(df+sqr(t)))
END;
