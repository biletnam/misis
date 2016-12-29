program erf4;
(*** Error function and complementary error function ***)
var x, er, ec: real;
done: boolean;

function erf(x: real): real;
const sqrtpi = 1.772453851;
      t2 = 0.66666666667;
      t3 = 0.26666666667;
      t4 = 0.07619048;
      t5 = 0.01693122;
      t6 = 3.078403e-3;
      t7 = 4.736005e-4;
      t8 = 6.314673e-5;
      t9 = 7.429027e-6;
      t10 = 7.820028e-7;
      t11 = 7.447646e-8;
      t12 = 6.47621e-9;
var x2, sum: real;
begin
     x2 := x * x;
     sum := t5 + x2 * (t6 + x2 * (t7 + x2 * (t8 + x2 *
                      (t9 + x2 * (t10 + x2 * (t11 + x2 * t12))))));
     erf := 2.0 * exp(-x2) / sqrtpi *
                  (x * (1 + x2 * (t2 + x2 * (t3 + x2 * (t4 + x2 * sum)))))
end;

function erfc(x: real): real;
const sqrtpi = 1.772453851;
var x2, v, sum: real;
begin
     x2 := x * x;
     v := 1 / (2 * x2);
     sum := v/(1 + 8*v / (1 + 9*v / (1 + 10*v / (1 + 11*v / (1 + 12*v)))));
     sum := v/(1 + 3*v / (1 + 4*v / (1 + 5*v / (1 + 6*v / (1 + 7 * sum)))));
     erfc := 1 / (exp(x2) * x * sqrtpi * (1 + v/(1 + 2*sum)))
end;

begin
     done := false;
     writeln('*** Program gives the erf and erfc of positve numbers ***');
     writeln('*** Enter a negative number to stop this program      ***');
     writeln;
     repeat
           write('Erf, Erfc of '); readln(x);
           if x < 0 then done := true
           else begin
              if x = 0 then begin
                 er := 0.0;
                 ec := 1.0
                 end
              else begin
                 if x < 1.5 then begin
                    er := erf(x);
                    ec := 1 - er
                    end
                 else begin
                    ec := erfc(x);
                    er := 1 - ec
                    end
                 end;  { if }
           writeln(x:7:3, ' erf =  ', er, '  erfc = ', ec)
           end
     until done
end.


