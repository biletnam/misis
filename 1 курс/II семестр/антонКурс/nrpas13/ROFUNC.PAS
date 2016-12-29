FUNCTION rofunc(b: real): real;
(* Programs using ROFUNC must declare
CONST
   ndata = [the number of data points]
VAR
   aa,abdevt: real;
   x,y,arr: ARRAY [1..ndata] OF real;
in the main routine. *)
VAR
   d,sum: real;
   j,n1,nmh,nml: integer;
BEGIN
   n1 := ndata+1;
   nml := n1 DIV 2;
   nmh := n1-nml;
   FOR j := 1 TO ndata DO arr[j] := y[j]-b*x[j];
   sort(ndata,arr);
   aa := 0.5*(arr[nml]+arr[nmh]);
   sum := 0.0;
   abdevt := 0.0;
   FOR j := 1 TO ndata DO BEGIN
      d := y[j]-(b*x[j]+aa);
      abdevt := abdevt+abs(d);
      IF (d > 0.0) THEN sum := sum+x[j] ELSE sum := sum-x[j]
   END;
   rofunc := sum
END;
