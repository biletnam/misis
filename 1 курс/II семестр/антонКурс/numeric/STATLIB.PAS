{ requires globals "size: integer" and type "sample: array[..]of real}
type sample = array [1..100] of real;
var size: integer;

function summ(var v: sample):real;
var ctr: integer;
    sum: real;
begin
     sum := 0;
     for ctr := 1 to size do
         sum := sum + v[ctr];
     summ := sum
end;

function mean(var v: sample): real;
begin
     mean := summ(v)/size;
end;

function prod(var u, v: sample):real;
var ctr: integer;
    sum: real;
begin
     sum := 0;
     for ctr := 1 to size do
         sum := sum + u[ctr]*v[ctr];
     prod := sum
end;

function error(var u : sample): real;
var m: real;
    i: integer;
    z: sample;
begin
     m := mean(u);
     for i := 1 to size do
         z[i] := u[i] - m;
     error := sqrt(prod(z,z)/(size - 1))
end;

function detr(var u: sample):real;
begin
     detr := sqr(summ(u)) - size * prod(u,u)
end;

function bestm(var x,y: sample): real;
var t: real;
begin
     t := summ(y)*summ(x) - size*prod(x,y);
     bestm := t/detr(x)
end;

function bestb(var x,y: sample): real;
var t: real;
begin
     t := summ(x)*prod(x,y) - summ(y)*prod(x,x);
     bestb := t/detr(x)
end;

procedure getdata(var x: sample; var size: integer);
begin
     size := 0;
     repeat
           size := size + 1;
           readln(x[size])
     until eof
end;

procedure getpairs(var x,y: sample; var size: integer);
begin
     size := 0;
     repeat
           size := size + 1;
           readln(x[size],y[size])
     until eof
end;

procedure putdata(var x: sample);
var i : integer;
begin
     for i := 1 to size do
         writeln(x[i])
end;

procedure putpairs(var x,y: sample);
var i: integer;
begin
     for i := 1 to size do
         writeln(x[i],y[i])
end;

procedure trans(var x: sample; a,b: real);
var i : integer;
begin
     for i := 1 to size do
         x[i] := a * x[i] + b
end;

function maxpoint(var x: sample): integer;
var pt, ctr: integer;
    m: real;
begin
     m := x[1];
     pt := 1;
     for ctr := 2 to size do
         if x[ctr] > m then begin
            pt := ctr;
            m := x[ctr]
         end;
     maxpoint := pt
end;

function minpoint(var x: sample): integer;
var pt, ctr: integer;
    m: real;
begin
     m := x[1];
     pt := 1;
     for ctr := 2 to size do
         if x[ctr] < m then begin
            pt := ctr;
            m := x[ctr]
         end;
     minpoint := pt
end;

procedure add(var x,y: sample);
var i : integer;
begin
     for i := 1 to size do
         x[i] := x[i] + y[i]
end;

function poiss(mean: real): integer;
{produces random integers according to the Poisson distribution}
var sum: real;
    ctr: integer;
begin
     sum := 0;
     ctr := -1;
     repeat
           ctr := ctr + 1;
           sum := sum - ln(random(1))
     until sum > mean;
     poiss := ctr
end;

function gauss(mean, variance: real): real;
var u,v,x: real;
begin
     repeat
           u := random(1);
           v := random(1);
           if u = 0.0 then u := 0.000000001;
           x := 2.0 * (v - 0.5)/u
     until sqr(x) <= -(4.0 * ln(u));
     gauss := x * sqrt(variance) + mean;
end;
