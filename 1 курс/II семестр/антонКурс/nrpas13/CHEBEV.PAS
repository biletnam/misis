FUNCTION chebev(a,b: real; c: glcarray; m: integer; x:real): real;
(* Programs using routine CHEBEV must define the type
glcarray as in routine CHEBFT. *)
VAR
   d,dd,sv,y,y2: real;
   j: integer;
BEGIN
   IF  (((x-a)*(x-b)) > 0.0) THEN BEGIN
      writeln('pause in CHEBEV - x not in range.'); readln
   END;
   d := 0.0;
   dd := 0.0;
   y := (2.0*x-a-b)/(b-a);
   y2 := 2.0*y;
   FOR j := m DOWNTO 2 DO BEGIN
      sv := d;
      d := y2*d-dd+c[j];
      dd := sv
   END;
   chebev := y*d-dd+0.5*c[1]
END;
