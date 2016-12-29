FUNCTION erf(x: real): real;
BEGIN
   IF (x < 0.0) THEN BEGIN
      erf := -gammp(0.5,sqr(x))
   END ELSE BEGIN
      erf := gammp(0.5,sqr(x))
   END
END;
