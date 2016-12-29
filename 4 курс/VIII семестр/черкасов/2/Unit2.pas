unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TForm2 = class(TForm)
    Button1: TButton;
    ListBox1: TListBox;
    Label1: TLabel;
    PaintBox1: TPaintBox;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  xk,uk, curx, lastx: double;
  Form2: TForm2;
  i:integer;
  e,a,b,cappa:double;
implementation

{$R *.dfm}

function func(x: double):double;         // функция
begin
  Result:=x*x+5;
end;

function A_grad(x: double):double;     //анти градиеент
begin
  A_grad:=-(2*x);
end;

function Move(delta:double):double;   //минимизация
var tempx:Double;
begin
     tempx:=xk+delta*uk;
     Move:=Func(tempx);
end;   

procedure obnulenie;
begin
i:=1;
curx:=5;
e:=0.0001;
a:=-100;
b:=100;
end;

function Delenie(a,b,e:double):double;     //метод золотого сечения
var c1,c2,prec:double;
begin
prec:=e/100;
while Abs(a-b)>(e) do
begin
c1:=(a+b)/2-prec;
c2:=(a+b)/2+prec;
if Move(c1)>Move(c2) then   a:=c1   else  b:=c2;
end;
Delenie:=(a+b/2) ;
end;

procedure Plot(px:double);    // нарисовать точку
var x,y,r,k:integer;
begin
  x:=Round(px);
  y:=Round(func(px));
  r:=4;

  k:=20;
  x:=x*k +100;
  y:=250 - y*k;

  //Form2.PaintBox1.Canvas.Polyline([Point(0,200),Point(200,200)]);
  //Form2.PaintBox1.Canvas.Polyline([Point(100,0),Point(100,275)]);

  Form2.PaintBox1.Canvas.LineTo(x,y);
  Form2.PaintBox1.Canvas.Ellipse(x-r,y-r,x+r,y+r);
end;

procedure TForm2.Button1Click(Sender: TObject);
begin
ListBox1.items.Clear;
obnulenie;
while abs(Func(curx)-Func(lastx))>e do
begin
xk:=curx;
uk:=A_grad(curx);
cappa:=Delenie(a,b,e);
lastx:=curx;
curx:=curx+cappa*uk;
i:=i+1;
ListBox1.items.add('x='+FloatToStrF(curx,fffixed,0,2)+' Func='+FloatTostrF(Func(curx),fffixed,0,2) +'  DF(x)='+FloatTostrF(cappa,fffixed,0,5)+'  Grad='+FloatTostrF(A_Grad(curx),fffixed,0,5));
Plot(curx);
end;
end;

end.
