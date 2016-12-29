PROCEDURE frprmn(VAR p: glnarray; n: integer; ftol: real;
       VAR iter: integer; VAR fret: real);
(* Programs using routine FRPRMN must supply a
FUNCTION fnc(p: glnarray):real; and a
PROCEDURE dfnc(p: glnarray; VAR g: glnarray);
which evaluate a function and its gradient. They must
also define the type
TYPE
   glnarray = ARRAY [1..n] OF real;
in the main routine. *)
LABEL 99;
CONST
   itmax=200;
   eps=1.0e-10;
VAR
   j,its: integer;
   gg,gam,fp,dgg: real;
   g,h,xi: glnarray;
BEGIN
   fp := fnc(p);
   dfnc(p,xi);
    FOR j := 1 TO n DO BEGIN
      g[j] := -xi[j];
      h[j] := g[j];
      xi[j] := h[j]
   END;
   FOR its := 1 TO itmax DO BEGIN
      iter := its;
      linmin(p,xi,n,fret);
      IF ((2.0*abs(fret-fp)) <= (ftol*(abs(fret)+abs(fp)+eps)))
         THEN GOTO 99;
      fp := fnc(p);
      dfnc(p,xi);
      gg := 0.0;
      dgg := 0.0;
      FOR j := 1 TO n DO BEGIN
         gg := gg+sqr(g[j]);
(*         dgg := dgg+sqr(xi[j])   *)
         dgg := dgg+(xi[j]+g[j])*xi[j]
      END;
      IF (gg = 0.0) THEN GOTO 99;
      gam := dgg/gg;
      FOR j := 1 TO n DO BEGIN
         g[j] := -xi[j];
         h[j] := g[j]+gam*h[j];
         xi[j] := h[j]
      END
   END;
   writeln('pause in routine FRPRMN');
   writeln('too many iterations'); readln;
99:   END;
