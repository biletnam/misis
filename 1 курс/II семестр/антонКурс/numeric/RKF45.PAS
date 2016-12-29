program testRKF45;
var x0, x1, y0, y1, eps, h, minh: real;
    exact: real;  {used to check accuracy when function is known}
    j: integer;
    OK: boolean;
    out: text;
var hour, min, sec, frac: integer;

function f(x,y: real): real;
begin
    f := exp(2*x) + y;
end;


procedure RKF45(x0, y0, x1, eps, firsth, minh: real;
                var y1, lasth: real; var OK: boolean; verbose: boolean);
const ZERO = 1E-20;  {close enough}
var k1,k2,k3,k4,k5,k6,err,x,y,h,eps32: real;
    state: (stepping, done, htoosmall);
    shortrange: boolean;
begin
    eps32 := eps / 32;    h := firsth;
    x := x0;              y := y0;
    shortrange := false;  state := stepping;
    repeat
        k1 := f(x,y);
        k2 := f(x + h/4, y + h*k1/4);
        k3 := f(x + 3*h/8, y + h*(3*k1 + 9*k2)/32);
        k4 := f(x + 12*h/13, y + h*(1932*k1 - 7200*k2 + 7296*k3)/2197);
        k5 := f(x + h, y + h*(439*k1/216 - 8*k2 + 3680*k3/513
                                           - 845*k4/4104));
        k6 := f(x + h/2, y + h*(-8*k1/27 + 2*k2 - 3544*k3/2565
                                           + 1859*k4/4104 - 11*k5/40));
        err := h * abs(k1/360 - 128*k3/4275 - 2197*k4/75240.
                                           + k5/50 + 2*k6/55);
       if err > h * eps then begin
           h := h/2;
           if h < minh then state := htoosmall;
           end
       else begin
           x := x + h;
           y := y + h*(25*k1/216 + 1408*k3/2565 + 2197*k4/4104 - k5/5);
           if abs(x1 - x) <= ZERO then state := done
           else begin
               if err <= h*eps32 then h := h * 2;
               shortrange := (h > x1 - x);
               if shortrange then begin
                   lasth := h;  h := x1 - x;
                   end;
               end;
           end;
           if verbose then writeln('h = ',h:10:8,'   error = ', err:11:9);
       until state <> stepping;
       if not shortrange then lasth := h;
       OK := (state = done);
       if OK then y1 := y;
end;   {RKF45}



procedure gettime(var hour,min,sec,frac: integer);
type regpack = record
                  AX, BX, CX, DX, BP, SI, DI, DS, ES, Flags: integer;
               end;
var regs: regpack;
begin
     with regs do begin
          AX := $2C00;
          MsDos(regs);
          Hour := hi(CX);
          Min := lo(CX);
          Sec := hi(DX);
          Frac := lo(DX);
     end;
end;

begin  (*************** calling program starts here **************)
{    assign(out, 'RKF1.DAT'); rewrite(out);}
    x0 := 0;       y0 := 1;   {initial conditions}
    eps := 1e-7;   h := 0.01;
    minh := 1e-4;
    gettime(hour,min,sec,frac);
    writeln(hour,':',min,':',sec,':',frac);

    for j := 1 to 20 do begin
        x1 := j/5;
        RKF45(x0, y0, x1, eps, h, minh, y1, h, OK, false);
        if OK then begin
            exact := exp(2*x1);
            writeln(x1:6:2,' ':10, y1:15,' ':7, exact:15,' ':4,
                    (exact - y1)/exact:15);
            x0 := x1;  y0 := y1;  eps := 1e-7 * y1;
            {make eps a relative accuracy}
            end
        else begin
            writeln('Step size too small...Quitting.');
            exit;
            end;
        end;

    gettime(hour,min,sec,frac);
    writeln(hour,':',min,':',sec,':',frac);

{    close(out);     }
end.
