FUNCTION ran0(VAR idum: integer): real;
(* RAN0 assumes that the system random number generator is called RANDOM,
with no arguments. Programs using RAN0 must declare the following
variables
VAR
   gly: real;
   glv: ARRAY [1..97] OF real;
in the main routine. *)
VAR
   dum: real;
   j: integer;
BEGIN
   IF (idum < 0) THEN BEGIN
      idum := 1;
      FOR j := 1 TO 97 DO dum := random;
      FOR j := 1 TO 97 DO glv[j] := random;
      gly := random
   END;
   j := 1+trunc(97.0*gly);
   IF ((j > 97) OR (j < 1)) THEN BEGIN
      writeln('pause in routine RAN0'); readln END;
   gly := glv[j];
   ran0 := gly;
   glv[j] := random
END;
