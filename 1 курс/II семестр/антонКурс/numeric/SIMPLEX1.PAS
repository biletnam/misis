program simple;
type ten = array [1..10] of integer;
     TwoD = array [1..11,1..36] of real;
     OneD = array [1..35] of real;

var
    b, c, x: OneD;
    a: TwoD;
    n, m, i, j: integer;
    print1, print2: boolean;
    opt: real;

{ Simplex algorithm for the linear programming problem with m
constraints and n real or slack variables, where the constraints are all
off the = or <= kind. b[1...m] are the non-negative constants of the
right hand sides. One new variable x[n+1] is added to the i th constraint
(either slack for <= or artificial for =). c[1..n+m] are the cost
coefficients associated with the variables x[1..n+m].}

procedure output(m, ncols: integer; tableau: TwoD; basis: ten;
                    var x: OneD);
var i, j, mp1: integer;
    objf: real;
begin
     mp1 := m + 1;
     for i := 1 to mp1 do begin
         writeln;
         for j := 1 to ncols do write(tableau[i,j]:10,'  ')
         end;
     objf := tableau[mp1,ncols];
     writeln;
     writeln('Objective function value = ', objf:10);
     writeln;
     for j := 1 to ncols-1 do x[j] := 0.0;
     for i := 1 to m do x[basis[i]] := tableau[i,ncols];
     writeln('Solutions, x[1] to x[',ncols-1,']');
     for j := 1 to ncols-1 do write(x[j]:10,'  ');
     writeln;  writeln;
     {for i := 1 to 10000 do} repeat until keypressed ;  {pause}
end;

function simplex(n,m: integer; a: TwoD; b, c: OneD; var x: OneD;
                               print1,print2: boolean): real;
var i, j, k, rowsub, iter, ncols, mp1, ncolsm1: integer;
    basis: ten;
    tableau: TwoD;
    zjcj, theta, theta1, delete, pivot, objf: real;

label    bypass, OK, out, exit, return;

begin
    ncols := n + m + 1;
    ncolsm1 := ncols -1;
    mp1 := m + 1;
    if (ncols*mp1 > 396) or (ncols > 36) then begin
       writeln('Problem too big. Quitting...');
       objf := 0.0;
       goto out;
       end;
    {Otherwise, fill in the simplex tableau}
       for i := 1 to mp1 do
           for j := n+1 to ncolsm1 do tableau[i,j] := 0.0;
       tableau[mp1,ncols] := 0.0;
       for i := 1 to m do begin
           tableau[mp1,ncols] := tableau[mp1,ncols] + b[i]*c[n+i];
           for j := 1 to n do tableau[i,j] := a[i,j];
           tableau[i,n+i] := 1.0;  tableau[i,ncols] := b[i];
           basis[i] := i + n
           end;
       for j := 1 to n do begin
           tableau[mp1,j] := -c[j];
           for i := 1 to m do tableau[mp1,j] := tableau[mp1,j]
                                + tableau[i,j]*c[n+i]
           end;
       if print1 then begin
           writeln;
           writeln('The initial tableau is:');
           output(m, ncols, tableau, basis, x)
           end;
       iter := 0;
return:
       zjcj := tableau[mp1,1];  k := 1;
       for j := 2 to ncolsm1 do
           if tableau[mp1,j] > zjcj then begin
              zjcj := tableau[mp1,j];
              k := j    end;
       if zjcj <= 0.0 then begin
exit:     for j := 1 to ncolsm1 do x[j] := 0.0;
          if print1 then begin
             writeln;
             writeln('The final tableau is:');
             output(m, ncols, tableau, basis, x);
             end;
          objf := tableau[mp1,ncols];
          goto out;
          end;
       for i := 1 to m do
           if tableau[i,k] > 0 then goto OK;
       writeln;
       writeln('Objective function unbounded. Computation ends.');
       goto exit;
OK:    theta := tableau[i,ncols]/tableau[i,k];
       rowsub := i;
       for j := i+1 to m do if tableau[j,k]>0 then begin
           theta1 := tableau[j,ncols]/tableau[j,k];
           if theta1 < theta then begin
              theta := theta1;  rowsub := j  end;
           end;
       basis[rowsub] := k;
{ Do Gauss-Jordan reduction using tableau[rowsub,k] as pivot}
       pivot := tableau[rowsub,k];
       for j := 1 to ncols do tableau[rowsub,j] := tableau[rowsub,j]/pivot;
       for i := 1 to mp1 do begin
           delete := tableau[i,k];
           if (delete = 0) or (i = rowsub) then goto bypass;
           for j := 1 to ncols do
               tableau[i,j] := tableau[i,j] - delete*tableau[rowsub,j];
bypass:    end;
       iter := iter + 1;
       if print2 then begin
          writeln;
          writeln('Tableau ', iter);
          output(m, ncols, tableau, basis, x);
          end;
       goto return;
out:
       simplex := objf
end;

begin
     n := 2;  m := 4;
     a[1,1] := 10;   a[1,2] := 20;  a[2,1] := 15;  a[2,2] := 5;
     a[3,1] := 6;   a[3,2] := 3;    a[4,1] :=10;   a[4,2] := 8;
     b[1] := 30000.;    b[2] := 30000.;  b[3] := 20000.;  b[4] := 40000.;
     c[1] := -0.02;  c[2] := -0.03;  c[3] := 0;  c[4] := 0;
                                     c[5] := 0;  c[6] := 0;
     print1 := true;  print2 := true;
     opt := simplex(n,m,a,b,c,x,print1,print2);
     for j := 1 to m+n do writeln('x[',j,'] = ',x[j]);
     writeln;
     writeln('Optimum function value = ', opt)
end.