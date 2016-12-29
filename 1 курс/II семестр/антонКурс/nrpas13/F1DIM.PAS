FUNCTION f1dim(x: real): real;
(* Programs using F1DIM must declare the variables
TYPE
   glndim = ARRAY [1..ndim] OF real;
VAR
   ncom: integer;
   pcom,xicom: glndim;
and assign values to them externally. *)
VAR
   j: integer;
   xt: glndim;
BEGIN
   FOR j := 1 TO ncom DO BEGIN
      xt[j] := pcom[j]+x*xicom[j]
   END;
   f1dim := fnc(xt)
END;
