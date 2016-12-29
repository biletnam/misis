program multint;
const   N = 1;
        M = 2;
type  vec = array [1..M] of real;
var a, b, x: vec;
       j, k: integer;
          p: array [1..N] of integer;

function f(x: vec): real;
var t2, t4, t8: real;
begin
     t2 := sqr(x[1]);  t4 := sqr(t2);  t8 := sqr(t4);
     f :=  t4 * t8    {ln(x[1])}
end;

function g(y: real): real; forward;

function simp1(a, b: real; q: integer): real;
var h, x, s: real;
       j, l: integer;
begin
     h := 0.5 * (b - a)/q;   s := g(a) + g(b);
     x := a;                 l := 4;
     for j := 1 to 2*q - 1 do begin
         x := x + h;
         s := s + l * g(x);
         l := 6 - l;
         end;
     simp1 := h * s / 3
end;

function g;
begin
     x[k] := y;  k := k - 1;
     if k = 0 then g := f(x)
     else g := simp1(a[k], b[k], p[k]);
     k := k + 1
end;

begin
     repeat
           writeln('Enter the ', N, ' pairs of bounds: ');
           for j := 1 to N do begin
               write('A[',j,']  B[',j,'] :  ');
               readln(a[j], b[j])
               end;
           writeln('Enter the number N[J] to be use in each dimension;');
           write('Simpson''s 2N[J]-point rule');
           writeln(' will be used in dimension J:');
           for j := 1 to N do begin
               write('Enter N[',j,']: '); readln(p[j]);
               end;
           k := M;
           writeln('Multiple integral = ', g(0));
           writeln
     until eof
end.