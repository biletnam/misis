PROGRAM NEWTON;
const EPS = 5.0e-7;  DEPS = 1.0e-3;
        N = 30;
var x, y, y1 : real;
           j : integer;

function f(x: real): real;
var s : real;
begin
     s := x * x;
     f := 0.03058*x*s - 0.74612*s + 14.39*x - 68
end;

function df(x: real): real;
const h = 0.001;
begin
     df := (f(x - 2*h) - 8*f(x - h) + 8*f(x + h) - f(x + 2*h)) / 12 / h
end;

begin
     write('Initial guess at x :  '); readln(x);
     j := 0;   y := f(x);   y1 := df(x);
     while (abs(y1) >= DEPS) and (j < N) and (abs(y) >= EPS) do begin
           j := j + 1;   x := x - y/y1;
           y := f(x);    y1 := df(x)
           end;
     if abs(y1) < DEPS then writeln('F'' too small at x = ', x)
     else if abs(y) < EPS then writeln('F( ',x,' ) = ', y:12)
     else writeln('Fails to converge.')
end.