program simpson;
var   n: integer;
   a, b: real;

function f(x: real): real;
begin
     f := x * exp(-x*x*x)
end;

function simp1(a, b: real; n: integer): real;
var   h, x, s: real;
       j, alt: integer;
begin
     h := (b - a)/2/n;   s := f(a) + f(b);
     x := a;           alt := 4;
     for j := 1 to 2*n - 1 do begin
         x := x + h;
         s := s + alt * f(x);
         alt := 6 - alt
         end;
     simp1 := h * s / 3
end;

begin
{     write('Enter endpoints A and B and number of divisions: ');
     readln(a, b, n); writeln;}
     writeln('Gamma function(2/3, x)');
     writeln('  x      gamma(2/3, x)');
     a := 0; n := 16;
     b := 0;
     while  b <= 2.5 do begin
            writeln(b:4:1, '      ', 3 * simp1(a, b, n):7:4);
            b := b + 0.1
            end;
     writeln
end.
