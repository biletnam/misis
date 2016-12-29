PROCEDURE tridag(a,b,c,r: glnarray; VAR u: glnarray; n: integer);
(* Programs using routine TRIDAG should define the type
TYPE
   glnarray = ARRAY [1..n] OF real;
in the main routine. *)
VAR
   j: integer;
   bet: real;
   gam: glnarray;
BEGIN
   IF (b[1] = 0.0) THEN BEGIN writeln('pause 1 in TRIDAG'); readln END;
   bet := b[1];
   u[1] := r[1]/bet;
   FOR j := 2 TO n DO BEGIN
      gam[j] := c[j-1]/bet;
      bet := b[j]-a[j]*gam[j];
      IF (bet = 0.0) THEN BEGIN writeln('pause 2 in TRIDAG'); readln END;
      u[j] := (r[j]-a[j]*u[j-1])/bet
   END;
   FOR j := n-1 DOWNTO 1 DO BEGIN
      u[j] := u[j]-gam[j+1]*u[j+1]
   END
END;
