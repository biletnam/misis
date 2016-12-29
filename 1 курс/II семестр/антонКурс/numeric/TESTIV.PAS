program testabm;
type init = array [0..3] of real;
var x0, h: real;
    y: init;
    i,j,n: integer;

function f(x, y: real): real;
begin    f := x - y*y  end;

procedure abm(n:integer; h,x0: real; y: init);
var v,d: array [0..4] of real;
      x: real;
    j,k: integer;

  procedure next(k: integer);
  var temp: real;
  begin
       temp := 55*d[3] - 59*d[2] + 37*d[1] - 9*d[0];
       v[4] := v[3] + h*temp/24;
       d[4] := f(x, v[4]);
       temp := 9*d[4] + 19*d[3] - 5*d[2] + d[1];
       v[4] := v[3] + h * temp/24;
       if k mod 5 = 0 then writeln;
       writeln(x:10:2, v[4]:11:7);
       d[4] := f(x, v[4]);
       for j := 0 to 3 do begin
           d[j] := d[j+1];  v[j] := v[j+1] end;
       x := x + h;
       end;  { NEXT }
begin { ABM }
     x := x0;
     for j := 0 to 3 do begin
         v[j] := y[j];
         d[j] := f(x, v[j]);
         writeln(x:10:2, v[j]:11:7);
         x := x + h;
         end;
     for k := 4 to n do next(k);
end; { ABM }

procedure initval(h, x0, y0: real; var y: init);
var j: integer;
    x, d: init;
begin
     for j := 0 to 3 do x[j] := x0 + j*h;
     y[0] := y0;  d[0] := f(x[0], y[0]);
  {First order part}
     y[1] := y[0] + h*d[0];
     d[1] := f(x[1], y[1]);
     y[1] := y[0] + h*(d[1] + d[0])/2;
     d[1] := f(x[1], y[1]);
  {Second order part}
     y[2] := y[1] + h*(3*d[1] - d[0])/2;
     d[2] := f(x[2], y[2]);
     y[2] := y[1] + h*(5*d[2] + 8*d[1] - d[0])/12;
     d[2] := f(x[2], y[2]);
  {Third...}
     y[3] := y[2] + h*(23*d[2] - 16*d[1] + 5*d[0])/12;
     d[3] := f(x[3], y[3]);
     y[3] := y[2] + h*(9*d[3] + 19*d[2] - 5*d[1] + d[0])/24;
end;  { INITVAL }

begin
     ClrScr;
     writeln('    Adams-Bashforth-Moulton Method');
     writeln('    y'' = x - y^2,  y(0) = 0');
     h := 0.01;  x0 := 0;  n := 10;
     initval(h, x0, 0, y);
     writeln('X':7, 'Y':6);
     writeln;
     abm(n, h, x0, y);
end.