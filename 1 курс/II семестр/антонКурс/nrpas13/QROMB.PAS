PROCEDURE qromb(a,b: real; VAR ss: real);
(* Programs using routine QROMB must define type
TYPE
   glnarray = ARRAY [1..n] OF real;
just as for routine POLINT which it calls. In this case
n should have a value no smaller than the constant k below. *)
LABEL 99;
CONST
   eps=1.0e-6;
   jmax=20;
   jmaxp=21;   (* jmax+1 *)
   k=5;
VAR
   i,j: integer;
   dss: real;
   h,s: ARRAY[1..jmaxp] OF real;
   c,d: glnarray;
BEGIN
   h[1] := 1.0;
   FOR j := 1 TO jmax DO BEGIN
      trapzd(a,b,s[j],j);
      IF  (j >= k)  THEN BEGIN
         FOR i := 1 TO k DO BEGIN
            c[i] := h[j-k+i];
            d[i] := s[j-k+i]
         END;
         polint(c,d,k,0.0,ss,dss);
         IF (abs(dss) < eps*abs(ss)) THEN GOTO 99
      END;
      s[j+1] := s[j];
      h[j+1] := 0.25*h[j]
   END;
   writeln('pause in QROMB - too many steps'); readln;
99:   END;
