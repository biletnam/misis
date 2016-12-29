program curvefit;

const     MAX = 100;  {maximum number of points}

type     data = array [1..MAX] of real;
      squares = array [1..10] of real;
         rect = array [1..10, 1..11] of real;

var      x, y: data;
            c: squares;
  i, n, order: integer;
         beta: real;
        fname: string[14];
       indata: text;

procedure ludcmq(var a: rect; n, ndim: byte);
var i, j, im1, jm1, k: byte;
                  sum: real;
begin
     for i := 1 to n do begin
         for j := 2 to n do begin
             sum := 0.0;
             if (j <= i) then begin
                jm1 := j - 1;
                for k := 1 to jm1 do
                    sum := sum + a[i, k] * a[k, j];
                a[i, j] := a[i, j] - sum
                end
             else begin
                im1 := i - 1;
                if (im1 <> 0) then
                   for k := 1 to im1 do
                       sum := sum + a[i, k] * a[k, j];
                if (abs(a[i, i]) > 1E-10) then
                   a[i, j] := (a[i, j] - sum)/a[i, i]
                else begin { break on error}
                   writeln('Quitting -- small value in row ', i);
                   halt;
                   end;
             end;
         end;
      end;
end;

procedure solnq(var b: squares; a: rect; n, ndim: byte);
var i, j, k, im1, nmjp1, nmjp2: byte;
    sum: real;
begin
     b[1] := b[1]/a[1, 1];
     for i := 2 to n do begin
         im1 := i - 1;
         sum := 0.0;
         for k := 1 to im1 do
             sum := sum + a[i, k] * b[k];
         b[i] := (b[i] - sum) / a[i, i]
         end;
     for j := 2 to n do begin
         {nmjp2 := n - j + 2;}
         nmjp1 := n - j + 1;
         sum := 0.0;
         for k := nmjp1+1 to n do
             sum := sum + a[nmjp1, k] * b[k];
         b[nmjp1] := b[nmjp1] - sum
         end
end;

procedure cfit(n: integer; x, y: data;
                  var order: integer; var c: squares; var beta: real);
var   xn, error: data;
             cc: squares;
              a: rect;
      i, j, ipt, ms, msp1, mf, mfp1, mfp2, jcoef: byte;
      oldBeta, twobeta, sum: real;

begin
     oldBeta := 9e20;   { --> infinity}
     ms := 1; mf := 8;
     mfp1 := mf + 1;  mfp2 := mf + 2;
     for i := 1 to n do
         xn[i] := 1.0;
     for i := 1 to mfp1 do begin
         a[i, 1] := 0.0;
         a[i, mfp2] := 0.0;
         for j := 1 to n do begin
             a[i, 1] := a[i, 1] + xn[j];
             a[i, mfp2] := a[i, mfp2] + y[j]*xn[j];
             xn[j] := xn[j] * x[j]
             end {j}
          end;   {i}
      for i := 2 to mfp1 do begin
          a[mfp1, i] := 0.0;
          for j := 1 to n do begin
              a[mfp1, i] := a[mfp1, i] + xn[j];
              xn[j] := xn[j] * x[j]
              end
          end;
      for j := 2 to mfp1 do
          for i := 1 to mf do
              a[i, j] := a[i+1, j-1];
      ludcmq(a, mfp1, 10);
      msp1 := ms + 1;
      i := 2;
      repeat
          for j := 1 to i do
              c[j] := a[j, mfp2];
          solnq(c, a, i, 10);

          beta := 0.0;
          for ipt := 1 to n do begin
              sum := 0.0;
              for jcoef := i downto 2 do
                  sum := (sum + c[jcoef]) * x[ipt];
              sum := sum + c[1];
              error[ipt] := y[ipt] - sum;
              beta := beta + sqr(error[ipt])
              end;
          beta := beta/(n - i);
          twobeta := sqrt(beta) * 2;
          if beta <= oldBeta then
             cc := c
          else begin  {past the best solution}
             c := cc; beta := oldBeta; order := i - 2;
             exit;
             end;
(****         for j := 2 to n-1 do
              if abs(error[j]) > twobeta then
                 writeln('Bad point: x,y[',j,']  ', x[j]:8:5,'  ', y[j]:8:5);
          writeln('Beta = ', beta);    **************)
          oldBeta := beta;
          i := i + 1;
      until i > 8;
end;

begin
     write('Name of data file:  '); readln(fname);
     assign(indata, fname); reset(indata);

     n := 0;
     while not (eof(indata) or (n > MAX)) do begin
           n := n + 1;
           readln(indata, x[n], y[n]);
           end;
     cfit(n, x, y, order, c, beta);
     for i :=  order+1 downto 1 do
         writeln(i-1,'th order coefficient = ', c[i]:10:5);
end.