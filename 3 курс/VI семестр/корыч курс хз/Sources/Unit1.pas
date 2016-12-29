unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, XPMan;

type
  TForm1 = class(TForm)
    Button1: TButton;
    OutWindow: TMemo;
    Edit1: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Edit2: TEdit;
    Edit3: TEdit;
    Label4: TLabel;
    Label5: TLabel;
    Edit4: TEdit;
    Button3: TButton;
    Label6: TLabel;
    Label7: TLabel;
    XPManifest: TXPManifest;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;
  Vector = array[1..5] of real;
  Matrix = array[1..5, 1..6] of real;
  Letters = array[1..5] of Char;
var
  Form1: TForm1;
const
  L:Letters = ('x','y','z','s','t');
  b:Vector = (-2.4,3.6,-1.2,-6.1,-0.4) ;
  A:Matrix = ( (3,-2.7,-0.6,4.8,-1.3,0),
               (-2.4,-1.2,0.3,1.2,1.7,0),
               (-6.2,2.5,1.2,3.5,-2.7,0),
               (7.1,0,4.5,-4.1,-2.7,0),
               (0.1,4.1,-0.3,7.3,3.3,0)
             );

implementation

{$R *.dfm}
function MakeA(R:real):Matrix;
begin
  MakeA := A;
  MakeA[4,2] := R;
end;

function Gauss(N:integer; A:Matrix;b:Vector):Vector;
var x:Vector;  //ìàññèâ êîğíåé óğàâíåíèÿ
    i,j,k:Integer;
    r,g:Real;
begin
for i:=1 to N do  // çàíîñèì ñâîáîäíûå ÷ëåíû â ìàòğèöó À
A[i,N+1] := b[i];
for k:=1 to N do //ïğÿìîé õîä Ãàóññà, ïğèâåäåíèå ìàòğèöû êîıôôèöèåíòîâ ê òğåóãîëüíîìó âèäó
     begin
       for j:=k+1 to N do
          begin
            r:=a[j,k]/a[k,k];
            for i:=k to N do
               begin
                 a[j,i]:=a[j,i]-r*a[k,i];
               end;
            b[j]:=b[j]-r*b[k];
          end;
     end;
for k:=N downto 1 do //îáğàòíûé õîä Ãàóññà, âû÷èñëåíèå êîğíåé
     begin
       r:=0;
       for j:=k+1 to N do
         begin
           g:=a[k,j]*x[j];
           r:=r+g;
         end;
      x[k]:=(b[k]-r)/a[k,k];
     end;
  Gauss := x;

end;

procedure OutVector(x:Vector);
var i:Integer;
begin
  for i:= 1 to 5 do Form1.OutWindow.Lines.Add(L[i] +' = '+ FloatToStr(x[i]));
end;

procedure WriteSistem;
var i,j:Integer;
    S:string;
begin
  Form1.Label2.Caption := '';
  S:='';
  for i:= 1 to 5 do
  begin
    for j:= 1 to 5 do
    begin
       if (A[i,j]>0) and (j<>1) then
       S:=S + '+'+FloatToStr(A[i,j]) + '*' + L[j]
       else
       if A[i,j] = 0 then
       S:=S + '+R*' + L[j]
       else
       S:=S + FloatToStr(A[i,j]) + '*' + L[j];
    end;
    S:= S + ' = ' + FloatToStr(b[i]);
    S:= S + #13;
  end;
  Form1.Label2.Caption := S;
end;

procedure TForm1.Button1Click(Sender: TObject);
var x:Vector;
begin
 OutWindow.Clear;
 OutWindow.Lines.Add('R = '+Edit1.Text);
 x:= Gauss(5,MakeA(StrToFloat(Edit1.Text)),b);
 OutVector(x);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
   WriteSistem;
end;

procedure TForm1.Button3Click(Sender: TObject);
var
R:Real;
k1,k2,h: Real;
num,i: Integer;
x:Vector;
begin
  OutWindow.Clear;
  k1 := StrToFloat(Edit2.Text);
  k2 := StrToFloat(Edit3.Text);
  h := StrToFloat(Edit4.Text);
  num := Trunc((k2-k1)/h);
  for i:= 1 to num do
  begin
     R := k1 + h*(i-1);
     x:= Gauss(5,MakeA(R),b);
     if (x[3]>= -2.47) and (x[3]<= -0.29) then
     begin
      OutWindow.Lines.Add('R = '+FloatToStr(R)+'       z = ' + FloatToStr(x[3]))
     end;
  end;
end;

end.
