FUNCTION df1dim(x: real): real;
(* Programs using routine DF1DIM must define the type
TYPE
   glnarray = ARRAY [1..n] OF real;
They must also define the variables
VAR
   ncom: integer;
   pcom,xicom: glnarray
in the main routine, and externally assign them values. *)
VAR
   df1: real;
   j: integer;
   xt,df: glnarray;
BEGIN
   FOR j := 1 TO ncom DO BEGIN
      xt[j] := pcom[j]+x*xicom[j]
   END;
   dfunc(xt,df);
   df1 := 0.0;
   FOR j := 1 TO ncom DO BEGIN
      df1 := df1+df[j]*xicom[j]
   END;
   df1dim := df1
END;
