program telescope; {CACM 28, p.38}
const order = 32;
      Taylor: array [0..order] of real = (
  1.0000000000E+00,  1.0000000000E+00,  5.0000000000E-01,  1.6666666667E-01,
  4.1666666667E-02,  8.3333333333E-03,  1.3888888889E-03,  1.9841269841E-04,
  2.4801587302E-05,  2.7557319224E-06,  2.7557319224E-07,  2.5052108385E-08,
  2.0876756988E-09,  1.6059043837E-10,  1.147074559E-11,   7.6471637318E-13,
  4.7794773324E-14,  2.8114572543E-15,  1.561920696E-16,   8.2206352466E-18,
  4.1103176233E-19,  1.9572941063E-20,  8.8967913925E-22,  3.8681701706E-23,
  1.6117375711E-24,  6.4469502844E-26,  2.4795962632E-27,  9.1836898638E-29,
  3.2798892371E-30,  1.1309962886E-31,  3.7699876288E-33,  1.2161250416E-34,
  3.8003907549E-36);

type series = array [0..order] of real;
var i, i2, j: integer;
    r, eps: real;
    c: series;

function fact(n: real): real;
begin
     if n = 0 then fact := 1
     else fact := n * fact(n - 1)
end;

procedure telescope(var n: integer; var eps: real;
                        limit, l: real; var c: series);
var k: integer;
    s: real;
    d: series;
label start, exit;
begin
start:  if n < 2 then goto exit;
        d[n] := -c[n];
        k := n;
        while k >= 2 do begin
           d[k-2] := -d[k] * sqr(l) * k * (k-1)/
                     ((n+k-2)*(n-k+2));
           k := k - 2;
           end;
        if odd(n) then s := d[1]/n else s := d[0];
        if (eps + abs(s) < limit) then begin
           eps := eps + abs(s);
           k := n;
           while k > 0 do begin
              c[k] := c[k] + d[k];
              k := k - 2
              end;
           n := n - 1; goto start;
           end;
exit:  end;

function pwr(x: real; i:integer): real;
{Returns integer power of x, any integer i}
var j: integer;
    s, t: real;
begin
     if i = 0 then pwr := 1
     else begin
        if i < 0 then begin
           j := -i;  s := 1/x;  t := 1/x;
           end
        else begin
           j := i;  s := x;  t := x;
           end;
        while j > 1 do begin
           if odd(j) then begin
              j := j - 1;
              t := t * s;
              end
           else begin
              j := j div 2;
              t := sqr(t);
              end;
           end;  {while}
        pwr := t;
        end;     {i <> 0}
end;

{ get a telescoped series for cos(x). The error is about 1e-5}
begin
     for i := 0 to order do c[i] := 0;
     for i := 0 to order div 2 do begin
         i2 := 2*i;
         c[i2] := Taylor[i2];
         if odd(i) then c[i2] := -c[i2];
         end;
     writeln;
     writeln(i2);
     eps := 0.00001;
{The value of 'limit' determines number of significant figures; limit = 1e-7
 gives same result as built-in function, but uses whole series.}
{             (N,  eps, limit,   L,    c)}
     telescope(i2, eps, 1.0e-4, pi/2, c);
     writeln('Epsilon: ', eps);
     for j := 0 to i2 do
         writeln(j, '  ', c[j]);
     r := 0;
     for j := 0 to i2 do  {estimate cos(45)}
         r := r + c[j] * pwr(pi/4, j);
     writeln('Estimated value of cos(45): ', r);
     writeln('True value:                 ', cos(pi/4));
end.
