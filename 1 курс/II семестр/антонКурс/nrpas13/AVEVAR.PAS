PROCEDURE avevar(data: glnparray; n: integer; VAR ave,svar: real);
(* Programs using routine AVEVAR must define type
TYPE
   glnparray = ARRAY [1..np] OF real;
in the main routine, with np >= n.   *)
VAR
   j: integer;
   s: real;
BEGIN
   ave := 0.0;
   svar := 0.0;
   FOR j := 1 TO n DO BEGIN
      ave := ave+data[j];
   END;
   ave := ave/n;
   FOR j := 1 TO n DO BEGIN
      s := data[j]-ave;
      svar := svar+s*s
   END;
   svar := svar/(n-1)
END;
