FUNCTION factrl(n: integer): real;
(* Programs using routing FACTRL must declare the variables
VAR
   glntop: integer;
   gla: ARRAY [1..33] OF real;
and initialize the values
   glntop := 0;
   gla[1] := 1.0;
in the main routine. *)
VAR
   j: integer;
BEGIN
   IF  (n < 0)  THEN BEGIN
      writeln('pause in FACTRL - negative factorial'); readln END
   ELSE IF (n <= glntop) THEN BEGIN
      factrl := gla[n+1] END
   ELSE IF (n <= 32) THEN BEGIN
      FOR j := glntop+1 TO n DO BEGIN
         gla[j+1] := j*gla[j]
      END;
      glntop := n;
      factrl := gla[n+1]
   END ELSE BEGIN
      factrl := exp(gammln(n+1.0))
   END
END;
