program rkn;
{ Program applies the Runge-Kutta-Nystrom method to solve a second-
  order differential equation. With a value h = 0.02, the solution
  agrees with the exact analytic solution to at least seven decimal
  places. Algorithm from Kreyzig, 'Advanced Engineering Mathematics',
  5th edition, section 21.3, page 844.}

var
   h, t, y, y_prime: real;
   n : integer;
   R, L, C, V0: real;
   Ro2L, alphasq, alpha, trueV: real;

function fn(x,y,dy: real): real;
{ V" = -(RCV' + V)/LC}
begin
     fn := -(R*C*dy + y)/(L*C)
end;

procedure rkn(var x, y, y_prime, h: real);
var  A, B, C, D, k, beta, delta: real;
begin
     k := 0.5 * h;
     A := k * fn(x, y, y_prime);
     beta := k * (y_prime + 0.5*A);
     B := k * fn(x + k, y + beta, y_prime + A);
     C := k * fn(x + k, y + beta, y_prime + B);
     delta := h * ( y_prime + C);
     D := k * fn(x + h, y + delta, y_prime + 2*C);
     y := y + h * (y_prime + 0.33333333333 * (A + B + C));
     y_prime := y_prime + 0.33333333333 * (A + 2*(B + C) + D)
end;

function true(alphasq, alpha, Vzero, Ro2L, t: real): real;
begin
     if alphasq < 0 then
        true := Vzero*exp(-Ro2L*t)*((1+Ro2L/alpha)*exp(alpha*t)
             + (1-Ro2L/alpha)*exp(-alpha*t))/2
     else if alphasq = 0 then
        true := Vzero*exp(-Ro2L*t) * (1 + Ro2L*t)
     else
        true := Vzero*exp(-Ro2L*t) * cos(alpha*t - arctan(Ro2L/alpha))
             / (alpha*sqrt(C*L))
end;

begin
     write('R = '); readln(R);
     write('L = '); readln(L);
     write('C = '); readln(C);
     write('V0 = '); readln(V0);
     y := V0;   y_prime := 0;
     h := 0.0001;
     alphasq := 1/(C*L) - R*R/(4*L*L);
     alpha := sqrt(abs(alphasq));
     Ro2L := R / (2*L);
     writeln('Time          Vc            True V              Vc''');
     for n := 0 to 500 do begin
        t := n * h;
        trueV := true(alphasq, alpha, V0, Ro2L, t);
        if n mod 10 = 0 then
           writeln(t:5:4,'   ',y:13:8, '   ', trueV:11:8, y_prime:15:5);
        rkn(t, y, y_prime, h);
        end
end.

