PROCEDURE ksone(VAR data: gldarray; n: integer; VAR d,prob: real);
(* Programs using routine KSONE must define the type
TYPE
   gldarray = ARRAY [1..n] OF real;
in the main routine. *)
VAR
   j: integer;
   fo,fn,ff,en,dt: real;
BEGIN
   sort(n,data);
   en := n;
   d := 0.0;
   fo := 0.0;
   FOR j := 1 TO n DO BEGIN
      fn := j/en;
      ff := func(data[j]);
      IF (abs(fo-ff) > abs(fn-ff)) THEN BEGIN
         dt := abs(fo-ff)
      END ELSE BEGIN
         dt := abs(fn-ff)
      END;
      IF (dt > d) THEN d := dt;
      fo := fn
   END;
   prob := probks(sqrt(en)*d)
END;
