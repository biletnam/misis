PROCEDURE rkdumb(vstart: glnarray; nvar: integer; x1,x2: real; nstep: integer);
(* Programs using routine RKDUMB must provide a
PROCEDURE derivs(x:real; v:glnarray; VAR dvdx:glnarray);
which returns the derivatives dvdx at location x, given both x and the
function values v. They must also define the type
TYPE
   glnarray = ARRAY [1..nvar] OF real;
where nvar is the number of functions. They must also
declare the variables
VAR
   xx: ARRAY [1..200] OF real;
   y: ARRAY [1..nvar,1..200] OF real;
in the main routine. *)
VAR
   k,i: integer;
   x,h: real;
   v,vout,dv: glnarray;
BEGIN
   FOR i := 1 TO nvar DO BEGIN
      v[i] := vstart[i];
      y[i,1] := v[i]
   END;
   xx[1] := x1;
   x := x1;
   h := (x2-x1)/nstep;
   FOR k := 1 TO nstep DO BEGIN
      derivs(x,v,dv);
      rk4(v,dv,nvar,x,h,vout);
      IF (x+h = x) THEN BEGIN
         writeln('pause in routine RKDUMB');
         writeln('stepsize to small'); readln
      END;
      x := x+h;
      xx[k+1] := x;
      FOR i := 1 TO nvar DO BEGIN
         v[i] := vout[i];
         y[i,k+1] := v[i]
      END
   END
END;
