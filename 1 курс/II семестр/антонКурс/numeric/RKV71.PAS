program testRKV7;
{This program uses the constants given in Byte, April 1986, and closely
follows the step size adjustment given in that article. The most important
change made is that the tolerance 'eps' is adjusted in the calling function
to allow for the current value of the function. Typically, the step size, 'h',
is adjusted only twice for each advance.}

var x0, x1, y0, y1, eps, h, minh: real;
    exact: real;  {For test with known function}
    j: integer;
    OK: boolean;

function f(x,y: real): real;
begin
    f := cos(x);
end;

function pwr(x,y: real): real;
begin
     pwr := exp(y * ln(x))
end;

procedure RKV7(x0, y0, x1, eps, hmax, minh: real;
                var y1, lasth: real; var OK: boolean; verbose: boolean);
const ZERO = 1E-20;  {close enough}
var err,x,y,h,q: real;
    k : array [1..13] of real;
    state: (stepping, done, htoosmall);
    shortrange: boolean;
begin
    h := hmax;
    x := x0;              y := y0;
    shortrange := false;  state := stepping;
    repeat
        k[1] := f(x,y);
        k[2] := f(x + h/4, y + h*k[1]/4);
        k[3] := f(x + h/12, y + h*(5*k[1] + k[2])/72);
        k[4] := f(x + h/8, y + h*(k[1] + 3*k[3])/32);
        k[5] := f(x + 0.4*h, y + h*(106*k[1] - 408*k[3] + 352*k[4])/125);
        k[6] := f(x + h/2, y + h*(k[1]/48 + 0.24242424242*k[4] + 0.236742424*k[5]));
        k[7] := f(x + 6*h/7, y + h*(-0.52603082*k[1] + 1.512097232*k[4]
                  - 2.42796562*k[5] + 2.299042066*k[6]));
        k[8] := f(x + h/7, y + h*(0.094387755*k[1] + 0.17272534*k[5]
                - 0.13333333333*k[6] + 9.077380952e-3*k[7]));
        k[9] := f(x + 0.66666666667*h, y + h*(0.673172643*k[1] - 1.846129728*k[4]
                + 2.628968254*k[5] - 1.637938468*k[6] + 0.138799725*k[7]
                + 0.709794238*k[8]));
        k[10] := f(x + 0.285714285*h, y + h*(-0.132355962*k[1] - 3.92886802e-2*k[4]
               - 1.0043716*k[5] + 0.846473969*k[6]
               - 2.61428571e-2*k[7] + 0.72727272727*k[8] - 8.58733104e-2*k[9]));
        k[11] := f(x + h, y + h*(1.675394737*k[1] - 3.833875598*k[4]
              + 5.687861344*k[5] - 5.978807018*k[6] + 0.371959429*k[7]
              - 0.246172248*k[8] + 1.208096591*k[9] + 2.115542763*k[10]));
        k[12] := f(x + h/3, y + h*(-0.132573976*k[1] + 0.14411487*k[4]
              - 1.130497268*k[5] + 0.6922202626*k[6] - 0.061460048*k[7]
              + 0.384313725*k[8] + k[9]/16 + 0.323473936*k[10]));
        k[13] := f(x +h, y + h*(1.290668203*k[1] - 3.195978215*k[4]
              + 5.137256057*k[5] - 5.164116743*k[6] + 0.4113569159*k[7]
              + 0.551788856*k[8] + 0.868493401*k[9] - 1.037298387*k[10]
              + 2.137829912*k[12]));
        err := abs(-k[1]/480 - 0.042666666*k[6] - 4.547348485e-3*k[7]
              + 0.018189393*k[8]
              + 0.017258522*k[9] - 0.125052083*k[10] - 0.042222222*k[11]
              + 0.138068181*k[12] + 0.043055555*k[13]);

       q := 0.891*pwr(eps/err, 0.1666);

       if err <= eps then begin
           x := x + h;
           y := y + h*(0.045138888*k[1] + 0.256*k[6] + 0.21675694444*k[7]
              + 0.194020202*k[8] + 0.120809659*k[9] + 0.1250520833*k[10]
              + 0.04222222222*k[11]);
           end;
       if q <= 0.1 then h := 0.1*h
       else if q >= 4 then h := 5*h
       else h := q*h;
       if h > hmax then h := hmax;
       if h < minh then state := htoosmall;
       if abs(x1 - x) <= ZERO then state := done
       else begin
          shortrange := (h > x1 - x);
          if shortrange then begin
             lasth := h;  h := x1 - x;
             end;
          end;
       if verbose then writeln('h = ',h:10,'  q = ',q:10,'   error = ', err:11);
       until state <> stepping;
       if not shortrange then lasth := h;
       OK := (state = done);
       if OK then y1 := y;
end;   {RKF45}

begin  (*************** calling program starts here **************)
    x0 := 0;       y0 := 0;   {initial conditions}
    eps := 5e-3;   h := 0.2;
    minh := 1e-6;
    for j := 1 to 20 do begin
        x1 := j/5;
        RKV7(x0, y0, x1, eps, h, minh, y1, h, OK, false);
        if OK then begin
            exact := sin(x1);
            writeln(x1:8:2,' ':8, y1:15,' ':5, exact:15,' ':7,
                             (exact-y1)/exact:15);
            x0 := x1;  y0 := y1;
            if abs(y1) > 1 then eps := abs(5e-3 * y1);
            end
        else begin
            writeln('Step size too small...Quitting.');
            exit;
            end;
        end;
end.
