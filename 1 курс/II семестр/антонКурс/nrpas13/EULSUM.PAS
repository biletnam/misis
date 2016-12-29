PROCEDURE eulsum(VAR sum: real; term: real; jterm: integer);
(* Programs using routine EULSUM must declare the variable array
   glwksp: ARRAY [1..np] OF real;
where np is a physical dimension larger than any value of jterm
to be used. Also declare
VAR
   glnterm: integer; *)
VAR
   j: integer;
   tmp,dum: real;
BEGIN
   IF (jterm = 1) THEN BEGIN
      glnterm := 1;
      glwksp[1] := term;
      sum := 0.5*term
   END ELSE BEGIN
      tmp := glwksp[1];
      glwksp[1] := term;
      FOR j := 1 TO glnterm-1 DO BEGIN
         dum := glwksp[j+1];
         glwksp[j+1] := 0.5*(glwksp[j]+tmp);
         tmp := dum
      END;
      glwksp[glnterm+1] := 0.5*(glwksp[glnterm]+tmp);
      IF (abs(glwksp[glnterm+1]) <= abs(glwksp[glnterm])) THEN BEGIN
         sum := sum+0.5*glwksp[glnterm+1];
         glnterm := glnterm+1
      END ELSE BEGIN
         sum := sum+glwksp[glnterm+1]
      END
   END
END;
