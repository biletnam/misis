PROCEDURE quad3d(x1,x2: real; VAR ss: real);
(* Evaluates 3-dimensional integral with z integration innermost, then
y integration, and finally x integration. Unlike FORTRAN version, calls QGAUS
(here called QGAUS3) recursively. Programs using routine QUAD3D must define
the integrand by
FUNCTION func(x,y,z: real): real;
and functions for the limits of integration by
FUNCTION y1(x: real): real;
FUNCTION y2(x: real): real;
FUNCTION z1(x,y: real): real;
FUNCTION z2(x,y: real): real;
Also global variables
VAR
   glx,gly: real;
are required. *)
   PROCEDURE qgaus3(a,b: real; VAR ss: real; n: integer);
   VAR
      j: integer;
      xr,xm,dx: real;
      w,x: ARRAY [1..5] OF real;
   FUNCTION f(x: real; n: integer): real;
      VAR
         ss: real;
      BEGIN
         IF n=1 THEN BEGIN
            glx := x;
            qgaus3(y1(glx),y2(glx),ss,2);
            f := ss
         END ELSE IF n=2 THEN BEGIN
            gly := x;
            qgaus3(z1(glx,gly),z2(glx,gly),ss,3);
            f := ss
         END ELSE f := func(glx,gly,x)
      END;
   BEGIN
      x[1] := 0.1488743389;
      x[2] := 0.4333953941;
      x[3] := 0.6794095682;
      x[4] := 0.8650633666;
      x[5] := 0.97390652;
      w[1] := 0.2955242247;
      w[2] := 0.2692667193;
      w[3] := 0.2190863625;
      w[4] := 0.1494513491;
      w[5] := 0.06667134;
      xm := 0.5*(b+a);
      xr := 0.5*(b-a);
      ss := 0;
      FOR j := 1 TO 5 DO BEGIN
         dx := xr*x[j];
         ss := ss+w[j]*(f(xm+dx,n)+f(xm-dx,n))
      END;
      ss := xr*ss
   END;
BEGIN
   qgaus3(x1,x2,ss,1)
END;
