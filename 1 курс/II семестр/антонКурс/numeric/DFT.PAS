program dft;
{Discrete Fourier Transform. }
const maxsize = 256;
      tau = 0.0001172;
      peak = 1;
var sn, cn: array [0..630] of real;
    num: integer;
    s, c, t, el, b, yy: real;
    factor: real;
    fmin, fmax, df, w: integer;
    y: array [1..maxsize] of real;
    om: real;
    arg: real;
    ctr: integer;
    freq: integer;
    temp: real;
    data: text;
begin
     assign(data, 'B:FFT.DAT'); reset(data);   (** <------NOTE THIS!! **)
     for ctr := 1 to 630 do begin
         sn[ctr] := sin(ctr/100);
         cn[ctr] := cos(ctr/100)
     end;
     b := 2 * pi;
     write('fmin, fmax, df: ');
     readln(fmin, fmax, df);
     factor := 0.5 * maxsize * peak;
     repeat
           freq := fmin - df;
           num := 0;
           repeat
                 num := num + 1;
                 readln(data, y[num]);
           until num = maxsize;
           repeat
                 freq := freq + df;
                 om := b * freq;
                 s := 0;
                 c := 0;
                 t := 0;
                 arg := 0;
                 el := om * tau;
                 for ctr := 1 to num do begin
                     arg := arg + el;
                     if arg > b then
                        arg := arg - b;
                     w := trunc(100 * arg);
                     yy := y[ctr];
                     s := s + yy * sn[w];
                     c := c + yy * cn[w]
                 end;
                 temp := sqr(s) + sqr(c);
                 temp := sqrt(temp) / factor;
                 writeln(freq, temp:10:5)
          until freq > fmax - df;
          writeln
    until eof
end.

