program rksys;
{Apply Runge-Kutta method to a system of differential equations, or to a
second or higher order equation reduced to a first-order system}
const N = 2;
type group = array [1..N] of real;
var xend, x0: group;
    t: integer;
    i: integer;
    R, L, C, V0: real;
    Ro2L, alphasq, alpha, trueV: real;

procedure derivs(x: group; t: real; var f: group);
begin
      f[1] := x[N];
{     f[N] := 16*cos(8*t) - 64*x[1]}
      f[N] := -(R*x[N] + x[1]/C)/L
end;

procedure rksyst(var xend: group; x0: group; t: real);
var f: group;
    xwrk: array [1..4, 1..N] of real;
    h : real;
    i : integer;
begin
     h := 0.0001;
     derivs(x0, t, f);
     for i := 1 to N do begin
         xwrk[1, i] := h * f[i];
         xend[i] := x0[i] + xwrk[1, i]/2
         end;
     derivs(xend, t + h/2, f);
     for i := 1 to N do begin
         xwrk[2, i] := h * f[i];
         xend[i] := x0[i] + xwrk[2, i]/2
         end;
     derivs(xend, t + h/2, f);
     for i := 1 to N do begin
         xwrk[3, i] := h * f[i];
         xend[i] := x0[i] + xwrk[3, i]
         end;
     derivs(xend, t + h, f);
     for i := 1 to N do
         xwrk[4, i] := h * f[i];
     for i := 1 to N do
         xend[i] := x0[i] + (xwrk[1,i] + 2*(xwrk[2,i]
                    + xwrk[3,i]) + xwrk[4,i])/6;
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
     x0[1] := V0;   x0[N] := 0;
     t := 0;
     alphasq := 1/(C*L) - R*R/(4*L*L);
     alpha := sqrt(abs(alphasq));
     Ro2L := R / (2*L);
     writeln('Time          Vc            True V              Vc''');
     while t <= 200 do begin
        trueV := true(alphasq, alpha, V0, Ro2L, t/10000);
        if t mod 10 = 0 then
           writeln(t/10000:5:4,'   ',x0[1]:11:8, '   ', trueV:11:8,'   ' ,x0[2]:12:5);
        rksyst(xend, x0, t/10000);
        for i := 1 to N do
            x0[i] := xend[i];
        t := t + 1;
        end
end.
