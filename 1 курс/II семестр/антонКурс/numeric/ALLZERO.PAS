program allzeros;
{ Find all zeroes of a polynomial. Can be VERY slow without an 8087.
From 'Scientific Pascal', Flanders }
const  eps = 5.0e-7;   N0 = 100;
type   cmpl = record x, y: real end;
       poly = array [0..N0] of cmpl;
var    A, B, Z, W, ZERO: cmpl;
            J, K, N, N1: integer;
             F, G, COPY: poly;
               V, R, TH: real;
                   SAME: boolean;
                     CH: char;

{$I cmplxlib.pas}

procedure expand(var F: poly; N: integer; A: cmpl; var G: poly);
begin
   G[0] := F[N];
   for J := 1 to N do G[J] := ZERO;
   for K := 1 to N do
       for J := K downto 0 do begin
           prd(G[J], A, W);
           if J > 0 then sum(W, G[J-1], G[J])
           else sum(W, F[N -K], G[0])
           end
end;

procedure val(var F: poly; N: integer; A: cmpl; var B: cmpl);
begin
   B := F[N];
   for J := N-1 downto 0 do begin
       prd(B, A, B); sum(B, F[J], B)
       end
end;

procedure reduce(A: cmpl; var F: poly; var N: integer);
begin
   B := F[N];  F[N] := A;
   for J := N - 1 downto 1 do begin
       W := F[J];  F[J] := B;
       prd(A, B, B);   sum(W, B, B)
       end;
   F[0] := B;
   N := N - 1
end;

procedure minval(var F: poly; N: integer; R, TH: real;
                        var V: real; var A: cmpl);
var    U: cmpl;
  V1, V2: real;
begin
   U.X := R*cos(TH);   U.Y := R*sin(TH);
   val(F, N, A, B); V1 := absl(B);
   while R >= eps do begin
       repeat
           V2 := V1;
           sum(A, U, A); val(F, N, A, B);
           V1 := absl(B);
       until V1 >= V2*(1.0 - eps);
       dif(A, U, A); V1 := V2;
       R := R/3;  U.X := U.X/3;  U.Y := U.Y/3;
       end;
   V := V2;
end;

procedure azero(var F: poly; N: integer; var A: cmpl);
var DONE: boolean;
begin
   repeat
       expand(F, N, A, G);
       if absl(G[0]) < eps then DONE := true
       else DONE := false;
       if not DONE then begin
           K := 1;
           while 500*absl(G[K]) < absl(G[0]) do K := K + 1;
           quo(G[0], G[K], W);
           W.X := -W.X;  W.Y := -W.Y;
           polar(W, R, TH);
           TH := TH/K;  R := exp(ln(R)/K);
           minval(F, N, R, TH, V, A);
           if V < eps then DONE := true
           end
       until DONE
end;

procedure load(var N: integer; var F, COPY: poly);
begin
   N := 0;
   for K := 0 to N0 do F[K] := ZERO;
   writeln('The default value of each coefficient is zero.');
   repeat
       writeln('Enter the degree (at most ',
                          N0, ') of each term');
       writeln('and the real & imaginary parts of its coefficient: ');
       readln(K, F[K].X, F[K].Y);
       if (K > N) and ((F[K].X <> 0) or (F[K].Y <> 0)) then
           N := K;
       repeat
           write('More terms?  '); read(kbd,CH); writeln;
       until CH in ['Y','y','N','n']
   until CH in ['N','n'];
   COPY := F;
   for K := N downto 0 do
       writeln(K, '-th coefficient:  ', F[K].X :7:3, ' + ',
                  F[K].Y:7:3, ' * i');
   writeln;
end;

begin
   ZERO.X := 0;    ZERO.Y := 0;
   SAME := false;
   repeat
       if not SAME then load(N, F, COPY) else F := COPY;
       N1 := N;
       write('Enter the real and imaginary parts of first guess: ');
       readln(A.X, A.Y);
       repeat
           azero(F, N, A); reduce(A, F, N)
       until N = 0;
       N := N1;
       for J := 1 to N do
           writeln(J, '-th zero:  ', F[J].X:10:6,
                      ' + ', F[J].Y:10:6, ' * i');
       writeln;
       write('C)ontinue or Q)uit?  ');  read(kbd,CH); writeln;
       if CH in ['C','c'] then begin
           write('Same F(Z)?  ');  read(kbd,CH); writeln;
           SAME := (CH in ['Y','y'])
           end
       until CH in['Q','q']
end.
