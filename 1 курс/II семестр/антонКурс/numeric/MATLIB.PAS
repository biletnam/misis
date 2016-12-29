{ requires global type matrix: array[..,..] of real,}
{                      vector : array [..] of real}

function det(n: integer; a : matrix): real;
var ii,jj,kk,ll,ff,nxt: integer;
    piv, cn, big, temp, term : real;
begin
     ff := 1;
     for ii := 1 to n-1 do begin
         big := 0;
         for kk := ii to n do begin
             term := abs(a[kk, ii]);
             if term > big then begin
                big := term;
                ll := kk;
             end
         end;
         if ii - ll <> 0 then ff := -ff;
         for jj := 1 to n + 1 do begin
             temp := a[ii,jj];
             a[ii,jj] := a[ll,jj];
             a[ll,jj] := temp
         end;
         piv := a[ii,ii];
         nxt := ii + 1;
         for jj := nxt to n do begin
             cn := a[jj, ii] / piv;
             for kk := ii to n + 1 do
                 a[jj, kk] := a[jj, kk] - cn * a[ii, kk];
         end
     end;
     temp := 1;
     for ii := 1 to n do
         temp := temp * a[ii, ii];
     det := temp * ff;
end;

procedure minor(rows,columns,i,j: integer; a: matrix; var b: matrix);
{put the matrix a, except for i-th row and j-th column, into matrix b}
var c1,c2,c3,c4: integer;
begin
     c3 := 0;
     for c1 := 1 to rows do
         if c1 <> i then begin
            c4 := 0;
            c3 := c3 + 1;
            for c2 := 1 to columns do
                if c2 <> j then begin
                   c4 := c4 + 1;
                   b[c3,c4] := a[c1,c2]
                end
          end
end;

procedure mmprod(n,m,k: integer; m1,m2: matrix; var m3: matrix);
{multiply the n x m matrix m1 by the m x k matrix m2, result in m3}
var i,j,h: integer;
begin
     for i := 1 to n do
         for j := 1 to k do begin
             m3[i,j] := 0;
             for h := 1 to m do
                 m3[i,j] := m3[i,j] + m1[i,h]*m2[h,j]
         end
end;

procedure smprod(rows,columns: integer; s: real; var v: matrix);
var i,j: integer;
begin
     for i := 1 to rows do
         for j := 1 to columns do
             v[i,j] := s * v[i,j]
end;

procedure madd(rows,columns: integer; a,b: matrix; var c: matrix);
var i,j : integer;
begin
     for i := 1 to rows do
         for j := 1 to columns do
             c[i,j] := a[i,j] + b[i,j]
end;

procedure transpose(rows,columns: integer; var m: matrix);
var tmp : real;
    i,j: integer;
begin
     for i := 1 to rows do
         for j := 1 to columns do begin
             tmp := m[i,j];
             m[i,j] := m[j,i];
             m[j,i] := tmp
         end
end;

procedure readmat(rows,columns: integer; var m: matrix);
var i,j : integer;
begin
     for i := 1 to rows do
         for j := 1 to columns do begin
             write(i,',', j, ':  ');
             readln(m[i,j]) end
end;

procedure writemat(rows,columns: integer; m: matrix);
var i,j: integer;
begin
     for i := 1 to rows do begin
         for j := 1 to columns do
             write(m[i,j]:10, ' ');
         writeln
         end
end;

procedure checkmat(row, column: integer; var m: matrix);
var i, j: integer;
    ch: char;
begin
     write('Any corrections? '); readln(ch);
     while upcase(ch) = 'Y' do begin
           repeat
                 write('Row, column of error: '); readln(i, j);
           until (i in [1..row]) and (j in [1..column]);
           write('New value: '); readln(m[i, j]);
           ClrScr; writemat(row, column, m);
           write('Any more? '); readln(ch);
           end
end;

function dot(n: integer; v1,v2: vector): real;
var i : integer;
    sum  : real;
begin
     sum := 0;
     for i := 1 to n do
         sum := sum + v1[i]*v2[i];
     dot := sum
end;

function norm(n: integer; v: vector): real;
begin
     norm := sqrt(dot(n,v,v))
end;

procedure svprod(n: integer; s: real; var v: vector);
var i : integer;
begin
     for i := 1 to n do
         v[i] := v[i] * s
end;

procedure vadd(n: integer; v1,v2: vector; var v3: vector);
var i : integer;
begin
     for i := 1 to n do
         v3[i] := v1[i] + v2[i]
end;

procedure cross(v1,v2: vector; var v3: vector);
begin
     v3[1] := v1[2]*v2[3] - v1[3]*v2[2];
     v3[2] := v1[3]*v2[1] - v1[1]*v2[3];
     v3[3] := v1[1]*v2[2] - v1[2]*v2[1]
end;

procedure readvec(n: integer; var v: vector);
var i: integer;
begin
     for i := 1 to n do begin
         write(i, ':  ');
         readln(v[i]) end
end;

procedure writevec(n: integer; v: vector);
var i: integer;
begin
     for i := 1 to n do
         write(v[i]);
     writeln
end;

procedure mvprod(m,n: integer; a: matrix; b: vector; var c: vector);
var i,j: integer;
    sum : real;
begin
     for i := 1 to m do begin
         sum := 0;
         for j := 1 to n do
             sum := sum + a[i,j]*b[j];
         c[i] := sum
     end
end;

procedure getrow(rows,columns,target: integer; m: matrix; var x: vector);
var i : integer;
begin
     for i := 1 to columns do
         x[i] := m[target, i]
end;

procedure getcol(rows,columns,target: integer; m: matrix; var x: vector);
var i: integer;
begin
     for i := 1 to rows do
         x[i] := m[i, target]
end;

procedure changerow(rows,columns,target: integer; var m: matrix;
                                                  newrow: vector);
var i : integer;
begin
     for i := 1 to columns do
         m[target,i] := newrow[i]
end;

procedure changecol(rows,columns,target: integer; var m: matrix;
                                                  newcol: vector);
var i : integer;
begin
     for i := 1 to rows do
         m[i,target] := newcol[i]
end;

procedure swaprow(rows, columns, row1, row2: integer; var m: matrix);
var  i: integer;
     tmp:real;
begin
     for i := 1 to columns do begin
         tmp := m[row1, i];
         m[row1, i] := m[row2, i ];
         m[row2, i] := tmp
     end
end; { swaprow }

procedure swapcol(rows, columns, col1, col2: integer; var m: matrix);
var  i: integer;
     tmp: real;
begin
     for i := 1 to rows do begin
         tmp := m[i, col1];
         m[i, col1] := m[i, col2];
         m[i, col2] := tmp
     end
end; { swapcol }

procedure solve (n: integer; a: matrix; c: vector; var x: vector);
var  k: integer;
     d: real;
     procedure swap (n, k: integer; var a: matrix; var c: vector);
     var  e: real;
          j: integer;
     begin
          for j := 1 to n do begin
              e := c[j];
              c[j] := a[j, k];
              a[j,k] := e
          end
     end; { swap }
begin
     d := det(n, a);
     for k := 1 to n do begin
         swap(n,k,a,c);
         x[k] := det(n,a) / d;
         swap(n,k,a,c)
         end
end;

procedure invert(n: integer; a: matrix; var b: matrix);
var I, tmp: vector;
    j: integer;
begin
     if det(n,a) = 0 then writeln('Invert: singular matrix')
     else begin
          for j := 1 to n do begin
              I[j] := 1;
              solve(n,a,I,tmp);
              changecol(n,n,j,b,tmp);
              I[j] := 0
          end
     end
end;