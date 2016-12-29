program testPwr;
{recursively calculates integer powers of real numbers.}
var j: integer;

function pwr(x: real; i: integer): real;
begin
     if i < 0 then begin
        x := 1/x;  i := -i;
        end;
     if i = 0 then pwr := 1
     else if odd(i) then pwr := x * pwr(x,i-1)
          else pwr := sqr(pwr(x, i shr 1));
end;

begin
     for j := -8 to 22 do writeln(pwr(-2.0, j));
end.
