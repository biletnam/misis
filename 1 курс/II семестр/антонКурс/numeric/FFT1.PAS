program fft;  {Fast Fourier Transform}
{ This program is a modification of one found in Flanders, 'Scientific Pascal'
  This version has these changes:-
       a) A self-contained FFT and inverse routine
       b) Sacrificed speed for space - sines and cosines are
          calculated on each pass rather than stored in a
          'data' array. Even so, the maximum number of data
          points (using 8087 format) is 2048, using static storage
          allocation.
       c) Number of data points and a flag for inverse are expected
          at the head of the data file
}

type cmplx = record x, y: real end;
     data  = array [0..1024] of cmplx;

var                  a: data;
             n, n_1, i: integer;
             inv, sgn : integer;    {inv <> 0 --> inverse, sgn := -1 }
            inf, outf : text;       {text partly because it is more natural}
                 dataf: string[24]; {for the size and inverse flag to be   }
                                    {integers, but mainly so the file can be}
                                    {inspected with the editor.}
{$I cmplxlib.pas}
                   {LOAD COMPLEX MATH ROUTINES
                    prd(), dif() and sum() return the product, difference
                    and sum of their first two complex arguments in the third}


procedure fft(var a: data; size, sgn: integer);
{    a: complex array of data;
  size: number of elements;
   sgn: 1 for forward transform, -1 for inverse
   transformed data is returned in a               }

function log2(n: integer): integer;
var j: integer;
begin
     j := 0;
     while not odd(n) do begin
           n := n shr 1;  j := j + 1;  end;
     if n <> 1 then begin
          writeln('Error: sample must be an integer power of 2.');
          halt;
          end;
     log2 := j;
end;

(*********** RE-ORDER THE DATA ***********************)
procedure reorder(var a: data; n, sign: integer);
var i, j, k, m: integer;
             t: cmplx;
begin
   for i := 1 to n-1 do begin
       m := i;   k := 0;
       for j := 1 to log2(n) do begin
           k := 2*k + m mod 2;
           m := m div 2;
           end;
       if i < k then begin
          t := a[i];  a[i] := a[k];  a[k] := t;   end
       end;  {for i}
end;

(********** PERFORM THE TRANSFORM *****************)
procedure transform(var a: data; n, sgn: integer);
var     lvl, tl, tl1,                { tl = 2 ^ lvl }
            expon, p,                { tl1 = 2 ^ (lvl - 1) }
             i, j, k: integer;       { p = 2 ^ (r - lvl) }
               s , z: cmplx;         { expon = j * p }
                  sc: real;
begin
  sc := 2 * pi / n;
  tl := 2;   tl1 := 1;
  for lvl := 1 to log2(n) do begin
      p := n div tl;   expon := 0;
      for j := 0 to tl1 - 1 do begin
          i := j;
          s.x := cos(expon * sc);
          s.y := sin(expon * sc) * sgn;
          while i < n do begin
             k := i + tl1;
             if j = 0 then z := a[k]
             else prd(a[k], s, z);
             dif(a[i], z, a[k]);
             sum(a[i], z, a[i]);
             i := i + tl;
             end;  {while}
          expon := expon + p;
          end;  {for j}
      tl := 2 * tl;   tl1 := 2 * tl1;
      end;   {for lvl}
end;

begin  (***** MAIN BODY OF FFT() *********)
  reorder(a, n, sgn);
  transform(a, n, sgn);
  if sgn = -1 then   {divide by number of points for inverse}
     for i := 0 to n_1 do
         with a[i] do begin
            x := x / n;
            y := y / n;
            end;
end; {FFT}

begin   (********** CALLING ROUTINE **************)
  write('Name of data file: ');  readln(dataf);
  assign(inf, dataf);            reset(inf);
  write('Name of output file: ');  readln(dataf);
  assign(outf, dataf);             rewrite(outf);

  readln(inf, n, inv); {number of points, inverse if inv <> 0}
  if inv <> 0 then sgn := -1 else sgn := 1;
  n_1 := n - 1;

  for i := 0 to n_1 do
      with a[i] do read(inf, x, y);

  fft(a, n, sgn);

  if inv <> 0 then inv := 0 else inv := 1;  {assume output file will be }
  writeln(outf, n,'  ', inv);               {re-transformed}
  for i := 0 to n_1 do
      with a[i] do begin
        write('X[', i:4, '] = ');
        writeln(x:14:9, '  ', y:14:9,'i');
        writeln(outf, x:14:9,'   ', y:14:9);  {output is typically accurate}
        end;                                  {to about 10^-13. Truncate so}
  close(inf);  close(outf);                   {error does not accumulate.}
end.



