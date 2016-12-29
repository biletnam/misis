PROCEDURE qgaus(a,b: real; VAR ss: real);
(* Programs using routine QGAUS must externally define
a function func(x:real):real which is to be integrated *)
VAR
   j: integer;
   xr,xm,dx: real;
   w,x: ARRAY[1..5] OF real;
BEGIN
   x[1] := 0.1488743389;
   x[2] := 0.4333953941;
   x[3] := 0.6794095682;
   x[4] := 0.8650633666;
   x[5] := 0.97390652;
   w[1] := 0.2955242247;
   w[2] := 0.2692667193;
   w[3] := 0.2190863625;
   w[4] := 0.1494513491;
   w[5] := 0.06667134;
   xm := 0.5*(b+a);
   xr := 0.5*(b-a);
   ss := 0;
   FOR j := 1 TO 5 DO BEGIN
      dx := xr*x[j];
      ss := ss+w[j]*(func(xm+dx)+func(xm-dx))
   END;
   ss := xr*ss
END;
