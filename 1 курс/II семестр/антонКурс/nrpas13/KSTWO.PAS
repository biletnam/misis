PROCEDURE kstwo(VAR data1: glarray1; n1: integer;
      VAR data2: glarray2; n2: integer;
      VAR d,prob: real);
(* Programs using routine KSTWO must define the types
TYPE
   glarray1 = ARRAY [1..n1] OF real;
   glarray2 = ARRAY [1..n2] OF real;
in the main routine.   *)
VAR
   i,j2,j1: integer;
   dum,en1,en2,fo2,fo1,fn2,fn1,dt: real;
BEGIN
   IF (n2 > n1) THEN BEGIN
      writeln('pause in routine KSTWO');
      writeln('first input array must be the larger'); readln
   END;
   sort(n1,data1);
   FOR i := 1 TO n2 DO BEGIN
      dum := data1[i];
      data1[i] := data2[i];
      data2[i] := dum
   END;
   sort(n2,data1);
   FOR i := 1 TO n2 DO BEGIN
      dum := data1[i];
      data1[i] := data2[i];
      data2[i] := dum
   END;
   en1 := n1;
   en2 := n2;
   j1 := 1;
   j2 := 1;
   fo1 := 0.0;
   fo2 := 0.0;
   d := 0.0;
   WHILE ((j1 <= n1) AND (j2 <= n2)) DO BEGIN
      IF (data1[j1] < data2[j2]) THEN BEGIN
         fn1 := j1/en1;
         IF (abs(fn1-fo2) > abs(fo1-fo2)) THEN BEGIN
            dt := abs(fn1-fo2)
         END ELSE BEGIN
            dt := abs(fo1-fo2)
         END;
         IF (dt > d) THEN d := dt;
         fo1 := fn1;
         j1 := j1+1;
      END ELSE BEGIN
         fn2 := j2/en2;
         IF (abs(fn2-fo1) > abs(fo2-fo1)) THEN BEGIN
            dt := abs(fn2-fo1)
         END ELSE BEGIN
            dt := abs(fo2-fo1)
         END;
         IF (dt > d) THEN d := dt;
         fo2 := fn2;
         j2 := j2+1
      END
   END;
   prob := probks(sqrt(en1*en2/(en1+en2))*d)
END;
