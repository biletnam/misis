program linsystem;
{solves a system of linear equations using Gaussian elimination
with partial pivoting}
const  M0 = 20;    R0 = 40;

type   mat = array[1..M0, 1..R0] of real;
       systmat = array[1..M0, 1..M0] of real;

var    I, J, P, Q, R, K, L, M, N: integer;
                               A: mat;
                               B: systmat;
                         X, Y, Z: real;
                         C, SING: boolean;
                              CH: char;

procedure print(K: integer);
begin
       if K = 0 then writeln('Input matrix: ')
       else writeln('Output: ');
       for I := 1 to M do begin
           for J := M*K + 1 to R do begin
               if K = 0 then write(A[I, J] : 10 : 3)
               else write(A[I, J] : 15 : 6);
               if J = M then write('  ')
               end;
           writeln
           end;
       writeln
end;

procedure lda;
begin
   if (CH <> '@') and (M <= K) then begin
       writeln('Retain the first ', M, ' rows and columns of the');
       write('previous system matrix as new system matrix?');
       read(kbd,CH); writeln
       end
   else CH := 'N';
   if CH in ['N', 'n'] then begin
       writeln('First enter the system matrix.');
       for I := 1 to M do begin
           writeln('Row ', I, ':');
           for J := 1 to M do begin
               write('A[', I, ', ', J, '] = ');
               readln(A[I, J])
               end
           end
       end
       else for I := 1 to M do
           for J := 1 to M do A[I, J] := B[I, J];
       write('Now enter input: ');
       if N = 1 then writeln('Vector.') else writeln('Matrix.');
       if N = M then begin
           write('Do you want the inverse of the system matrix?');
           read(kbd,CH); writeln;
           end
       else CH := 'N';
       if CH in ['Y', 'y'] then begin
           for I := 1 to M do
               for J := M + 1 to R do A[I, J] := 0;
           for I := 1 to M do A[I, M + 1] := 1;
           writeln('Identity entered.');
           end
       else begin
           for I := 1 to M do begin
               writeln('Row ', I, ' of input: ');
               for J :=  M + 1 to R do begin
                   write('A[', I, ', ', J, '] = ');
                   readln(A[I, J])
                   end
               end
           end
end;

procedure correct;
begin
   while CH in ['Y', 'y'] do begin
       writeln('Enter row index I and column index J');
       write('of entry you wish to change:  ');
       readln(I, J);
       write('Enter new A[', I, ', ', J, ']:  ');
       readln(A[I, J]);
       write('Further corrections?  '); readln(CH)
       end;
   print(0)
end;

function pivot(P: integer) : integer;
{locates the largest | A[I,P] |, where P <= I <= M }
begin
   Q := P; X := abs(A[I, P]);
   for I := 1 to M do begin
       Y := abs(A[I, P]);
       if Y > X then begin Q := I; X := Y end
       end;
   if X = 0 then SING := true;
   pivot := Q
end;

procedure tr(P, Q: integer);
{ transposes two rows. Assumed: 1 >= P > Q >= M and all
  A[I, J] = 0 for I >= P and 1 <= J < P                 }
begin
   for J := P to R do begin
       X := A[P, J];   A[P, J] := A[Q, J]; A[Q, J] := X
       end
end;

procedure norm(P: integer);
{ Divides the Pth row by A[P, P]}
begin
   X := A[P, P];   A[P, P] := 1;
   for J := P + 1 to R do A[P, J] := A[P, J] / X
end;

procedure sub(P, Q: integer; X: real);
begin
   for J := P + 1 to R do
       A[Q, J] := A[Q, J] - X * A[P, J]
end;

procedure triang;
begin
   P := 1;
   repeat
       K := pivot(P);
       if not sing then begin
           if K > P then tr(P, K);
           for Q := P + 1 to M do
               sub(P, Q, A[Q, P]/A[P, P])
           end;
       P := P + 1
   until (P > M) or sing
end;

procedure backsub;
begin
   for P := 1 to M do norm(P);
   for P := M downto 2 do
       for Q := P - 1 downto 1 do sub(P, Q, A[Q, P])
end;

(******************** MAIN ************************)
begin
   CH := '@';
   repeat
       write('Enter the number of rows, at most ', M0, ':  ');
       readln(M);
       writeln('Enter number of columns on the');
       write('right-hand side, at most ', R0 div 2, ':  ');
       readln(N); R := M + N;
       SING := false;  C := false;
       lda;    print(0);
       write('Any corrections?  '); read(kbd,CH); writeln;
       if CH in ['Y', 'y'] then correct;
       for I := 1 to M do
           for J := 1 to M do B[I, J] := A[I, J];
       triang;
       if SING then writeln('Singular system.')
       else begin
           backsub;
           print(1)
           end;
       write('C(ontinue or Q(uit ?  '); read(kbd,CH); writeln;
       K := M
   until CH in ['Q', 'q']
end.

