FUNCTION gammq(a,x: real): real;
VAR
   gamser,gln: real;
BEGIN
   IF ((x < 0.0) OR (a <= 0.0)) THEN BEGIN
      writeln('pause in GAMMQ - invalid arguments'); readln
   END;
   IF (x < a+1.0) THEN BEGIN
      gser(a,x,gamser,gln);
      gammq := 1.0-gamser
   END ELSE BEGIN
      gcf(a,x,gamser,gln);
      gammq := gamser
   END
END;
