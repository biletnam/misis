procedure DrawPlace(f: Pointer; MinX, MaxX, Step: Real); {By Igor Konev 2:5077/27.11}
type
  TFunction = function(x: Real): Real;
var
  x, y, Inf, Sup: Real;
  xl, yt, xr, yb, i: Integer;
  OldColor: Word;
  OldLineStyle: LineSettingsType;
  OldTextStyle: TextSettingsType;
  s: String;
  Define: Boolean;
begin
  if Step = 0 then Exit;
  OldColor := GetColor;
  GetLineSettings(OldLineStyle);
  GetTextSettings(OldTextStyle);
  ClearDevice;
  SetColor(White);
  x := MinX; Define := False;
  while x < MaxX do begin
    if not Trap then begin
      y := TFunction(f)(x);
      if not Define then begin
        Inf := y; Sup := y; Define := True; end
      else begin
        if Inf > y then Inf := y;
        if Sup < y then Sup := y;
      end;
    end;
    UnTrap;
    x := x + Step;
  end;
  if not Define then begin Inf := MinX; Sup := MaxX; end;
  xl := 60; yt := 20; xr := GetMaxX - 30; yb := GetMaxY - 20;
  SetLineStyle(SolidLn, 0, ThickWidth);
  SetFillStyle(1, Blue);
  Bar(xl, yt, xr, yb);
  Rectangle(xl, yt, xr, yb);
  SetLineStyle(DottedLn, 0, NormWidth);
  SetTextJustify(LeftText, CenterText);
  SetTextStyle(DefaultFont, HorizDir, 1);
  for i := 0 to 10 do begin
    Line(xl + Round(i * (xr - xl) / 10), yt, xl + Round(i * (xr - xl) / 10), yb);
    Str(MinX + i * (MaxX - MinX) / 10 : 7 : 2, s);
    OutTextXY(xl div 2 + Round(i * (xr - xl) / 10), yb + 10, s);
  end;
  for i := 0 to 10 do begin
    Line(xl, yt + Round(i * (yb - yt) / 10), xr, yt + Round(i * (yb - yt) / 10));
    Str(Inf + (10 - i) * (Sup - Inf) / 10 : 7 : 2, s);
    OutTextXY(0, yt + Round(i * (yb - yt) / 10), s);
  end;
  SetColor(OldColor);
  SetLineStyle(OldLineStyle.LineStyle, OldLineStyle.Pattern, OldLineStyle.Thickness);
  SetTextJustify(OldTextStyle.Horiz, OldTextStyle.Vert);
  SetTextStyle(OldTextStyle.Font, OldTextStyle.Direction, OldTextStyle.CharSize);
end;

procedure DrawGraph(f: Pointer; MinX, MaxX, Step: Real);
type
  TFunction = function(x: Real): Real;
var
  x, y, Inf, Sup: Real;
  xl, yt, xr, yb, i: Integer;
  Error, Define: Boolean;
begin
  if Step = 0 then Exit;
  x := MinX; Define := False;
  while x < MaxX do begin
    if not Trap then begin
      y := TFunction(f)(x);
      if not Define then begin
        Inf := y; Sup := y; Define := True; end
      else begin
        if Inf > y then Inf := y;
        if Sup < y then Sup := y;
      end;
    end;
    UnTrap;
    x := x + Step;
  end;
  if not Define then Exit;
  xl := 60; yt := 20; xr := GetMaxX - 30; yb := GetMaxY - 20;
  x := MinX;
  Error := True;
  while x < MaxX do begin
    if not Trap then begin
      y := TFunction(f)(x);
      if Error then begin
        MoveTo(xl + Round((x - MinX) * (xr - xl) / (MaxX - MinX)),
          GetMaxY - Round((y - Inf) * (yb - yt) / (Sup - Inf)) - yt);
        Error := False; end
      else
        LineTo(xl + Round((x - MinX) * (xr - xl) / (MaxX - MinX)),
          GetMaxY - Round((y - Inf) * (yb - yt) / (Sup - Inf)) - yt); end
    else
      Error := True;
    UnTrap;
    x := x + Step;
  end;
end;
