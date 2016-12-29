PROCEDURE rk4(y,dydx: glnarray; n: integer; x,h: real; VAR yout: glnarray);
(* Programs using routine RK4 must provide a
PROCEDURE derivs(x:real; y:glnarray; VAR dydx:glnarray);
which returns the derivatives dydx at location x, given both x and the
function values y. The calling program must also define the types
TYPE
   glnarray = ARRAY [1..nvar] OF real;
where nvar is the number of variables y. *)
VAR
   i: integer;
   xh,hh,h6: real;
   dym,dyt,yt: glnarray;
BEGIN
   hh := h*0.5;
   h6 := h/6.0;
   xh := x+hh;
   FOR i := 1 TO n DO BEGIN
      yt[i] := y[i]+hh*dydx[i]
   END;
   derivs(xh,yt,dyt);
   FOR i := 1 TO n DO BEGIN
      yt[i] := y[i]+hh*dyt[i]
   END;
   derivs(xh,yt,dym);
   FOR i := 1 TO n DO BEGIN
      yt[i] := y[i]+h*dym[i];
      dym[i] := dyt[i]+dym[i]
   END;
   derivs(x+h,yt,dyt);
   FOR i := 1 TO n DO BEGIN
      yout[i] := y[i]+h6*(dydx[i]+dyt[i]+2.0*dym[i])
   END
END;
