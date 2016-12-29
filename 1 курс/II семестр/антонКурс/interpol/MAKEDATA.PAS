program Make; {By Igor Konev 2:5077/27.11}
const
  MinX = -pi;  MaxX = pi;  Step = 1;
var
  x: Real;
begin
  x := MinX;
  while x < MaxX do begin
    WriteLn(x, ' ', Sin(x));
    x := x + Step;
  end;
end.
