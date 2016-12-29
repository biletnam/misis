program Pan_Reif_Inversion;
{ Invert real entry matrices. References are Byte, April 1986
  and Proc. 17th Annual ACM Symposium on Theory of Computing }

const DIM = 50;
type matrix = array [1..DIM,1..DIM] of real;
var a,b,e,x: matrix;
    h, i, j, n: integer;
    limit, error, t: real;
    hour, min, sec, frac: integer;
label done, more;

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

procedure fill(var a: matrix; n: integer);
var i,j: integer;
begin
     for i := 1 to n do
         for j := 1 to n do begin
             a[i,j] := random;
             if random < 0.5 then a[i,j] := -a[i,j];
             end;
end;

function EvalT(var a, e, x: matrix; n: integer ): real;
var i, j: integer;
    r0, s0, t1, t2: real;
begin
     for i := 1 to n do begin
         r0 := 0;  s0 := 0;
         for j := 1 to n do begin
             r0 := r0 + abs(a[i,j]);
             s0 := s0 + abs(a[j,i]);
             end;
         x[1,i] := r0;
         e[1,i] := s0;
         end;
     t1 := 0;  t2 := 0;
     for i := 1 to n do begin
         if x[1,i] > t1 then t1 := x[1,i];
         if e[1,i] > t2 then t2 := e[1,i];
         end;
     EvalT := 1/(t1*t2);
end;

procedure EvalB(var b: matrix; a: matrix; n: integer; t: real);
var i, j: integer;
begin
     for i := 1 to n do
         for j := 1 to n do
             b[i,j] := t * a[j,i];
end;

procedure EvalE(var e: matrix; a, b: matrix; n: integer);
var z: real;
    i,j,k: integer;
begin
     for i := 1 to n do begin
         for k := 1 to n do begin
             z := 0;
             for j := 1 to n do
                 z := z + b[i,j] * a[j,k];
             e[i,k] := -z;
             end;
         end;
     for i := 1 to n do e[i,i] := e[i,i] + 1;
end;

procedure quartic(var b, e, x: matrix; n: integer);
var i, j, k: integer;
    w: real;
begin
     for i := 1 to n do
         x[1,i] := 1 + (1 + (1 + (1 + e[i,i])*e[i,i])*e[i,i])*e[i,i];
     for i := 1 to n do begin
         for j := 1 to n do
             e[i,j] := x[1,i] * e[i,j];
         e[i,i] := 1 + e[i,i];
         end;
     for i := 1 to n do begin
         for k := 1 to n do begin
             w := 0;
             for j := 1 to n do
                 w := w + e[i,j] * b[j,k];
             x[i,k] := w;
             end;
         end;
     for i := 1 to n do
         for j := 1 to n do
             b[i,j] := x[i,j];
end;

procedure printmat(a: matrix; n: integer);
var i, j: integer;
begin
     for i := 1 to n do begin
         for j := 1 to n do
             write(a[i,j]:9:6,' ');
         writeln;
         end;
end;

procedure multmat(a,b:matrix; var c: matrix; n: integer);
var i, j, k: integer;
begin
     for i := 1 to n do
         for j := 1 to n do begin
             c[i,j] := 0;
             for k := 1 to n do
                 c[i,j] := c[i,j] + a[i,k] * b[k,j];
             end;
end;

begin
     n := 8; limit := 1e-7;
     h := 0;
     fill(a, n);
     gettime(hour,min,sec,frac);
     t := EvalT(a,e,x,n);
     EvalB(b,a,n,t);
     while (h < 50) do begin
           EvalE(e,a,b,n);
           error := 0;
           for i := 1 to n do
               for j := 1 to n do begin
                   if error < abs(e[i,j]) then error := abs(e[i,j]);
                   if error > limit then goto more;
                   end;
           goto done;
more:      quartic(b,e,x,n);
           h := h + 1;
           writeln('Iteration ', h,'  Max. error = ', error);
           end;
done: if h = 50 then writeln('Quit on iteration limit.');
      writeln('Initial matrix (A):');
      printmat(a,n);
      writeln;
      writeln('Calculated inverse (B):');
      printmat(b,n);
      writeln;
      multmat(a,b,x,n);
      writeln('(A) x (B) = ');
      printmat(x,n);
      writeln('Starting time: ',hour,':',min,':',sec,'.',frac);
      gettime(hour,min,sec,frac);
      writeln('Finishing time: ',hour,':',min,':',sec,'.',frac);
end.
