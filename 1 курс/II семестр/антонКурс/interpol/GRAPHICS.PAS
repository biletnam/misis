Uses Crt, Graph, BPTrap; {By Igor Konev 2:5077/27.11}

type
  TFunction = function(x: Real): Real;

{$I DrawGraf.pas}

const
  MinX = -10;
  MaxX = 10;
  Step = 0.5;

function Standart(x: Real): Real; Far;
var
  n: Word;
  y: Real;
begin
  Standart := (x * x * x - 27 * x + 54) / (x * x * x)
end;

var
  grDriver, grMode, ErrCode: Integer;

begin
  grDriver := Detect;
  InitGraph(grDriver, grMode, '..\..\..\BGI');
  ErrCode := GraphResult;
  if ErrCode = grOk then begin
    SetColor(Yellow);
    SetLineStyle(SolidLn, 0, ThickWidth);
    DrawPlace(@Standart, MinX, MaxX, Step);
    DrawGraph(@Standart, MinX, MaxX, Step);
    while not KeyPressed do;
    CloseGraph; end
  else
    WriteLn('Graphics error: ', GraphErrorMsg(ErrCode));
end.