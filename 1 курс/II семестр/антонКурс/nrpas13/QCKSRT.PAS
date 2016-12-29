PROCEDURE qcksrt(n: integer; VAR arr: glarray);
(* Programs using routine QCKSRT must define the type
TYPE
   glarray = ARRAY [1..np] OF real;
in the main routine, with np >= n.   *)
LABEL 11,21,22,30,99;
CONST
   m=7;
   nstack=50;
   fm=7875;
   fa=211.0;
   fc=1663.0;
VAR
   l,jstack,j,ir,iq,i: integer;
   fx,fmi,a: real;
   istack: ARRAY[1..nstack] OF integer;
BEGIN
   fmi := 1.0/fm;
   jstack := 0;
   l := 1;
   ir := n;
   fx := 0.0;
   WHILE true DO BEGIN
      IF ((ir-l) < m) THEN BEGIN
         FOR j := l+1 TO ir DO BEGIN
            a := arr[j];
            FOR i := j-1 DOWNTO 1 DO BEGIN
               IF (arr[i] <= a) THEN GOTO 11;
               arr[i+1] := arr[i]
            END;
            i := 0;
11:            arr[i+1] := a
         END;
         IF (jstack = 0) THEN GOTO 99;
         ir := istack[jstack];
         l := istack[jstack-1];
         jstack := jstack-2
      END ELSE BEGIN
         i := l;
         j := ir;
         fx := (fx*fa+fc)/fm;
         fx := fx-trunc(fx);
         iq := l+(ir-l+1)*trunc(fx*fmi);
         a := arr[iq];
         arr[iq] := arr[l];
21:         IF (j > 0) THEN BEGIN
            IF (a < arr[j]) THEN BEGIN
               j := j-1;
               GOTO 21
            END
         END;
         IF (j <= i) THEN BEGIN
            arr[i] := a;
            GOTO 30
         END;
         arr[i] := arr[j];
         i := i+1;
22:         IF (i <= n) THEN IF (a > arr[i]) THEN BEGIN
            i := i+1;
            GOTO 22
         END;
         IF (j <= i) THEN BEGIN
            arr[j] := a;
            i := j;
            GOTO 30
         END;
         arr[j] := arr[i];
         j := j-1;
         GOTO 21;
30:         jstack := jstack+2;
         IF (jstack > nstack) THEN BEGIN
            writeln('pause in QCKSRT - NSTACK must be made larger'); readln
         END;
         IF ((ir-i) >= (i-l)) THEN BEGIN
            istack[jstack] := ir;
            istack[jstack-1] := i+1;
            ir := i-1
         END ELSE BEGIN
            istack[jstack] := i-1;
            istack[jstack-1] := l;
            l := i+1
         END
      END
   END;
99:   END;
