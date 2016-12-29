unit weigunit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls,nshape;

type
  TWeigf = class(TForm)
    ScrollBox1: TScrollBox;
    OKButton: TButton;
    CancelButton: TButton;
    STPorog: TStaticText;
    StPorogValue: TStaticText;
    SBar: TScrollBar;
    STQuant: TStaticText;
    constructor Create(AOwner:TComponent;var otv:Tiar;sz:integer;neu:TslShape);reintroduce;
    procedure ScrollBarChange(Sender: TObject);
    procedure SBarChange(Sender: TObject);
    procedure OKButtonClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Weigf: TWeigf;
  siz:integer;
  t:double;                //порог срабатывания
  w:Tdar;                  //веса
  otvet:Tiar;
  sb:array[1..AR]of TScrollBar;
  st:array[1..AR]of TStaticText;
  neur:TslShape;

implementation

{$R *.DFM}
  constructor TWeigf.Create;
  var
    tsh:TslShape;
    i:integer;
    stn:TstaticText;
  begin
    inherited Create(AOwner);
    otvet:=otv;
    siz:=sz;
    neur:=neu;
    t:=neu.T;
    STPorog.Caption:='T('+neu.Caption+')';
    STPorogValue.Caption:=FloatToStr(t);
    SBar.Position:=Round(t*100);

    STQuant.Caption:='Connected with '+IntToStr(sz)+' objects.';
    for i:=1 to sz do begin
      scon.GetEl(otv[i],tsh,w[i]);

      sb[i]:=TScrollBar.Create(self);
      st[i]:=TStaticText.Create(self);
      stn:=TStaticText.Create(self);

      stn.Top:=20+(i-1)*30;
      stn.Left:=30;
      stn.Caption:=tsh.Caption;
      stn.Width:=70;
      stn.Parent:=self.ScrollBox1;

      st[i].Top:=20+(i-1)*30;
      st[i].Left:=110;
      st[i].Caption:=FloatToStr(w[i]);
      st[i].Width:=70;
      st[i].Parent:=self.ScrollBox1;

      sb[i].Top:=20+(i-1)*30;
      sb[i].Left:=190;
      sb[i].Width:=260;
      sb[i].Min:=-100;
      sb[i].OnChange:=ScrollBarChange;
      sb[i].Name:='SB'+IntToStr(i);
      sb[i].Position:=Round(w[i]*100);
      sb[i].Parent:=self.ScrollBox1;
    end;
  end;

procedure TWeigf.ScrollBarChange(Sender: TObject);
var nm:string;
    inx:integer;
begin
  nm:=TScrollBar(Sender).Name;
  nm:=Copy(nm,3,Length(nm)-2);
  inx:=StrToInt(nm);
  w[inx]:=TScrollBar(Sender).Position/100;
  st[inx].Caption:=FloatToStr(w[inx]);
end;

procedure TWeigf.SBarChange(Sender: TObject);
begin
  t:=SBar.Position/100;
  STPorogValue.Caption:=FloatToStr(t);
end;

procedure TWeigf.OKButtonClick(Sender: TObject);
var i:integer;
begin
  for i:=1 to siz do
  scon.ChWeig(otvet[i],w[i]);
  neur.T:=t;
end;

end.

