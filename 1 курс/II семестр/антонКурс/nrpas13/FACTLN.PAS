FUNCTION factln(n: integer): real;
(* Programs using routine FACTLN must declare the array
VAR
   gla: ARRAY [1..100] OF real;
and must initialize the array to the values
   FOR i := 1 TO 100 DO gla[i] := -1.0;
in the main routine. *)
BEGIN
   IF  (n < 0) THEN BEGIN
      writeln ('pause in FACTLN - negative factorial'); readln END
   ELSE IF (n <= 99) THEN BEGIN
      IF  (gla[n+1] < 0.0) THEN  gla[n+1] := gammln(n+1.0);
      factln := gla[n+1] END
   ELSE BEGIN
      factln := gammln(n+1.0)
   END
END;
