program Interpolation; {By Igor Konev 2:5077/27.11}

Uses Crt, Graph, BPTrap;

type
  PData = ^TData;
  TData = record
    x, y: Real;
    Next: PData;
  end;

{$I DrawGraf.pas}

var
  Data: PData;

function Lagrange(x: Real): Real; Far;
var
  i, j: Word; m, s: Real; p, q: PData;
begin
  p := Data; s := 0; i := 0;
  while p <> nil do begin
    Inc(i); q := Data; m := p^.y; j := 0;
    while q <> nil do  begin
      Inc(j);
      if j <> i then m := m * (x - q^.x) / (p^.x - q^.x);
      q := q^.Next;
    end;
    s := s + m; p := p^.Next
  end;
  Lagrange := s;
end;

function Newton(x: Real): Real; Far;
var
  i, j, k: Word; m, n, s: Real; p, q, r: PData;
begin
  p := Data; i := 0; s := 0;
  while p <> nil do begin
    Inc(i); q := Data; n := 0;
    for j := 1 to i do begin
      r := Data; m := q^.y;
      for k := 1 to i do begin
        if k <> j then m := m / (q^.x - r^.x);
        r := r^.Next;
      end;
      n := n + m; q := q^.Next;
    end;
    q := Data;
    for j := 1 to i - 1 do begin
      n := n * (x - q^.x); q := q^.Next;
    end;
    s := s + n; p := p^.Next;
  end;
  Newton := s;
end;

function Standart(x: Real): Real; Far;
begin
  Standart := Sin(x);
end;

function ReadData(var f: Text; var Data: PData): Word;
var
  p, q: PData; i: Word;
begin
  {$I-} Reset(f); {$I+}
  if IOResult <> 0 then begin ReadData := 0; Exit; end;
  New(p); q := p; i := 0;
  repeat
    q^.Next := nil;
    {$I-} ReadLn(f, q^.x, q^.y); {$I+}
    if IOResult <> 0 then begin
      while p <> nil do begin q := p^.Next; Dispose(p); p := q; end;
      ReadData := 0; Exit;
    end;
    Inc(i);
    if not Eof(f) then begin New(q^.Next); q := q^.Next; end;
  until Eof(f);
  Data := p; ReadData := i;
end;

function GetMin(Data: PData): Real;
var
  p: PData; n: Real;
begin
  p := Data; n := p^.x;
  while p <> nil do begin
    if n > p^.x then n := p^.x;
    p := p^.Next;
  end;
  GetMin := n;
end;

function GetMax(Data: PData): Real;
var
  p: PData; n: Real;
begin
  p := Data; n := p^.x;
  while p <> nil do begin
    if n < p^.x then n := p^.x;
    p := p^.Next;
  end;
  GetMax := n;
end;

var
  grDriver, grMode, ErrCode: Integer;
  f: Text;

begin
  WriteLn('Interpolation with Lagrange and Newton methods. Written by Igor Konev.');

  if ParamCount <> 1 then begin
    WriteLn;
    WriteLn('       Usage: interpol <filename>');
    WriteLn('       Example: interpol interpol.dat');
    WriteLn;
    Halt(1);
  end;

  Assign(f, ParamStr(1));

  if ReadData(f, Data) = 0 then begin
    WriteLn('File read error!');
    Halt(2);
  end;

  grDriver := Detect;
  InitGraph(grDriver, grMode, '..\..\..\BGI');
  ErrCode := GraphResult;
  if ErrCode <> grOk then begin
    WriteLn('Graphics error: ', GraphErrorMsg(ErrCode));
    Halt(3);
  end;

  DrawPlace(@Standart, GetMin(Data), GetMax(Data), 0.1);

  SetColor(Yellow);
  SetLineStyle(DottedLn, 0, ThickWidth);
  DrawGraph(@Lagrange, GetMin(Data), GetMax(Data), 0.1);

  SetColor(Yellow);
  SetLineStyle(DottedLn, 0, ThickWidth);
  DrawGraph(@Newton, GetMin(Data), GetMax(Data), 0.1);

  SetColor(Yellow);
  SetLineStyle(SolidLn, 0, ThickWidth);
  DrawGraph(@Standart, GetMin(Data), GetMax(Data), 0.1);

  while not KeyPressed do;

  CloseGraph;
  Dispose(Data);
end.