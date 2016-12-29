unit mainform;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls;

type
  TForm1 = class(TForm)
    Edit1: TEdit;
    Button1: TButton;
    Label1: TLabel;
    Image1: TImage;
    Button2: TButton;
    Image2: TImage;
    Image3: TImage;
    Image4: TImage;
    Image5: TImage;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    OpenDialog1: TOpenDialog;
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.Button2Click(Sender: TObject);
var f:textfile;
    y:array[1..100,1..100] of extended;
    avg,min,max:extended;
    j,k:integer;
begin
    if Edit1.Text='' then exit;
    assignfile(f,Edit1.Text);
    reset(f);
    readln(f);
    readln(f);
    max:=-100; min:=100; avg:=0;
    for j:=1 to 100 do
      for k:=1 to 100 do
      begin
        read(f,y[j,k]);
        avg:=avg+y[j,k];
        if y[j,k]>max then max:=y[j,k];
        if y[j,k]<min then min:=y[j,k];
      end;
    avg:=avg/10000;  

    for j:=1 to 100 do
      for k:=1 to 100 do
      begin
        if y[j,k]>0 then
        begin
          Image1.Canvas.Pixels[j,k]:=RGB(255*round(abs(y[j,k]/max)),0,0);
          Image2.Canvas.Pixels[j,k]:=RGB(255*round(abs(y[j,k]/avg)),0,0);
          Image5.Canvas.Pixels[j,k]:=RGB(255*round(sqrt(abs(y[j,k]/max))),0,0);
          Image3.Canvas.Pixels[j,k]:=RGB(255*round(ln(1+abs(y[j,k])/ln(1+max))),0,0);
        end;
        if y[j,k]<0 then
        begin
          Image1.Canvas.Pixels[j,k]:=RGB(0,0,255*round(abs(y[j,k]/max)));
          Image2.Canvas.Pixels[j,k]:=RGB(0,0,255*round(abs(y[j,k]/avg)));
          Image3.Canvas.Pixels[j,k]:=RGB(0,0,255*round(ln(1+abs(y[j,k]/ln(1+abs(min))))));
          Image5.Canvas.Pixels[j,k]:=RGB(0,0,255*round(sqrt(abs(y[j,k]/max))));
        end;
      end;
    Image4.Canvas.StretchDraw(RECT(1,1,200,200),Image5.Picture.Graphic);
    closefile(f);
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  if OpenDialog1.Execute then
    Edit1.Text:=OpenDialog1.FileName;
end;

end.
