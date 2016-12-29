FUNCTION ran2(VAR idum: integer): real;
(* Programs using RAN2 must declare the following variables
VAR
   gliy: integer;
   glir: ARRAY [1..97] OF integer;
in the main program. *)
CONST
   m=714025;
   ia=1366;
   ic=150889;
   rm=1.400512e-6;      (* 1.0/m *)
VAR
   j: integer;
BEGIN
   IF (idum < 0) THEN BEGIN
      idum := (ic-idum) MOD m;
      FOR j := 1 TO 97 DO BEGIN
         idum := (ia*idum+ic) MOD m;
         glir[j] := idum
      END;
      idum := (ia*idum+ic) MOD m;
      gliy := idum
   END;
   j := 1 + (97*gliy) DIV m;
   IF ((j > 97) OR (j < 1)) THEN BEGIN
      writeln('pause in routine RAN2'); readln
   END;
   gliy := glir[j];
   ran2 := gliy*rm;
   idum := (ia*idum+ic) MOD m;
   glir[j] := idum
END;
