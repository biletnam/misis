PROCEDURE hunt(xx: glnarray; n: integer;
      x: real; VAR jlo: integer);
(* Programs using routine HUNT must define the type
TYPE
   glnarray = ARRAY [1..n] OF real;
in the main routine. *)
LABEL 1,2,3,4;
VAR
   jm,jhi,inc: integer;
   ascnd: boolean;
BEGIN
   ascnd := xx[n] > xx[1];
   IF ((jlo <= 0) OR (jlo > n)) THEN BEGIN
      jlo := 0;
      jhi := n+1;
      GOTO 3
   END;
   inc := 1;
   IF ((x >= xx[jlo]) = ascnd ) THEN BEGIN
1:      jhi := jlo+inc;
      IF (jhi > n) THEN BEGIN
         jhi := n+1
      END ELSE IF ((x >= xx[jhi]) = ascnd ) THEN BEGIN
         jlo := jhi;
         inc := inc+inc;
         GOTO 1
      END
   END ELSE BEGIN
      jhi := jlo;
2:      jlo := jhi-inc;
      IF (jlo < 1) THEN BEGIN
         jlo := 0
      END ELSE IF ((x < xx[jlo]) = ascnd ) THEN BEGIN
         jhi := jlo;
         inc := inc+inc;
         GOTO 2
      END
   END;
3:   IF ((jhi-jlo) = 1) THEN GOTO 4;
   jm := (jhi+jlo) DIV 2;
   IF ((x > xx[jm]) = ascnd ) THEN BEGIN
      jlo := jm
   END ELSE BEGIN
      jhi := jm
   END;
   GOTO 3;
4:
END;
