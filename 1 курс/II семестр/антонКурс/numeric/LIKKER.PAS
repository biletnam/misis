program likker;
{From Kaufman, 'A Fortran Coloring Book', prob. 17-4. An numerical 
 solution of Laplace's equation.}
var m: array [0..19, 1..10] of real;
    Tnew, dT, diff: real;
    i, j: integer;
begin
     for i := 0 to 8 do m[i,10] := 32.0;
     for i := 9 to 19 do m[i,10] := 32.0 + (i-8)*6.182;
     for j := 1 to 10 do begin
         m[19,j] := 100;
         m[0,j] := 32  end;
     for i := 1 to 18 do
         for j := 1 to 9 do
             m[i,j] := 90.0;
     for j := 1 to 3 do begin
         m[7,j] := 212;
         m[12,j] := 212 end;
     for i := 8 to 11 do m[i,3] := 212;
     for i := 19 downto 0 do
         for j := 1 to 10 do
             if (i in [8..11]) and (j in [1..2]) then write(' ':8)
             else write(m[i,j]:6:1,'  ');
     dT := 1.0;
     while dT > 0.5 do begin
         dT := -999.0;
         write('. ');
         for i := 1 to 18 do
             for j := 1 to 9 do
                 if not ((i in [7..12]) and (j in [1..3])) then begin
{points on}         if j = 1 then begin
{the equilibrium}      Tnew := (m[i-1,j] + m[i+1,j] + m[i,j+1])/3;
{line}                 diff := abs(Tnew - m[i,j]);
                       if diff > dT then dT := diff;
                       m[i,j] := Tnew
                    end
                    else begin
                      Tnew := 0.25*(m[i-1,j] + m[i+1,j] + m[i,j-1] + m[i,j+1]);
                      diff := abs(Tnew - m[i,j]);
                      if diff > dT then dT := diff;
                      m[i,j] := Tnew
                    end
                 end
      end;
     writeln;
     for i := 18 downto 1 do begin
         for j := 1 to 9 do
             if (i in [7..12]) and (j in [1..3]) then write(' ':8)
             else write(m[i,j]:6:1,'  ');
         writeln
         end;
end.
