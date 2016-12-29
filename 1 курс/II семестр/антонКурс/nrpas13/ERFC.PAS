FUNCTION erfc(VAR x: real): real;
BEGIN
   IF (x < 0.0) THEN BEGIN
      erfc := 1.0+gammp(0.5,sqr(x))
   END ELSE BEGIN
      erfc := gammq(0.5,sqr(x))
   END
END;
