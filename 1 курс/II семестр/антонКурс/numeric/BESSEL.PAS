program bess;
{calculates Bessel function. There is a very much more elegant recursive
solution, but this is a lot faster.}
var r: real;

function gam(x: real): real;
var y, f: real;

function sgam(y: real): real;
var tmp, f: real;
begin
     f := y;
     tmp := f;
     f := f * y;
     tmp := tmp + f * 0.5772156649;
     f := f * y;
     tmp := tmp + f * (-0.6558780715);
     f := f * y;
     tmp := tmp + f * (-0.04200263503);
     f := f * y;
     tmp := tmp + f * 0.1665386114;
     f := f * y;
     tmp := tmp + f * (-0.042197734555);
     f := f * y;
     tmp := tmp + f * (-0.0096219715279);
     f := f * y;
     tmp := tmp + f * 0.0072189432;
     f := f * y;
     tmp := tmp + f * (-0.001165167592);
     f := f * y;
     tmp := tmp + f * (-0.000215241674115);
     f := f * y;
     tmp := tmp + f * 0.000128050283882;
     f := f * y;
     tmp := tmp + f * (-0.00002013485478);
     f := f * y;
     tmp := tmp + f * (-0.00001250493482);
     f := f * y;
     tmp := tmp + f * ( 0.0000011330272320);
     f := f * y;
     tmp := tmp + f * (-0.000002056338417);
     f := f * y;
     tmp := tmp + f * ( 0.0000000061160950);
     f := f * y;
     tmp := tmp + f * ( 0.0000000050020075);
     f := f * y;
     tmp := tmp + f * (-0.0000000011812746);
     f := f * y;
     tmp := tmp + f * ( 0.0000000001043427);
     f := f * y;
     tmp := tmp + f * ( 0.0000000000077823);
     f := f * y;
     tmp := tmp + f * (-0.0000000000036968);
     f := f * y;
     tmp := tmp + f * ( 0.0000000000000510);
     sgam := 1 / tmp
end;
begin
     if x = 1 then gam := 1
     else begin
          if x < 0 then
             gam := -(pi / (x * sin(pi * x) * gam(-x)))
          else begin
             y := x;
             f := 1;
             while y > 1 do begin
                   y := y - 1;
                   f := f * y
                   end;
             if y = 1 then gam := f
             else begin
                if y > 0.5 then
                   gam := f * pi / (sin(pi * y) * gam(1 - y))
                else
                   gam := f * sgam(y)
                end
             end
           end
end;

function J(nu, z: real): real; (*** BESSEL FUNCTION ***)
var n, d, f, sum: real;
    ctr: integer;
begin
    if z = 0 then begin
       if nu = 0 then j := 1
       else j := 0
       end
    else begin
       f := 1 / gam(nu + 1);
       n := -(sqr(z) / 4);
       d := nu + 1;
       sum := f;
       ctr := 1;
       repeat
           f := f * n / (ctr * d);
           d := d + 1;
           ctr := ctr + 1;
           sum := sum + f;
       until abs(f) < 1.0e-13;
       if z > 0 then
           j := sum * exp(nu * ln(z / 2))
       else
           j := (1 - 2 * (trunc(nu) mod 2)) * sum * exp(nu * ln(abs(z/2)))
       end
end;

begin
     writeln('Bessel functions -- orders 0, 1 and 2');
     writeln;
     repeat
           write('Bessel function of  '); readln(r);
           writeln(J(0,r),'  ', J(1,r),'  ',J(2,r));
     until false
end.
