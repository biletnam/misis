program runge_kutta;
var x, y, h: real;

function f(x,y: real): real;
begin     f := x - y*y    end;

function rk(x, y, h: real): real;
var m: array [0..3] of real;
    h_2: real;
begin
     h_2 := 0.5 * h;
     m[0] := f(x,y);
     m[1] := f(x + h_2, y + h_2*m[0]);
     m[2] := f(x + h_2, y + h_2*m[1]);
     m[3] := f(x + h, y + h*m[2]);
     rk := y + h*(m[0] + 2*m[1] + 2*m[2] + m[3])/6;
end;

begin
     x := 0;  y := 0;  h := 0.01;
     writeln('    Runge-Kutta Method');
     writeln('    y'' = x - y^2,  y(0) = 0');
     writeln('x':11, 'y':11);
     while x <= 0.1 do begin
           writeln(x:11:6, y:11:6);
           y := rk(x, y, h);
           x := x + h;
           end;
end.