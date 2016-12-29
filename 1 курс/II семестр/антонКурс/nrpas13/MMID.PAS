PROCEDURE mmid(y,dydx: glnarray; nvar: integer; xs,htot: real;
      nstep: integer; VAR yout: glnarray);
(* Programs using routine MMID must provide a
PROCEDURE derivs(x:real; y:glnarray; VAR dydx:glnarray);
which returns the derivatives dydx at location x, given both x and the
function values y. They must also define the type
TYPE
   glnarray = ARRAY [1..nvar] OF real;
in the main routine.  Note that this routine is in
single precision, unlike the FORTRAN version. *)
VAR
   n,i: integer;
   x,swap,h2,h: real;
   ym,yn: glnarray;
BEGIN
   h := htot/nstep;
   FOR i := 1 TO nvar DO BEGIN
      ym[i] := y[i];
      yn[i] := y[i]+h*dydx[i]
   END;
   x := xs+h;
   derivs(x,yn,yout);
   h2 := 2.0*h;
   FOR n := 2 TO nstep DO BEGIN
      FOR i := 1 TO nvar DO BEGIN
         swap := ym[i]+h2*yout[i];
         ym[i] := yn[i];
         yn[i] := swap
      END;
      x := x+h;
      derivs(x,yn,yout)
   END;
   FOR i := 1 TO nvar DO BEGIN
      yout[i] := 0.5*(ym[i]+yn[i]+h*yout[i])
   END
END;
