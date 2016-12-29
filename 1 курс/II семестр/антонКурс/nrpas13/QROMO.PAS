PROCEDURE qromo(a,b: real; VAR ss: real);
(* Programs using routine QROMO must define the type
TYPE
   glnarray = ARRAY [1..n] OF real;
in the main routine, where n is equal to the constant k below. The routine
func(x:real):real in the calling routine must return the value of the function
to be integrated.  You must choose MIDPNT, MIDSQL, MIDSQU or MIDINF at the
indicated point below *)
LABEL 99;
CONST
   eps=1.0e-6;
   jmax=14;
   jmaxp=15;   (* jmaxp=jmax+1 *)
   k=5;
   km=4;      (* km=k-1 *)
VAR
   i,j: integer;
   dss: real;
   h,s: ARRAY [1..jmaxp] OF real;
   c,d: glnarray;
BEGIN
   h[1] := 1.0;
   FOR j := 1 TO jmax DO BEGIN
(* Here you must choose the appropriate integration method *)
      midsql(a,b,s[j],j);
      IF  (j >= k)  THEN BEGIN
         FOR i := 1 TO k DO BEGIN
            c[i] := h[j-k+i];
            d[i] := s[j-k+i]
         END;
         polint(c,d,k,0.0,ss,dss);
         IF (abs(dss) < (eps*abs(ss))) THEN GOTO 99
      END;
      s[j+1] := s[j];
      h[j+1] := h[j]/9.0
   END;
   writeln('pause in QROMO - too many steps');
   readln;
99: END;
