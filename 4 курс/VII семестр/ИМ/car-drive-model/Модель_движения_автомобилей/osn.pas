unit osn;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Math;

type
  TForm1 = class(TForm)
    start: TButton;
    map: TButton;
    Image1: TImage;
    Timer1: TTimer;
    Label1: TLabel;
    Edit1: TEdit;
    Label3: TLabel;
    Edit2: TEdit;
    Label5: TLabel;
    Edit3: TEdit;
    Edit4: TEdit;
    Label7: TLabel;
    Label9: TLabel;
    Edit5: TEdit;
    Label10: TLabel;
    Edit6: TEdit;
    OpenDialog1: TOpenDialog;
    Button1: TButton;
    Edit7: TEdit;
    procedure grass;    
    procedure mapClick(Sender: TObject);
    procedure startClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure ochishenie;
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure Edit2KeyPress(Sender: TObject; var Key: Char);
    procedure Button1Click(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure Edit6KeyPress(Sender: TObject; var Key: Char);
    procedure Edit5KeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;


  type
    auto=class
     i,j:real;
     b:real;
     n:integer;
     tp,np:integer;
     vperedi:integer;
     dis:real;
     u:boolean;
     procedure kolvo_vperedi;
     procedure oprpov;
     procedure riscar(var Image1:TImage; t:integer);
     procedure dvizenie(timer1:Ttimer);
     procedure oprnextpov;
     procedure uslovie;
     procedure distance;
    end;
    mashini=array[1..200] of auto;
    doroga=class
     I,j:integer;
     Vid:integer;
     R:integer;
     rv:integer;
     Time:integer;
     Timesm:integer;
     N1 ,N2 ,N3 ,N4 ,N5 ,N6 ,N7 ,N8 ,N9 ,N10 ,N11 ,N12:integer;
     svet:boolean;
     vezd:boolean;
     Timev:integer;
     Timevsm:integer;
     procedure zapolnenie(m,i1,j1,smin,smax,vmin,vmax:integer);
     procedure ris(var image1:Timage; k: integer);
     procedure smenasveta(b:integer);
     procedure sbros(b:integer);
     procedure new_car(var car:mashini);
     procedure kolvo_mashin(car:mashini);
    end;
    dorogi=array[1..2500] of doroga;
var
  speed,number:integer;
  cars:mashini;
  puti:dorogi;
  Form1: TForm1;
  dl,sh:integer;
  d,a,flag:integer;
implementation

{$R *.dfm}
procedure doroga.zapolnenie(m,i1,j1,smin,smax,vmin,vmax:integer);
 var
  flag1:integer;
begin
 randomize;
 i:=i1;
 j:=j1;
 vid:=m;
 flag1:=0;
 if((I=1) and (Vid=11))
  then begin
        vezd:=true;
        Timevsm:=random(vmax-vmin+1)+vmin;
        Timev:=0;
        rv:=1;
       end;
 if((j=1) and (Vid=12))
  then begin
        vezd:=true;
        Timevsm:=random(vmax-vmin+1)+vmin;
        Timev:=0;
        rv:=2;
       end;
 if((i=sh) and (Vid=11))
  then begin
        vezd:=true;
        Timevsm:=random(vmax-vmin+1)+vmin;
        Timev:=0;
        rv:=-1;
       end;
 if((j=dl) and (Vid=12))
  then begin
        vezd:=true;
        Timevsm:=random(vmax-vmin+1)+vmin;
        Timev:=0;
        rv:=-2;
       end;
 if((Vid>20) or (Vid=3))
  then begin
        svet:=true;
        Timesm:=random(smax-smin+1)+smin;
        Time:=Timesm*1000;
        if(vid>20)
         then begin
               R:=random(3)+1;
              end;
        if(vid=3)
         then begin
               R:=random(6)+1;
              end;
       end;
end;

procedure doroga.ris(var image1:Timage; k: integer);
var
 x,y,x1,x2,y1,y2,dx,dy:integer;
begin
 x:=k * (j-1);
 y:=k * (i-1);
 image1.Canvas.Pen.Color:=clGreen;
 image1.Canvas.Brush.Color:=clwhite;
  if vid=11
    then begin
          image1.Canvas.MoveTo(x+2,y);
          image1.Canvas.LineTo(x+2,y+k);
          image1.Canvas.MoveTo(x+k-3,y);
          image1.Canvas.LineTo(x+k-3,y+k);
         end;
  if vid=12
    then begin
          image1.Canvas.MoveTo(x,y+2);
          image1.Canvas.LineTo(x+k,y+2);
          image1.Canvas.MoveTo(x,y+k-3);
          image1.Canvas.LineTo(x+k,y+k-3);
         end;
  if vid=21
    then begin
          image1.Canvas.Pen.Color:=clGreen;
          image1.Canvas.MoveTo(x+2,y);
          image1.Canvas.LineTo(x+2,y+k);
          image1.Canvas.moveto(x+k-3,y+k);
          image1.Canvas.LineTo(x+k,y+k-3);
          image1.Canvas.moveto(x+k-3,y-1);
          image1.Canvas.LineTo(x+k,y+2);
          image1.Canvas.Rectangle(x+k+1,y-2-(k div 4),x+k+1+(k div 4),y-2);
          x1:=x+k+1;
          y1:=y-2-(k div 4);
          x2:=x+k+1+(k div 4);
          y2:=y-2;
          dx:=x2-x1;
          dy:=y2-y1;
          image1.Canvas.MoveTo(dx div 18 + x1, y1);
          image1.Canvas.LineTo(dx div 18 + x1, y2);
          image1.Canvas.MoveTo(dx * 13 div 18 + x1, y1);
          image1.Canvas.LineTo(dx * 13 div 18 + x1, dy * 3 div 18 + y1);
          image1.Canvas.LineTo(x2, dy * 3 div 18 + y1);
          image1.Canvas.MoveTo(dx * 13 div 18 + x1,y2-1);
          image1.Canvas.LineTo(dx * 13 div 18 + x1, dy * 15 div 18 + y1);
          image1.Canvas.LineTo(x2, dy * 15 div 18 + y1);
          image1.Canvas.Pen.Color:=clGreen;
          if(r=1)
           then begin
                 image1.Canvas.MoveTo(dx * 5 div 18 + x1, y1);
                 image1.canvas.LineTo(dx * 5 div 18 + x1, dy * 15 div 18 + y1);
                 image1.Canvas.LineTo(dx * 2 div 9 + x1, dy * 13 div 18 + y1 );
                 image1.canvas.MoveTo(dx * 5 div 18 + x1, dy * 15 div 18 + y1);
                 image1.Canvas.LineTo(dx * 3 div 9 + x1, dy * 13 div 18 + y1 );
                 image1.Canvas.MoveTo(dx * 5 div 18 + x1, dy * 11 div 18 + y1);
                 image1.Canvas.LineTo(dx * 11 div 18 + x1, dy * 11 div 18 + y1);
                 image1.Canvas.LineTo(dx * 9 div 18 + x1, dy * 5 div 9 + y1 );
                 image1.canvas.MoveTo(dx * 11 div 18 + x1, dy * 11 div 18 + y1);
                 image1.Canvas.LineTo(dx * 9 div 18 + x1, dy * 6 div 9 + y1 );
                 image1.Canvas.MoveTo(x2 - 1, dy * 7 div 18 + y1);
                 image1.Canvas.LineTo(dx * 9 div 18 + x1, dy * 7 div 18 + y1);
                 image1.Canvas.LineTo(dx * 9 div 18 + x1, dy * 3 div 18  + y1);
                 image1.Canvas.LineTo(dx * 4 div 9 + x1, dy * 5 div 18 + y1 );
                 image1.canvas.MoveTo(dx * 9 div 18 + x1, dy * 3 div 18 + y1);
                 image1.Canvas.LineTo(dx * 5 div 9 + x1, dy * 5 div 18 + y1 );
                end;
          if(r=2)
           then begin
                 image1.Canvas.MoveTo(dx * 5 div 18 + x1, y1);
                 image1.canvas.LineTo(dx * 5 div 18 + x1, dy * 15 div 18 + y1);
                 image1.Canvas.LineTo(dx * 2 div 9 + x1, dy * 13 div 18 + y1 );
                 image1.canvas.MoveTo(dx * 5 div 18 + x1, dy * 15 div 18 + y1);
                 image1.Canvas.LineTo(dx * 3 div 9 + x1, dy * 13 div 18 + y1 );
                 image1.Canvas.MoveTo(dx * 9 div 18 + x1, y2-1);
                 image1.Canvas.LineTo(dx * 9 div 18 + x1, dy * 3 div 18 + y1);
                 image1.Canvas.LineTo(dx * 8 div 18 + x1, dy * 5 div 18 + y1 );
                 image1.canvas.MoveTo(dx * 9 div 18 + x1, dy * 3 div 18 + y1);
                 image1.Canvas.LineTo(dx * 10 div 18 + x1, dy * 5 div 18 + y1 );
                 image1.Canvas.MoveTo(dx * 9 div 18 + x1, dy * 11 div 18 + y1);
                 image1.Canvas.LineTo(dx * 15 div 18 + x1, dy * 11 div 18 + y1);
                 image1.Canvas.LineTo(dx * 13 div 18 + x1, dy * 10 div 18  + y1);
                 image1.canvas.MoveTo(dx * 15 div 18 + x1, dy * 11 div 18 + y1);
                 image1.Canvas.LineTo(dx * 13 div 18 + x1, dy * 12 div 18 + y1 );
                end;
          if(r=3)
           then begin
                 image1.Canvas.MoveTo(x2-1,dy * 7 div 18 + y1);
                 image1.Canvas.LineTo(dx * 5 div 18 + x1 ,dy * 7 div 18 + y1);
                 image1.Canvas.LineTo(dx * 5 div 18 + x1 ,dy * 15 div 18 + y1);
                 image1.Canvas.LineTo(dx * 4 div 18 + x1 ,dy * 13 div 18 + y1);
                 image1.Canvas.MoveTo(dx * 5 div 18 + x1 ,dy * 15 div 18 + y1);
                 image1.Canvas.LineTo(dx * 6 div 18 + x1 ,dy * 13 div 18 + y1);
                 image1.Canvas.MoveTo(dx * 9 div 18 + x1 ,dy * 7 div 18 + y1);
                 image1.Canvas.LineTo(dx * 9 div 18 + x1 ,dy * 3 div 18 + y1);
                 image1.Canvas.LineTo(dx * 8 div 18 + x1 ,dy * 5 div 18 + y1);
                 image1.Canvas.MoveTo(dx * 9 div 18 + x1 ,dy * 3 div 18 + y1);
                 image1.Canvas.LineTo(dx * 10 div 18 + x1 ,dy * 5 div 18 + y1);
                end;
         end;
  if vid=22
    then begin
          image1.Canvas.MoveTo(x,y+k-3);
          image1.Canvas.LineTo(x+k,y+k-3);
          image1.Canvas.moveto(x-1,y+2);
          image1.Canvas.LineTo(x+2,y-1);
          image1.Canvas.moveto(x+k-3,y-1);
          image1.Canvas.LineTo(x+k,y+2);
          image1.Canvas.Rectangle(x+k+1,y-2-(k div 4),x+k+1+(k div 4),y-2);
          x1:=x+k+1;
          y1:=y-2-(k div 4);
          x2:=x+k+1+(k div 4);
          y2:=y-2;
          dx:=x2-x1 + 1;
          dy:=y2-y1 + 1;
          image1.Canvas.MoveTo(x1, y1 + dy * 17 div 18);
          image1.Canvas.LineTo(x2, y1 + dy * 17 div 18);
          image1.Canvas.MoveTo(dx * 3 div 18 + x1, y1);
          image1.Canvas.LineTo(dx * 3 div 18 + x1, dy * 5 div 18 + y1);
          image1.Canvas.LineTo(x1, dy * 5 div 18 + y1);
          image1.Canvas.MoveTo(dx * 15 div 18 + x1,y1);
          image1.Canvas.LineTo(dx * 15 div 18 + x1, dy * 5 div 18 + y1);
          image1.Canvas.LineTo(x2, dy * 5 div 18 + y1);
          image1.Canvas.Pen.Color:=clGreen;
          if(r=1)
           then begin
                 image1.Canvas.MoveTo(dx * 7 div 18 + x1, y1);
                 image1.canvas.LineTo(dx * 7 div 18 + x1, dy * 9 div 18 + y1);
                 image1.Canvas.LineTo(dx * 3 div 18 + x1, dy * 9 div 18 + y1);
                 image1.Canvas.LineTo(dx * 5 div 18 + x1, dy * 10 div 18 + y1);
                 image1.Canvas.MoveTo(dx * 3 div 18 + x1, dy * 9 div 18 + y1);
                 image1.Canvas.LineTo(dx * 5 div 18 + x1, dy * 8 div 18 + y1);
                 image1.Canvas.MoveTo(x1, dy * 13 div 18 + y1);
                 image1.Canvas.LineTo(dx * 15 div 18 + x1, dy * 13 div 18 + y1);
                 image1.Canvas.LineTo(dx * 13 div 18 + x1, dy * 12 div 18 + y1);
                 image1.Canvas.MoveTo(dx * 15 div 18 + x1, dy * 13 div 18 + y1);
                 image1.Canvas.LineTo(dx * 13 div 18 + x1, dy * 14 div 18 + y1);
                 image1.Canvas.MoveTo(dx * 11 div 18 + x1, dy * 13 div 18 + y1);
                 image1.Canvas.LineTo(dx * 11 div 18 + x1, dy * 7 div 18 + y1);
                 image1.Canvas.LineTo(dx * 12 div 18 + x1, dy * 9 div 18 + y1);
                 image1.Canvas.MoveTo(dx * 11 div 18 + x1, dy * 7 div 18 + y1);
                 image1.Canvas.LineTo(dx * 10 div 18 + x1, dy * 9 div 18 + y1);
                end;
          if(r=2)
           then begin
                 image1.Canvas.MoveTo(x1, dy * 13 div 18 + y1);
                 image1.Canvas.LineTo(dx * 15 div 18 + x1, dy * 13 div 18 + y1);
                 image1.Canvas.LineTo(dx * 13 div 18 + x1, dy * 14 div 18 + y1);
                 image1.Canvas.MoveTo(dx * 15 div 18 + x1, dy * 13 div 18 + y1);
                 image1.Canvas.LineTo(dx * 13 div 18 + x1, dy * 12 div 18 + y1);

                 image1.Canvas.MoveTo(x2 - 1, dy * 9 div 18 + y1);
                 image1.Canvas.LineTo(dx * 3 div 18 + x1, dy * 9 div 18 + y1);
                 image1.Canvas.LineTo(dx * 5 div 18 + x1, dy * 10 div 18 + y1);
                 image1.Canvas.MoveTo(dx * 3 div 18 + x1, dy * 9 div 18 + y1);
                 image1.Canvas.LineTo(dx * 5 div 18 + x1, dy * 8 div 18 + y1);

                 image1.Canvas.MoveTo(dx * 11 div 18 + x1, dy * 9 div 18 + y1);
                 image1.Canvas.LineTo(dx * 11 div 18 + x1, dy * 3 div 18 + y1);
                 image1.Canvas.LineTo(dx * 10 div 18 + x1, dy * 5 div 18 + y1);
                 image1.Canvas.MoveTo(dx * 11 div 18 + x1, dy * 3 div 18 + y1);
                 image1.Canvas.LineTo(dx * 12 div 18 + x1, dy * 5 div 18 + y1);
                end;
          if(r=3)
           then begin
                 image1.Canvas.MoveTo(dx * 7 div 18 + x1, y1);
                 image1.Canvas.LineTo(dx * 7 div 18 + x1, dy * 13 div 18 + y1);
                 image1.Canvas.LineTo(dx * 15 div 18 + x1, dy * 13 div 18 + y1);
                 image1.Canvas.LineTo(dx * 13 div 18 + x1, dy * 12 div 18 + y1);
                 image1.Canvas.MoveTo(dx * 15 div 18 + x1, dy * 13 div 18 + y1);
                 image1.Canvas.LineTo(dx * 13 div 18 + x1, dy * 14 div 18 + y1);

                 image1.Canvas.MoveTo(dx * 7 div 18 + x1, dy * 9 div 18 + y1);
                 image1.Canvas.LineTo(dx * 3 div 18 + x1, dy * 9 div 18 + y1);
                 image1.Canvas.LineTo(dx * 5 div 18 + x1, dy * 8 div 18 + y1);
                 image1.Canvas.MoveTo(dx * 3 div 18 + x1, dy * 9 div 18 + y1);
                 image1.Canvas.LineTo(dx * 5 div 18 + x1, dy * 10 div 18 + y1);
                end;
         end;
  if vid=23
    then begin
          image1.Canvas.MoveTo(x+k-3,y);
          image1.Canvas.LineTo(x+k-3,y+k);
          image1.Canvas.moveto(x-1,y+2);
          image1.Canvas.LineTo(x+2,y-1);
          image1.Canvas.moveto(x-1,y+k-3);
          image1.Canvas.LineTo(x+2,y+k);
          image1.Canvas.Rectangle(x+k+1,y-2-(k div 4),x+k+1+(k div 4),y-2);
          x1:=x+k+1;
          y1:=y-2-(k div 4);
          x2:=x+k+1+(k div 4);
          y2:=y-2;
          dx:=x2-x1;
          dy:=y2-y1;
          image1.Canvas.MoveTo(x1 + dx * 17 div 18, y1);
          image1.Canvas.LineTo(x1 + dx * 17 div 18, y2);
          image1.Canvas.MoveTo(x1, dy * 3 div 18 + y1);
          image1.Canvas.LineTo(dx * 5 div 18 + x1, dy * 3 div 18 + y1);
          image1.Canvas.LineTo(dx * 5 div 18 + x1, y1);
          image1.Canvas.MoveTo(dx * 5 div 18 + x1,y2 - 1);
          image1.Canvas.LineTo(dx * 5 div 18 + x1, dy * 15 div 18 + y1);
          image1.Canvas.LineTo(x1, dy * 15 div 18 + y1);
          image1.Canvas.Pen.Color:=clGreen;
          if(r=1)
           then begin
                 image1.Canvas.MoveTo(x1, dy * 11 div 18 + y1);
                 image1.canvas.LineTo(dx * 9 div 18 + x1, dy * 11 div 18 + y1);
                 image1.canvas.LineTo(dx * 9 div 18 + x1, dy * 15 div 18 + y1);
                 image1.canvas.LineTo(dx * 8 div 18 + x1, dy * 13 div 18 + y1);
                 image1.canvas.MoveTo(dx * 9 div 18 + x1, dy * 15 div 18 + y1);
                 image1.canvas.LineTo(dx * 10 div 18 + x1, dy * 13 div 18 + y1);

                 image1.Canvas.MoveTo(dx * 13 div 18 + x1,y2-1);
                 image1.canvas.LineTo(dx * 13 div 18 + x1, dy * 3 div 18 + y1);
                 image1.canvas.LineTo(dx * 12 div 18 + x1, dy * 5 div 18 + y1);
                 image1.canvas.MoveTo(dx * 13 div 18 + x1, dy * 3 div 18 + y1);
                 image1.canvas.LineTo(dx * 14 div 18 + x1, dy * 5 div 18 + y1);

                 image1.Canvas.MoveTo(dx * 13 div 18 + x1, dy * 7 div 18 + y1);
                 image1.Canvas.LineTo(dx * 7 div 18 + x1, dy * 7 div 18 + y1);
                 image1.Canvas.LineTo(dx * 9 div 18 + x1, dy * 6 div 18 + y1);
                 image1.Canvas.MoveTo(dx * 7 div 18 + x1, dy * 7 div 18 + y1);
                 image1.Canvas.LineTo(dx * 9 div 18 + x1, dy * 8 div 18 + y1);
                end;
          if(r=2)
           then begin
                 image1.Canvas.MoveTo(dx * 9 div 18 + x1, dy * 0 div 18 + y1);
                 image1.canvas.LineTo(dx * 9 div 18 + x1, dy * 15 div 18 + y1);
                 image1.canvas.LineTo(dx * 8 div 18 + x1, dy * 13 div 18 + y1);
                 image1.canvas.MoveTo(dx * 9 div 18 + x1, dy * 15 div 18 + y1);
                 image1.canvas.LineTo(dx * 10 div 18 + x1, dy * 13 div 18 + y1);

                 image1.Canvas.MoveTo(dx * 9 div 18 + x1, dy * 7 div 18 + y1);
                 image1.canvas.LineTo(dx * 3 div 18 + x1, dy * 7 div 18 + y1);
                 image1.canvas.LineTo(dx * 5 div 18 + x1, dy * 6 div 18 + y1);
                 image1.canvas.MoveTo(dx * 3 div 18 + x1, dy * 7 div 18 + y1);
                 image1.canvas.LineTo(dx * 5 div 18 + x1, dy * 8 div 18 + y1);

                 image1.Canvas.MoveTo(dx * 13 div 18 + x1, y2 - 1);
                 image1.canvas.LineTo(dx * 13 div 18 + x1, dy * 3 div 18 + y1);
                 image1.canvas.LineTo(dx * 12 div 18 + x1, dy * 5 div 18 + y1);
                 image1.canvas.MoveTo(dx * 13 div 18 + x1, dy * 3 div 18 + y1);
                 image1.canvas.LineTo(dx * 14 div 18 + x1, dy * 5 div 18 + y1);
                end;
          if(r=3)
           then begin
                 image1.Canvas.MoveTo(x1, dy * 11 div 18 + y1);
                 image1.canvas.LineTo(dx * 13 div 18 + x1, dy * 11 div 18 + y1);
                 image1.canvas.LineTo(dx * 13 div 18 + x1, dy * 3 div 18 + y1);
                 image1.canvas.LineTo(dx * 12 div 18 + x1, dy * 5 div 18 + y1);
                 image1.canvas.MoveTo(dx * 13 div 18 + x1, dy * 3 div 18 + y1);
                 image1.canvas.LineTo(dx * 14 div 18 + x1, dy * 5 div 18 + y1);

                 image1.Canvas.MoveTo(dx * 9 div 18 + x1, dy * 11 div 18 + y1);
                 image1.canvas.LineTo(dx * 9 div 18 + x1, dy * 15 div 18 + y1);
                 image1.canvas.LineTo(dx * 8 div 18 + x1, dy * 13 div 18 + y1);
                 image1.canvas.MoveTo(dx * 9 div 18 + x1, dy * 15 div 18 + y1);
                 image1.canvas.LineTo(dx * 10 div 18 + x1, dy * 13 div 18 + y1);
                end;
         end;
  if vid=24
    then begin
          image1.Canvas.MoveTo(x,y+2);
          image1.Canvas.LineTo(x+k,y+2);
          image1.Canvas.moveto(x+k-3,y+k);
          image1.Canvas.LineTo(x+k,y+k-3);
          image1.Canvas.moveto(x-1,y+k-3);
          image1.Canvas.LineTo(x+2,y+k);
          image1.Canvas.Rectangle(x+k+1,y-2-(k div 4),x+k+1+(k div 4),y-2);
          x1:=x+k+1;
          y1:=y-2-(k div 4);
          x2:=x+k+1+(k div 4);
          y2:=y-2;
          dx:=x2-x1;
          dy:=y2-y1;
          image1.Canvas.MoveTo(x1, y1 + dy * 1 div 18);
          image1.Canvas.LineTo(x2 - 1, y1 + dy * 1 div 18);
          image1.Canvas.MoveTo(x1, dy * 13 div 18 + y1);
          image1.Canvas.LineTo(dx * 3 div 18 + x1, dy * 13 div 18 + y1);
          image1.Canvas.LineTo(dx * 3 div 18 + x1, y2 - 1);
          image1.Canvas.MoveTo(dx * 15 div 18 + x1, y2 - 1);
          image1.Canvas.LineTo(dx * 15 div 18 + x1, dy * 13 div 18 + y1);
          image1.Canvas.LineTo(x2 - 1, dy * 13 div 18 + y1);
          image1.Canvas.Pen.Color:=clGreen;
          if(r=1)
           then begin
                 image1.Canvas.MoveTo(x2 - 1, dy * 5 div 18 + y1);
                 image1.canvas.LineTo(dx * 3 div 18 + x1, dy * 5 div 18 + y1);
                 image1.canvas.LineTo(dx * 5 div 18 + x1, dy * 4 div 18 + y1);
                 image1.canvas.MoveTo(dx * 3 div 18 + x1, dy * 5 div 18 + y1);
                 image1.canvas.LineTo(dx * 5 div 18 + x1, dy * 6 div 18 + y1);

                 image1.Canvas.MoveTo(dx * 7 div 18 + x1, dy * 5 div 18 + y1);
                 image1.canvas.LineTo(dx * 7 div 18 + x1, dy * 11 div 18 + y1);
                 image1.canvas.LineTo(dx * 6 div 18 + x1, dy * 9 div 18 + y1);
                 image1.canvas.MoveTo(dx * 7 div 18 + x1, dy * 11 div 18 + y1);
                 image1.canvas.LineTo(dx * 8 div 18 + x1, dy * 9 div 18 + y1);

                 image1.Canvas.MoveTo(dx * 11 div 18 + x1, y2 - 1);
                 image1.canvas.LineTo(dx * 11 div 18 + x1, dy * 9 div 18 + y1);
                 image1.canvas.LineTo(dx * 15 div 18 + x1, dy * 9 div 18 + y1);
                 image1.canvas.LineTo(dx * 13 div 18 + x1, dy * 8 div 18 + y1);
                 image1.canvas.MoveTo(dx * 15 div 18 + x1, dy * 9 div 18 + y1);
                 image1.canvas.LineTo(dx * 13 div 18 + x1, dy * 10 div 18 + y1);
                end;
          if(r=2)
           then begin
                 image1.Canvas.MoveTo(x2 - 1, dy * 5 div 18 + y1);
                 image1.canvas.LineTo(dx * 3 div 18 + x1, dy * 5 div 18 + y1);
                 image1.canvas.LineTo(dx * 5 div 18 + x1, dy * 4 div 18 + y1);
                 image1.canvas.MoveTo(dx * 3 div 18 + x1, dy * 5 div 18 + y1);
                 image1.canvas.LineTo(dx * 5 div 18 + x1, dy * 6 div 18 + y1);

                 image1.Canvas.MoveTo(x1, dy * 9 div 18 + y1);
                 image1.canvas.LineTo(dx * 15 div 18 + x1, dy * 9 div 18 + y1);
                 image1.canvas.LineTo(dx * 13 div 18 + x1, dy * 8 div 18 + y1);
                 image1.canvas.MoveTo(dx * 15 div 18 + x1, dy * 9 div 18 + y1);
                 image1.canvas.LineTo(dx * 13 div 18 + x1, dy * 10 div 18 + y1);

                 image1.Canvas.MoveTo(dx * 7 div 18 + x1, dy * 9 div 18 + y1);
                 image1.canvas.LineTo(dx * 7 div 18 + x1, dy * 15 div 18 + y1);
                 image1.canvas.LineTo(dx * 6 div 18 + x1, dy * 13 div 18 + y1);
                 image1.canvas.MoveTo(dx * 7 div 18 + x1, dy * 15 div 18 + y1);
                 image1.canvas.LineTo(dx * 8 div 18 + x1, dy * 13 div 18 + y1);
                end;
          if(r=3)
           then begin
                 image1.Canvas.MoveTo(dx * 11 div 18 + x1, y2 - 1);
                 image1.canvas.LineTo(dx * 11 div 18 + x1, dy * 5 div 18 + y1);
                 image1.canvas.LineTo(dx * 3 div 18 + x1, dy * 5 div 18 + y1);
                 image1.canvas.LineTo(dx * 5 div 18 + x1, dy * 6 div 18 + y1);
                 image1.canvas.MoveTo(dx * 3 div 18 + x1, dy * 5 div 18 + y1);
                 image1.canvas.LineTo(dx * 5 div 18 + x1, dy * 4 div 18 + y1);

                 image1.Canvas.MoveTo(dx * 11 div 18 + x1, dy * 9 div 18 + y1);
                 image1.canvas.LineTo(dx * 15 div 18 + x1, dy * 9 div 18 + y1);
                 image1.canvas.LineTo(dx * 13 div 18 + x1, dy * 8 div 18 + y1);
                 image1.canvas.MoveTo(dx * 15 div 18 + x1, dy * 9 div 18 + y1);
                 image1.canvas.LineTo(dx * 13 div 18 + x1, dy * 10 div 18 + y1);
                end;
         end;
  if vid=3
    then begin
          image1.Canvas.moveto(x+k-3,y+k);
          image1.Canvas.LineTo(x+k,y+k-3);
          image1.Canvas.moveto(x-1,y+k-3);
          image1.Canvas.LineTo(x+2,y+k);
          image1.Canvas.moveto(x+2,y-1);
          image1.Canvas.LineTo(x-1,y+2);
          image1.Canvas.moveto(x+k-3,y-1);
          image1.Canvas.LineTo(x+k,y+2);
          image1.Canvas.Rectangle(x+k+1,y-2-(k div 4),x+k+1+(k div 4),y-2);
          x1:=x+k+1;
          y1:=y-2-(k div 4);
          x2:=x+k+1+(k div 4);
          y2:=y-2;
          dx:=x2-x1;
          dy:=y2-y1;
          image1.Canvas.MoveTo(dx * 3 div 18 + x1, y1);
          image1.Canvas.LineTo(dx * 3 div 18 + x1, dy * 3 div 18 + y1);
          image1.Canvas.LineTo(x1, dy * 3 div 18 + y1);
          image1.Canvas.MoveTo(dx * 15 div 18 + x1, y1);
          image1.Canvas.LineTo(dx * 15 div 18 + x1, dy * 3 div 18 + y1);
          image1.Canvas.LineTo(x2 - 1, dy * 3 div 18 + y1);
          image1.Canvas.MoveTo(x1, dy * 15 div 18 + y1);
          image1.Canvas.LineTo(dx * 3 div 18 + x1, dy * 15 div 18 + y1);
          image1.Canvas.LineTo(dx * 3 div 18 + x1, y2 - 1);
          image1.Canvas.MoveTo(dx * 15 div 18 + x1, y2 - 1);
          image1.Canvas.LineTo(dx * 15 div 18 + x1, dy * 15 div 18 + y1);
          image1.Canvas.LineTo(x2 - 1, dy * 15 div 18 + y1);
          image1.Canvas.Pen.Color:=clGreen;           
          if(r=1)
           then begin
                 image1.Canvas.MoveTo(dx * 7 div 18 + x1, y1);
                 image1.canvas.LineTo(dx * 7 div 18 + x1, dy * 15 div 18 + y1);
                 image1.canvas.LineTo(dx * 6 div 18 + x1, dy * 13 div 18 + y1);
                 image1.canvas.MoveTo(dx * 7 div 18 + x1, dy * 15 div 18 + y1);
                 image1.canvas.LineTo(dx * 8 div 18 + x1, dy * 13 div 18 + y1);

                 image1.Canvas.MoveTo(dx * 7 div 18 + x1, dy * 7 div 18 + y1);
                 image1.canvas.LineTo(dx * 3 div 18 + x1, dy * 7 div 18 + y1);
                 image1.canvas.LineTo(dx * 5 div 18 + x1, dy * 6 div 18 + y1);
                 image1.canvas.MoveTo(dx * 3 div 18 + x1, dy * 7 div 18 + y1);
                 image1.canvas.LineTo(dx * 5 div 18 + x1, dy * 8 div 18 + y1);

                 image1.Canvas.MoveTo(dx * 11 div 18 + x1, y2 - 1);
                 image1.canvas.LineTo(dx * 11 div 18 + x1, dy * 3 div 18 + y1);
                 image1.canvas.LineTo(dx * 10 div 18 + x1, dy * 5 div 18 + y1);
                 image1.canvas.MoveTo(dx * 11 div 18 + x1, dy * 3 div 18 + y1);
                 image1.canvas.LineTo(dx * 12 div 18 + x1, dy * 5 div 18 + y1);

                 image1.Canvas.MoveTo(dx * 11 div 18 + x1, dy * 11 div 18 + y1);
                 image1.canvas.LineTo(dx * 15 div 18 + x1, dy * 11 div 18 + y1);
                 image1.canvas.LineTo(dx * 13 div 18 + x1, dy * 10 div 18 + y1);
                 image1.canvas.MoveTo(dx * 15 div 18 + x1, dy * 11 div 18 + y1);
                 image1.canvas.LineTo(dx * 13 div 18 + x1, dy * 12 div 18 + y1);
                end;
          if(r=2)
           then begin
                 image1.Canvas.MoveTo(dx * 11 div 18 + x1, y2 - 1);
                 image1.canvas.LineTo(dx * 11 div 18 + x1, dy * 3 div 18 + y1);
                 image1.canvas.LineTo(dx * 10 div 18 + x1, dy * 5 div 18 + y1);
                 image1.canvas.MoveTo(dx * 11 div 18 + x1, dy * 3 div 18 + y1);
                 image1.canvas.LineTo(dx * 12 div 18 + x1, dy * 5 div 18 + y1);

                 image1.Canvas.MoveTo(dx * 11 div 18 + x1, dy * 11 div 18 + y1);
                 image1.canvas.LineTo(dx * 15 div 18 + x1, dy * 11 div 18 + y1);
                 image1.canvas.LineTo(dx * 13 div 18 + x1, dy * 10 div 18 + y1);
                 image1.canvas.MoveTo(dx * 15 div 18 + x1, dy * 11 div 18 + y1);
                 image1.canvas.LineTo(dx * 13 div 18 + x1, dy * 12 div 18 + y1);

                 image1.Canvas.MoveTo(dx * 11 div 18 + x1, dy * 7 div 18 + y1);
                 image1.canvas.LineTo(dx * 5 div 18 + x1, dy * 7 div 18 + y1);
                 image1.canvas.LineTo(dx * 7 div 18 + x1, dy * 6 div 18 + y1);
                 image1.canvas.MoveTo(dx * 5 div 18 + x1, dy * 7 div 18 + y1);
                 image1.canvas.LineTo(dx * 7 div 18 + x1, dy * 8 div 18 + y1);
                end;
          if(r=3)
           then begin
                 image1.Canvas.MoveTo(dx * 7 div 18 + x1, y1);
                 image1.canvas.LineTo(dx * 7 div 18 + x1, dy * 15 div 18 + y1);
                 image1.canvas.LineTo(dx * 6 div 18 + x1, dy * 13 div 18 + y1);
                 image1.canvas.MoveTo(dx * 7 div 18 + x1, dy * 15 div 18 + y1);
                 image1.canvas.LineTo(dx * 8 div 18 + x1, dy * 13 div 18 + y1);

                 image1.Canvas.MoveTo(dx * 7 div 18 + x1, dy * 7 div 18 + y1);
                 image1.canvas.LineTo(dx * 3 div 18 + x1, dy * 7 div 18 + y1);
                 image1.canvas.LineTo(dx * 5 div 18 + x1, dy * 6 div 18 + y1);
                 image1.canvas.MoveTo(dx * 3 div 18 + x1, dy * 7 div 18 + y1);
                 image1.canvas.LineTo(dx * 5 div 18 + x1, dy * 8 div 18 + y1);

                 image1.Canvas.MoveTo(dx * 7 div 18 + x1, dy * 11 div 18 + y1);
                 image1.canvas.LineTo(dx * 13 div 18 + x1, dy * 11 div 18 + y1);
                 image1.canvas.LineTo(dx * 11 div 18 + x1, dy * 12 div 18 + y1);
                 image1.canvas.MoveTo(dx * 13 div 18 + x1, dy * 11 div 18 + y1);
                 image1.canvas.LineTo(dx * 11 div 18 + x1, dy * 10 div 18 + y1);
                end;
          if(r=4)
           then begin
                 image1.Canvas.MoveTo(x2 - 1, dy * 7 div 18 + y1);
                 image1.canvas.LineTo(dx * 3 div 18 + x1, dy * 7 div 18 + y1);
                 image1.canvas.LineTo(dx * 5 div 18 + x1, dy * 6 div 18 + y1);
                 image1.canvas.MoveTo(dx * 3 div 18 + x1, dy * 7 div 18 + y1);
                 image1.canvas.LineTo(dx * 5 div 18 + x1, dy * 8 div 18 + y1);

                 image1.Canvas.MoveTo(dx * 11 div 18 + x1, dy * 7 div 18 + y1);
                 image1.canvas.LineTo(dx * 11 div 18 + x1, dy * 3 div 18 + y1);
                 image1.canvas.LineTo(dx * 10 div 18 + x1, dy * 5 div 18 + y1);
                 image1.canvas.MoveTo(dx * 11 div 18 + x1, dy * 3 div 18 + y1);
                 image1.canvas.LineTo(dx * 12 div 18 + x1, dy * 5 div 18 + y1);
                 
                 image1.Canvas.MoveTo(x1, dy * 11 div 18 + y1);
                 image1.canvas.LineTo(dx * 15 div 18 + x1, dy * 11 div 18 + y1);
                 image1.canvas.LineTo(dx * 13 div 18 + x1, dy * 10 div 18 + y1);
                 image1.canvas.MoveTo(dx * 15 div 18 + x1, dy * 11 div 18 + y1);
                 image1.canvas.LineTo(dx * 13 div 18 + x1, dy * 12 div 18 + y1);

                 image1.Canvas.MoveTo(dx * 7 div 18 + x1, dy * 11 div 18 + y1);
                 image1.canvas.LineTo(dx * 7 div 18 + x1, dy * 15 div 18 + y1);
                 image1.canvas.LineTo(dx * 6 div 18 + x1, dy * 13 div 18 + y1);
                 image1.canvas.MoveTo(dx * 7 div 18 + x1, dy * 15 div 18 + y1);
                 image1.canvas.LineTo(dx * 8 div 18 + x1, dy * 13 div 18 + y1);
                end;
          if(r=5)
           then begin
                 image1.Canvas.MoveTo(x1, dy * 11 div 18 + y1);
                 image1.canvas.LineTo(dx * 15 div 18 + x1, dy * 11 div 18 + y1);
                 image1.canvas.LineTo(dx * 13 div 18 + x1, dy * 10 div 18 + y1);
                 image1.canvas.MoveTo(dx * 15 div 18 + x1, dy * 11 div 18 + y1);
                 image1.canvas.LineTo(dx * 13 div 18 + x1, dy * 12 div 18 + y1);

                 image1.Canvas.MoveTo(dx * 7 div 18 + x1, dy * 11 div 18 + y1);
                 image1.canvas.LineTo(dx * 7 div 18 + x1, dy * 15 div 18 + y1);
                 image1.canvas.LineTo(dx * 6 div 18 + x1, dy * 13 div 18 + y1);
                 image1.canvas.MoveTo(dx * 7 div 18 + x1, dy * 15 div 18 + y1);
                 image1.canvas.LineTo(dx * 8 div 18 + x1, dy * 13 div 18 + y1);

                 image1.Canvas.MoveTo(dx * 11 div 18 + x1, dy * 11 div 18 + y1);
                 image1.canvas.LineTo(dx * 11 div 18 + x1, dy * 5 div 18 + y1);
                 image1.canvas.LineTo(dx * 10 div 18 + x1, dy * 7 div 18 + y1);
                 image1.canvas.MoveTo(dx * 11 div 18 + x1, dy * 5 div 18 + y1);
                 image1.canvas.LineTo(dx * 12 div 18 + x1, dy * 7 div 18 + y1);
                end;
          if(r=6)
           then begin
                 image1.Canvas.MoveTo(x2 - 1, dy * 7 div 18 + y1);
                 image1.canvas.LineTo(dx * 3 div 18 + x1, dy * 7 div 18 + y1);
                 image1.canvas.LineTo(dx * 5 div 18 + x1, dy * 6 div 18 + y1);
                 image1.canvas.MoveTo(dx * 3 div 18 + x1, dy * 7 div 18 + y1);
                 image1.canvas.LineTo(dx * 5 div 18 + x1, dy * 8 div 18 + y1);

                 image1.Canvas.MoveTo(dx * 11 div 18 + x1, dy * 7 div 18 + y1);
                 image1.canvas.LineTo(dx * 11 div 18 + x1, dy * 3 div 18 + y1);
                 image1.canvas.LineTo(dx * 10 div 18 + x1, dy * 5 div 18 + y1);
                 image1.canvas.MoveTo(dx * 11 div 18 + x1, dy * 3 div 18 + y1);
                 image1.canvas.LineTo(dx * 12 div 18 + x1, dy * 5 div 18 + y1);

                 image1.Canvas.MoveTo(dx * 7 div 18 + x1, dy * 7 div 18 + y1);
                 image1.canvas.LineTo(dx * 7 div 18 + x1, dy * 13 div 18 + y1);
                 image1.canvas.LineTo(dx * 6 div 18 + x1, dy * 11 div 18 + y1);
                 image1.canvas.MoveTo(dx * 7 div 18 + x1, dy * 13 div 18 + y1);
                 image1.canvas.LineTo(dx * 8 div 18 + x1, dy * 11 div 18 + y1);
                end;
         end;
  if vid=13
    then begin
          image1.Canvas.moveto(x+2,y+k);
          image1.Canvas.LineTo(x+2,y+4);
          image1.Canvas.LineTo(x+4,y+2);
          image1.Canvas.LineTo(x+k,y+2);
          image1.Canvas.moveto(x+k-3,y+k);
          image1.Canvas.LineTo(x+k,y+k-3);
         end;
  if vid=14
    then begin
          image1.Canvas.moveto(x-1,y+2);
          image1.Canvas.LineTo(x+k-5,y+2);
          image1.Canvas.LineTo(x+k-3,y+4);
          image1.Canvas.LineTo(x+k-3,y+k);
          image1.Canvas.moveto(x-1,y+k-3);
          image1.Canvas.LineTo(x+2,y+k);
         end;
  if vid=15
    then begin
          image1.Canvas.moveto(x+2,y-1);
          image1.Canvas.LineTo(x+2,y+k-5);
          image1.Canvas.LineTo(x+4,y+k-3);
          image1.Canvas.LineTo(x+k,y+k-3);
          image1.Canvas.moveto(x+k-3,y-1);
          image1.Canvas.LineTo(x+k,y+2);
         end;
  if vid=16
    then begin
          image1.Canvas.moveto(x-1,y+k-3);
          image1.Canvas.LineTo(x+k-5,y+k-3);
          image1.Canvas.LineTo(x+k-3,y+k-5);
          image1.Canvas.LineTo(x+k-3,y-1);
          image1.Canvas.moveto(x-1,y+2);
          image1.Canvas.LineTo(x+2,y-1);
         end;
end;

procedure doroga.smenasveta(b:integer);
var flag1:integer;
begin
 if((b>=Time) and (svet=true))
  then begin
        flag1:=0;
        if((vid>20) and (r<3))
         then begin
               r:=r+1;
               flag1:=1;
               time:=time+timesm*1000;
              end;
        if((vid>20) and (r=3) and (flag1=0))
         then begin
               r:=1;
               time:=time+timesm*1000;
              end;
        if((vid=3) and (r<6))
         then begin
               r:=r+1;
               flag1:=1;
               time:=time+timesm*1000;
              end;
        if((vid=3) and (r=6) and (flag1=0))
         then begin
               r:=1;
               time:=time+timesm*1000;
              end;
       end;
end;

procedure doroga.sbros(b:integer);
begin
 if(svet=true)
  then begin
        time:=time-b;
       end;
 if(vezd=true)
  then begin

        timev:=timev-b;
       end;
end;

procedure doroga.new_car(var car:mashini);
var
 k:integer;
begin
 if(vezd=true)
  then begin
        k:=1;
        while((cars[k].n<>0) and (k<=number))
         do begin
             k:=k+1;
            end;
        if((k<=number) and (a>=timev))
         then begin
               car[k].n:=rv;
               if(rv=1)
                then begin
                      car[k].i:=0;
                      car[k].j:=j-1/2;
                     end;
               if(rv=-1)
                then begin
                      car[k].i:=sh;
                      car[k].j:=j-1/2;
                     end;
               if(rv=2)
                then begin
                      car[k].j:=0;
                      car[k].i:=i-1/2;
                     end;
               if(rv=-2)
                then begin
                      car[k].j:=dl;
                      car[k].i:=i-1/2;
                     end;
               car[k].oprpov;
               timev:=a+timevsm*1000;
              end;
       end;
end;

procedure doroga.kolvo_mashin(car:mashini);
 var
  k,ikletki,jkletki:integer;
begin
 k:=1;
 N1:=0;
 N2:=0;
 N3:=0;
 N4:=0;
 N5:=0;
 N6:=0;
 N7:=0;
 N8:=0;
 N9:=0;
 N10:=0;
 N11:=0;
 N12:=0;
 while(car[k].n<>0)
  do begin
      ikletki:=round(car[k].i * d) div d + 1;
      jkletki:=round(car[k].j * d) div d + 1;
      if(ikletki>sh)
       then begin
             ikletki:=ikletki-1;
            end;
      if(jkletki>dl)
       then begin
             jkletki:=jkletki-1;
            end;
      if((i=ikletki) and (j=jkletki))
       then begin
             if((vid=11)or(vid=12))
              then begin
                    if(car[k].n=1)
                     then begin
                           if(car[k].tp=1)
                            then begin
                                  N11:=N11+1;
                                 end;
                           if(car[k].tp=-2)
                            then begin
                                  N10:=N10+1;
                                 end;
                           if(car[k].tp=2)
                            then begin
                                  N12:=N12+1;
                                 end;
                          end;
                    if(car[k].n=-1)
                     then begin
                           if(car[k].tp=-1)
                            then begin
                                  N5:=N5+1;
                                 end;
                           if(car[k].tp=-2)
                            then begin
                                  N4:=N4+1;
                                 end;
                           if(car[k].tp=2)
                            then begin
                                  N6:=N6+1;
                                 end;
                          end;
                    if(car[k].n=2)
                     then begin
                           if(car[k].tp=-1)
                            then begin
                                  N7:=N7+1;
                                 end;
                           if(car[k].tp=2)
                            then begin
                                  N8:=N8+1;
                                 end;
                           if(car[k].tp=1)
                            then begin
                                  N9:=N9+1;
                                 end;
                          end;
                    if(car[k].n=-2)
                     then begin
                           if(car[k].tp=-1)
                            then begin
                                  N1:=N1+1;
                                 end;
                           if(car[k].tp=-2)
                            then begin
                                  N2:=N2+1;
                                 end;
                           if(car[k].tp=1)
                            then begin
                                  N3:=N3+1;
                                 end;
                          end;
                   end;
            end;
      k:=k+1;
     end;
end;
////////////////////////////////////////////////////////////////////////////////

procedure auto.oprpov();
var
 k,ipoisk,jpoisk,zapret:integer;
 ikletki,jkletki:real;
begin
 ipoisk:=round(i * d) div d + 1;
 jpoisk:=round(j * d) div d + 1;
 if(ipoisk>sh)
  then begin
        ipoisk:=ipoisk-1;
       end;
 if(jpoisk>dl)
  then begin
        jpoisk:=jpoisk-1;
       end;
 ikletki:=ipoisk;
 jkletki:=jpoisk;
 k:=1;
 while((puti[k].I<>ipoisk) or (puti[k].j<>jpoisk))
  do begin
      k:=k+1;
     end;

 while(((puti[k].Vid=11) or (puti[k].Vid=12)) and (tp<>3))
  do begin
      if(n=1)
       then begin
             ipoisk:=ipoisk+1;
            end;
      if(n=-1)
       then begin
             ipoisk:=ipoisk-1;
            end;
      if(n=2)
       then begin
             jpoisk:=jpoisk+1;
            end;
      if(n=-2)
       then begin
             jpoisk:=jpoisk-1;
            end;
      k:=1;
      while((puti[k].I<>ipoisk) or (puti[k].j<>jpoisk) and ((ipoisk>0) and (jpoisk>0) and (ipoisk<=sh) and (jpoisk<=dl)))
       do begin
           k:=k+1;
          end;
      if ((ipoisk<=0) or (jpoisk<=0) or (ipoisk>sh) or (jpoisk>dl))
       then begin
             tp:=3;
            end;
     end;
 if(tp<>3)
  then begin
        if(puti[k].Vid=13)
         then begin
               if(n=-1)
                then begin
                      tp:=2;
                     end;
                      if(n=-2)
                then begin
                      tp:=1;
                     end;
              end;
        if(puti[k].Vid=14)
         then begin
               if(n=-1)
                then begin
                      tp:=-2;
                     end;
               if(n=2)
                then begin
                      tp:=1;
                     end;
              end;
        if(puti[k].Vid=15)
         then begin
               if(n=1)
                then begin
                      tp:=2;
                     end;
               if(n=-2)
                then begin
                      tp:=-1;
                     end;
              end;
        if(puti[k].Vid=16)
         then begin
               if(n=1)
                then begin
                      tp:=-2;
                     end;
               if(n=2)
                then begin
                      tp:=-1;
                     end;
              end;
        if(puti[k].Vid=21)
         then begin
               zapret:=-2;
               repeat
                tp:=random(5)-2;
               until((tp<>zapret) and (tp<>-1*n) and (tp<>0));
              end;
        if(puti[k].Vid=22)
         then begin
               zapret:=1;
               repeat
                tp:=random(5)-2;
               until((tp<>zapret) and (tp<>-1*n) and (tp<>0));
              end;
        if(puti[k].Vid=23)
         then begin
               zapret:=2;
               repeat
                tp:=random(5)-2;
               until((tp<>zapret) and (tp<>-1*n) and (tp<>0));
              end;
        if(puti[k].Vid=24)
         then begin
               zapret:=-1;
               repeat
                tp:=random(5)-2;
               until((tp<>zapret) and (tp<>-1*n) and (tp<>0));
              end;
        if(puti[k].Vid=3)
         then begin
               repeat
                tp:=random(5)-2;
               until((tp<>-1*n) and (tp<>0));
              end;
        if(n=1)
         then begin
               if(tp=1)
                then begin
                      j:=jkletki-1+3/12;
                     end;
               if(tp=2)
                then begin
                      j:=jkletki-1+5/12;
                     end;
               if(tp=-2)
                then begin
                      j:=jkletki-1+1/12;
                     end;
               b:=3*pi/2;
              end;
        if(n=-1)
         then begin
               if(tp=-1)
                then begin
                      j:=jkletki-1+9/12;
                     end;
               if(tp=2)
                then begin
                      j:=jkletki-1+11/12;
                     end;
               if(tp=-2)
                then begin
                      j:=jkletki-1+7/12;
                     end;
               b:=1*pi/2;
              end;
        if(n=2)
         then begin
               if(tp=2)
                then begin
                      i:=ikletki-1+9/12;
                     end;
               if(tp=1)
                then begin
                      i:=ikletki-1+11/12;
                     end;
               if(tp=-1)
                then begin
                      i:=ikletki-1+7/12;
                     end;
               b:=0*pi/2;
              end;
        if(n=-2)
         then begin
               if(tp=-2)
                then begin
                      i:=ikletki-1+3/12;
                     end;
               if(tp=1)
                then begin
                      i:=ikletki-1+5/12;
                     end;
               if(tp=-1)
                then begin
                      i:=ikletki-1+1/12;
                     end;
               b:=2*pi/2;
              end;
       end;
end;

procedure auto.riscar(var Image1:TImage; t:integer);
var
 x,y,x1,y1,x2,y2:integer;
 dlina,shirina,f,a,l,x0,y0:real;
begin
 if(t=1)
  then begin
        image1.Canvas.Pen.Color:=clBlack;
        image1.Canvas.Brush.Color:=clBlack;
       end;
 if(t=0)
  then begin
        image1.Canvas.Brush.Color:=clWhite;
        image1.Canvas.Pen.color:=clWhite;
       end;
 shirina:=d/12;
 dlina:=d*5/36;
 x:=round(j*d);
 y:=round(i*d);
        //AB
        x0:=dlina/10;
        y0:=shirina/3;
        l:=sqrt(  x0*x0 + y0*y0 );
        f:=arctan(y0/x0);
        a:=pi-f+b;
        x1:=round(x + l*cos(a));
        y1:=round(y - l*sin(a));
        form1.Image1.Canvas.MoveTo(x,y);
        form1.Image1.Canvas.LineTo(x1,y1);
        //BC
        x0:=dlina/5;
        y0:=shirina/2;
        l:=sqrt(  x0*x0 + y0*y0 );
        f:=arctan(y0/x0);
        a:=pi-f+b;
        x1:=round(x + l*cos(a));
        y1:=round(y - l*sin(a));
        form1.Image1.Canvas.LineTo(x1,y1);
        //CD
        x0:=dlina*9/10;
        y0:=shirina/2;
        l:=sqrt(  x0*x0 + y0*y0 );
        f:=arctan(y0/x0);
        a:=pi-f+b;
        x1:=round(x + l*cos(a));
        y1:=round(y - l*sin(a));
        form1.Image1.Canvas.LineTo(x1,y1);
        //DE
        x0:=dlina*10/10;
        y0:=shirina/3;
        l:=sqrt(  x0*x0 + y0*y0 );
        f:=arctan(y0/x0);
        a:=pi-f+b;
        x1:=round(x + l*cos(a));
        y1:=round(y - l*sin(a));
        form1.Image1.Canvas.LineTo(x1,y1);
        //EF
        x0:=dlina*10/10;
        y0:=-shirina/3;
        l:=sqrt(  x0*x0 + y0*y0 );
        f:=arctan(y0/x0);
        a:=pi-f+b;
        x1:=round(x + l*cos(a));
        y1:=round(y - l*sin(a));
        form1.Image1.Canvas.LineTo(x1,y1);
        //FG
        x0:=dlina*9/10;
        y0:=-shirina/2;
        l:=sqrt(  x0*x0 + y0*y0 );
        f:=arctan(y0/x0);
        a:=pi-f+b;
        x1:=round(x + l*cos(a));
        y1:=round(y - l*sin(a));
        form1.Image1.Canvas.LineTo(x1,y1);
        //GH
        x0:=dlina*2/10;
        y0:=-shirina/2;
        l:=sqrt(  x0*x0 + y0*y0 );
        f:=arctan(y0/x0);
        a:=pi-f+b;
        x1:=round(x + l*cos(a));
        y1:=round(y - l*sin(a));
        form1.Image1.Canvas.LineTo(x1,y1);
        //HI
        x0:=dlina*1/10;
        y0:=-shirina/3;
        l:=sqrt(  x0*x0 + y0*y0 );
        f:=arctan(y0/x0);
        a:=pi-f+b;
        x1:=round(x + l*cos(a));
        y1:=round(y - l*sin(a));
        form1.Image1.Canvas.LineTo(x1,y1);
        //IA
        form1.Image1.Canvas.LineTo(x,y);
        //XY
        x0:=dlina*8/10;
        y0:=shirina/6;
        l:=sqrt(  x0*x0 + y0*y0 );
        f:=arctan(y0/x0);
        a:=pi-f+b;
        x1:=round(x + l*cos(a));
        y1:=round(y - l*sin(a));
        form1.Image1.Canvas.MoveTo(x1,y1);
        x0:=dlina*8/10;
        y0:=-shirina/6;
        l:=sqrt(  x0*x0 + y0*y0 );
        f:=arctan(y0/x0);
        a:=pi-f+b;
        x2:=round(x + l*cos(a));
        y2:=round(y - l*sin(a));
        form1.Image1.Canvas.LineTo(x2,y2);
        //YS
        x0:=dlina*5/10;
        y0:=-shirina/6;
        l:=sqrt(  x0*x0 + y0*y0 );
        f:=arctan(y0/x0);
        a:=pi-f+b;
        x2:=round(x + l*cos(a));
        y2:=round(y - l*sin(a));
        form1.Image1.Canvas.LineTo(x2,y2);
        //SR
        x0:=dlina*5/10;
        y0:=shirina/6;
        l:=sqrt(  x0*x0 + y0*y0 );
        f:=arctan(y0/x0);
        a:=pi-f+b;
        x2:=round(x + l*cos(a));
        y2:=round(y - l*sin(a));
        form1.Image1.Canvas.LineTo(x2,y2);
        //RX
        form1.Image1.Canvas.LineTo(x1,y1);
 if(d>=100)
  then begin
        //XD
        x0:=dlina*9/10;
        y0:=shirina/2;
        l:=sqrt(  x0*x0 + y0*y0 );
        f:=arctan(y0/x0);
        a:=pi-f+b;
        x2:=round(x + l*cos(a));
        y2:=round(y - l*sin(a));
        form1.Image1.Canvas.LineTo(x2,y2);
        //YG
        x0:=dlina*8/10;
        y0:=-shirina/6;
        l:=sqrt(  x0*x0 + y0*y0 );
        f:=arctan(y0/x0);
        a:=pi-f+b;
        x1:=round(x + l*cos(a));
        y1:=round(y - l*sin(a));
        form1.Image1.Canvas.MoveTo(x1,y1);
        x0:=dlina*9/10;
        y0:=-shirina/2;
        l:=sqrt(  x0*x0 + y0*y0 );
        f:=arctan(y0/x0);
        a:=pi-f+b;
        x2:=round(x + l*cos(a));
        y2:=round(y - l*sin(a));
        form1.Image1.Canvas.LineTo(x2,y2);
        //SQ
        x0:=dlina*5/10;
        y0:=-shirina/6;
        l:=sqrt(  x0*x0 + y0*y0 );
        f:=arctan(y0/x0);
        a:=pi-f+b;
        x1:=round(x + l*cos(a));
        y1:=round(y - l*sin(a));
        form1.Image1.Canvas.MoveTo(x1,y1);
        x0:=dlina*3/10;
        y0:=-shirina/2;
        l:=sqrt(  x0*x0 + y0*y0 );
        f:=arctan(y0/x0);
        a:=pi-f+b;
        x2:=round(x + l*cos(a));
        y2:=round(y - l*sin(a));
        form1.Image1.Canvas.LineTo(x2,y2);
        //RP
        x0:=dlina*5/10;
        y0:=shirina/6;
        l:=sqrt(  x0*x0 + y0*y0 );
        f:=arctan(y0/x0);
        a:=pi-f+b;
        x1:=round(x + l*cos(a));
        y1:=round(y - l*sin(a));
        form1.Image1.Canvas.MoveTo(x1,y1);
        x0:=dlina*3/10;
        y0:=shirina/2;
        l:=sqrt(  x0*x0 + y0*y0 );
        f:=arctan(y0/x0);
        a:=pi-f+b;
        x2:=round(x + l*cos(a));
        y2:=round(y - l*sin(a));
        form1.Image1.Canvas.LineTo(x2,y2);
        //PQ
        x0:=dlina*3/10;
        y0:=-shirina/2;
        l:=sqrt(  x0*x0 + y0*y0 );
        f:=arctan(y0/x0);
        a:=pi-f+b;
        x2:=round(x + l*cos(a));
        y2:=round(y - l*sin(a));
        form1.Image1.Canvas.LineTo(x2,y2);
        //DG
        x0:=dlina*9/10;
        y0:=shirina/2;
        l:=sqrt(  x0*x0 + y0*y0 );
        f:=arctan(y0/x0);
        a:=pi-f+b;
        x1:=round(x + l*cos(a));
        y1:=round(y - l*sin(a));
        form1.Image1.Canvas.MoveTo(x1,y1);
        x0:=dlina*9/10;
        y0:=-shirina/2;
        l:=sqrt(  x0*x0 + y0*y0 );
        f:=arctan(y0/x0);
        a:=pi-f+b;
        x2:=round(x + l*cos(a));
        y2:=round(y - l*sin(a));
        form1.Image1.Canvas.LineTo(x2,y2);
        //TU
        x0:=dlina*6/10;
        y0:=shirina/2;
        l:=sqrt(  x0*x0 + y0*y0 );
        f:=arctan(y0/x0);
        a:=pi-f+b;
        x1:=round(x + l*cos(a));
        y1:=round(y - l*sin(a));
        form1.Image1.Canvas.MoveTo(x1,y1);
        x0:=dlina*6/10;
        y0:=shirina/6;
        l:=sqrt(  x0*x0 + y0*y0 );
        f:=arctan(y0/x0);
        a:=pi-f+b;
        x2:=round(x + l*cos(a));
        y2:=round(y - l*sin(a));
        form1.Image1.Canvas.LineTo(x2,y2);
        //VW
        x0:=dlina*6/10;
        y0:=-shirina/2;
        l:=sqrt(  x0*x0 + y0*y0 );
        f:=arctan(y0/x0);
        a:=pi-f+b;
        x1:=round(x + l*cos(a));
        y1:=round(y - l*sin(a));
        form1.Image1.Canvas.MoveTo(x1,y1);
        x0:=dlina*6/10;
        y0:=-shirina/6;
        l:=sqrt(  x0*x0 + y0*y0 );
        f:=arctan(y0/x0);
        a:=pi-f+b;
        x2:=round(x + l*cos(a));
        y2:=round(y - l*sin(a));
        form1.Image1.Canvas.LineTo(x2,y2);
        //ZB1
        x0:=dlina*9/10;
        y0:=shirina/3;
        l:=sqrt(  x0*x0 + y0*y0 );
        f:=arctan(y0/x0);
        a:=pi-f+b;
        x1:=round(x + l*cos(a));
        y1:=round(y - l*sin(a));
        form1.Image1.Canvas.MoveTo(x1,y1);
        x0:=dlina*10/10;
        y0:=shirina/6;
        l:=sqrt(  x0*x0 + y0*y0 );
        f:=arctan(y0/x0);
        a:=pi-f+b;
        x2:=round(x + l*cos(a));
        y2:=round(y - l*sin(a));
        form1.Image1.Canvas.LineTo(x2,y2);
        //A1C1
        x0:=dlina*9/10;
        y0:=-shirina/3;
        l:=sqrt(  x0*x0 + y0*y0 );
        f:=arctan(y0/x0);
        a:=pi-f+b;
        x1:=round(x + l*cos(a));
        y1:=round(y - l*sin(a));
        form1.Image1.Canvas.MoveTo(x1,y1);
        x0:=dlina*10/10;
        y0:=-shirina/6;
        l:=sqrt(  x0*x0 + y0*y0 );
        f:=arctan(y0/x0);
        a:=pi-f+b;
        x2:=round(x + l*cos(a));
        y2:=round(y - l*sin(a));
        form1.Image1.Canvas.LineTo(x2,y2);
        //JK
        x0:=dlina*1/20;
        y0:=+shirina/6;
        l:=sqrt(  x0*x0 + y0*y0 );
        f:=arctan(y0/x0);
        a:=pi-f+b;
        x1:=round(x + l*cos(a));
        y1:=round(y - l*sin(a));
        form1.Image1.Canvas.MoveTo(x1,y1);
        x0:=dlina*1/10;
        y0:=shirina/6;
        l:=sqrt(  x0*x0 + y0*y0 );
        f:=arctan(y0/x0);
        a:=pi-f+b;
        x2:=round(x + l*cos(a));
        y2:=round(y - l*sin(a));
        form1.Image1.Canvas.LineTo(x2,y2);
        //KL
        x0:=dlina*2/10;
        y0:=+shirina/3;
        l:=sqrt(  x0*x0 + y0*y0 );
        f:=arctan(y0/x0);
        a:=pi-f+b;
        x2:=round(x + l*cos(a));
        y2:=round(y - l*sin(a));
        form1.Image1.Canvas.LineTo(x2,y2);
        //LC
        x0:=dlina*2/10;
        y0:=+shirina/2;
        l:=sqrt(  x0*x0 + y0*y0 );
        f:=arctan(y0/x0);
        a:=pi-f+b;
        x2:=round(x + l*cos(a));
        y2:=round(y - l*sin(a));
        form1.Image1.Canvas.LineTo(x2,y2);
        //LB
        x0:=dlina*2/10;
        y0:=+shirina/3;
        l:=sqrt(  x0*x0 + y0*y0 );
        f:=arctan(y0/x0);
        a:=pi-f+b;
        x1:=round(x + l*cos(a));
        y1:=round(y - l*sin(a));
        form1.Image1.Canvas.MoveTo(x1,y1);
        x0:=dlina*1/10;
        y0:=+shirina/3;
        l:=sqrt(  x0*x0 + y0*y0 );
        f:=arctan(y0/x0);
        a:=pi-f+b;
        x2:=round(x + l*cos(a));
        y2:=round(y - l*sin(a));
        form1.Image1.Canvas.LineTo(x2,y2);
        //MN
        x0:=dlina*1/20;
        y0:=-shirina/6;
        l:=sqrt(  x0*x0 + y0*y0 );
        f:=arctan(y0/x0);
        a:=pi-f+b;
        x1:=round(x + l*cos(a));
        y1:=round(y - l*sin(a));
        form1.Image1.Canvas.MoveTo(x1,y1);
        x0:=dlina*1/10;
        y0:=-shirina/6;
        l:=sqrt(  x0*x0 + y0*y0 );
        f:=arctan(y0/x0);
        a:=pi-f+b;
        x2:=round(x + l*cos(a));
        y2:=round(y - l*sin(a));
        form1.Image1.Canvas.LineTo(x2,y2);
        //NO
        x0:=dlina*2/10;
        y0:=-shirina/3;
        l:=sqrt(  x0*x0 + y0*y0 );
        f:=arctan(y0/x0);
        a:=pi-f+b;
        x2:=round(x + l*cos(a));
        y2:=round(y - l*sin(a));
        form1.Image1.Canvas.LineTo(x2,y2);
        //OH
        x0:=dlina*2/10;
        y0:=-shirina/2;
        l:=sqrt(  x0*x0 + y0*y0 );
        f:=arctan(y0/x0);
        a:=pi-f+b;
        x2:=round(x + l*cos(a));
        y2:=round(y - l*sin(a));
        form1.Image1.Canvas.LineTo(x2,y2);
        //OI
        x0:=dlina*2/10;
        y0:=-shirina/3;
        l:=sqrt(  x0*x0 + y0*y0 );
        f:=arctan(y0/x0);
        a:=pi-f+b;
        x2:=round(x + l*cos(a));
        y2:=round(y - l*sin(a));
        form1.Image1.Canvas.MoveTo(x2,y2);
        x0:=dlina*1/10;
        y0:=-shirina/3;
        l:=sqrt(  x0*x0 + y0*y0 );
        f:=arctan(y0/x0);
        a:=pi-f+b;
        x2:=round(x + l*cos(a));
        y2:=round(y - l*sin(a));
        form1.Image1.Canvas.LineTo(x2,y2);
       end;
end;

procedure auto.dvizenie(timer1:Ttimer);
 var
  ikletki,jkletki,k:integer;
  i_v_kletke,j_v_kletke,R,a,f:real;
begin
 ikletki:=round(i * d) div d + 1;
 jkletki:=round(j * d) div d + 1;
 if(ikletki-1>i)
  then begin
        ikletki:=ikletki-1;
       end;
 if(jkletki-1>j)
  then begin
        jkletki:=jkletki-1;
       end;
 if(ikletki>sh)
  then begin
        ikletki:=ikletki-1;
       end;
 if(jkletki>dl)
  then begin
        jkletki:=jkletki-1;
       end;
 k:=1;
 while((puti[k].I<>ikletki) or (puti[k].j<>jkletki))
  do begin
      k:=k+1;
     end;
 if((puti[k].Vid=11) or (puti[k].Vid=12))
  then begin
        if(n=1)
         then begin
               if(ikletki-i>speed/d*Timer1.Interval/1000)
                then begin
                      i:=i+timer1.Interval*speed/d/1000;
                     end
               else  begin
                      i:=ikletki+1.5/d;
                     end;
              end;
        if(n=-1)
         then begin
               if(i-ikletki+1>speed/d*form1.Timer1.Interval/1000)
                then begin
                      i:=i-timer1.Interval*speed/d/1000;
                     end
               else  begin
                      i:=ikletki-1-1.5/d;
                     end;
              end;
        if(n=2)
         then begin
               if(jkletki-j>speed/d*form1.Timer1.Interval/1000)
                then begin
                      j:=j+timer1.Interval*speed/d/1000;
                     end
               else  begin
                      j:=jkletki+1.5/d;
                     end;
              end;
        if(n=-2)
         then begin
               if(j-jkletki+1>speed/d*form1.Timer1.Interval/1000)
                then begin
                      j:=j-timer1.Interval*speed/d/1000;
                     end
               else  begin
                      j:=jkletki-1-1.5/d;
                     end;
              end;
       end;
 if((puti[k].Vid>20) or (puti[k].Vid=3))
  then begin
        i_v_kletke:=i-ikletki+1;
        j_v_kletke:=j-jkletki+1;
        if(n=1)
         then begin
               if(tp=-2)
                then begin
                      if(np=1)
                       then begin
                             if(5/12-i_v_kletke>j_v_kletke+0.001)
                              then begin
                                    if(5/12-i_v_kletke-j_v_kletke>speed*timer1.Interval/d/1000)
                                     then begin
                                           i:=i+timer1.Interval*speed/d/1000;
                                          end;
                                    if(5/12-i_v_kletke-j_v_kletke<=speed*timer1.Interval/d/1000)
                                     then begin
                                           i:=ikletki-1+4/12;
                                          end;
                                   end
                             else
                              begin
                               R:=1/12;
                               f:=timer1.Interval*speed/1000/(R*d);
                               if(b-f>pi)
                                then begin
                                      b:=b-f;
                                      a:=pi - (b-pi/2);
                                      i:=ikletki-1+4/12 + sin(a)*R;
                                      j:=jkletki-1 + cos(a)*R;
                                     end
                               else
                                begin
                                 b:=pi;
                                 i:=ikletki-1+5/12;
                                 j:=jkletki-1-2/d;
                                 n:=tp;
                                 tp:=np;
                                 np:=0;
                                end;
                              end;
                            end;
                      if(np=-2)
                       then begin
                             if(3/12-i_v_kletke>j_v_kletke+0.001)
                              then begin
                                    if(3/12-i_v_kletke-j_v_kletke>speed*timer1.Interval/d/1000)
                                     then begin
                                           i:=i+timer1.Interval*speed/d/1000;
                                          end;
                                    if(3/12-i_v_kletke-j_v_kletke<=speed*timer1.Interval/d/1000)
                                     then begin
                                           i:=ikletki-1+2/12;
                                          end;
                                   end
                             else
                              begin
                               R:=1/12;
                               f:=timer1.Interval*speed/1000/(d*R);
                               if(b-f>pi)
                                then begin
                                      b:=b-f;
                                      a:=pi - (b-pi/2);
                                      i:=ikletki-1+2/12 + sin(a)*R;
                                      j:=jkletki-1 + cos(a)*R;
                                     end
                               else
                                begin
                                 b:=pi;
                                 i:=ikletki-1+3/12;
                                 j:=jkletki-1-2/d;
                                 n:=tp;
                                 tp:=np;
                                 np:=0;
                                end;
                              end;
                            end;
                      if(np=-1)
                       then begin
                             R:=1/12;
                             f:=timer1.Interval*speed/1000/(d*R);
                             if(b-f>pi)
                              then begin
                                    b:=b-f;
                                    a:=pi - (b-pi/2);
                                    i:=ikletki-1 + sin(a)*R;
                                    j:=jkletki-1 + cos(a)*R;
                                   end
                             else
                              begin
                               b:=pi;
                               i:=ikletki-1+1/12;
                               j:=jkletki-1-2/d;
                               n:=tp;
                               tp:=np;
                               np:=0;
                              end;
                            end;
                      if(np=3)
                       then begin
                             while((np<>-2) and (np<>1) and (np<>-1))
                              do begin
                                  np:=random(2+2+1)-2;
                                 end;
                            end;
                     end;
               if(tp=2)
                then begin
                      if(np=1)
                       then begin
                             if(11/12-i_v_kletke>1-j_v_kletke+0.001)
                              then begin
                                    if(11/12-i_v_kletke-1+j_v_kletke>speed*timer1.Interval/d/1000)
                                     then begin
                                           i:=i+timer1.Interval*speed/d/1000;
                                          end;
                                    if(11/12-i_v_kletke-1+j_v_kletke<=speed*timer1.Interval/d/1000)
                                     then begin
                                           i:=ikletki-1+4/12;
                                          end;
                                   end
                             else
                              begin
                               R:=7/12;
                               f:=timer1.Interval*speed/1000/(d*R);
                               if(b+f<2*pi)
                                then begin
                                      b:=b+f;
                                      a:=(b-3*pi/2);
                                      i:=ikletki-1+4/12 + sin(a)*R;
                                      j:=jkletki - cos(a)*R - 1/24;
                                     end
                               else
                                begin
                                 b:=0;
                                 i:=ikletki-1+11/12;
                                 j:=jkletki+2/d;
                                 n:=tp;
                                 tp:=np;
                                 np:=0;
                                end;
                              end;
                            end;
                      if(np=2)
                       then begin
                             if(9/12-i_v_kletke>1-j_v_kletke+0.001)
                              then begin
                                    if(9/12-i_v_kletke-1+j_v_kletke>speed*timer1.Interval/d/1000)
                                     then begin
                                           i:=i+timer1.Interval*speed/d/1000;
                                          end;
                                    if(9/12-i_v_kletke-1+j_v_kletke<=speed*timer1.Interval/d/1000)
                                     then begin
                                           i:=ikletki-1+2/12;
                                          end;
                                   end
                             else
                              begin
                               R:=7/12;
                               f:=timer1.Interval*speed/1000/(R*d);
                               if(b+f<2*pi)
                                then begin
                                      b:=b+f;
                                      a:=(b-3*pi/2);
                                      i:=ikletki-1+2/12 + sin(a)*R;
                                      j:=jkletki - cos(a)*R - 1/24;
                                     end
                               else
                                begin
                                 b:=0;
                                 i:=ikletki-1+9/12;
                                 j:=jkletki+2/d;
                                 n:=tp;
                                 tp:=np;
                                 np:=0;
                                end;
                              end;
                            end;
                      if(np=-1)
                       then begin
                             R:=7/12;
                             f:=timer1.Interval*speed/1000/(R*d);
                             if(b+f<2*pi)
                              then begin
                                    b:=b+f;
                                    a:=(b-3*pi/2);
                                    i:=ikletki-1 + sin(a)*R;
                                    j:=jkletki - cos(a)*R - 1/24;
                                   end
                             else
                              begin
                               b:=0;
                               i:=ikletki-1+7/12;
                               j:=jkletki+2/d;
                               n:=tp;
                               tp:=np;
                               np:=0;
                              end;
                            end;
                      if(np=3)
                       then begin
                             while((np<>2) and (np<>1) and (np<>-1))
                              do begin
                                  np:=random(2+2+1)-2;
                                 end;
                            end;
                     end;
               if(tp=1)
                then begin
                      if(np=1)
                       then begin
                             if(i_v_kletke+speed*timer1.Interval/1000/d<1)
                              then begin
                                    i:=i+speed*timer1.Interval/1000/d;
                                   end
                             else
                              begin
                               i:=ikletki+2/d;
                               n:=tp;
                               tp:=np;
                               np:=0;
                              end;
                            end;
                      if(np=2)
                       then begin
                             if(i_v_kletke+speed*timer1.Interval/1000/d<1)
                              then begin
                                    i:=i+speed*timer1.Interval/1000/d;
                                   end
                             else
                              begin
                               i:=ikletki+2/d;
                               n:=tp;
                               tp:=np;
                               np:=0;
                              end;
                             if(i_v_kletke>=6/12)
                              then begin
                                    if(j_v_kletke+speed*timer1.Interval/d/3000<5/12)
                                     then begin
                                           j:=j+speed*timer1.Interval/d/3000;
                                          end
                                    else
                                     begin
                                      j:=jkletki-1+5/12;
                                     end;
                                   end;
                            end;
                      if(np=-2)
                       then begin
                             if(i_v_kletke+speed*timer1.Interval/1000/d<1)
                              then begin
                                    i:=i+speed*timer1.Interval/1000/d;
                                   end
                             else
                              begin
                               i:=ikletki+2/d;
                               n:=tp;
                               tp:=np;
                               np:=0;
                              end;
                             if(i_v_kletke>=6/12)
                              then begin
                                    if(j_v_kletke-speed*timer1.Interval/d/3000>1/12)
                                     then begin
                                           j:=j-speed*timer1.Interval/d/3000;
                                          end
                                    else
                                     begin
                                      j:=jkletki-1+1/12;
                                     end;
                                   end;
                            end;
                      if(np=3)
                       then begin
                             while((np<>2) and (np<>1) and (np<>-2))
                              do begin
                                  np:=random(2+2+1)-2;
                                 end;
                            end;
                     end;
              end;
        if(n=2)
         then begin
               if(tp=1)
                then begin
                      if(np=2)
                       then begin
                             if(5/12-j_v_kletke>1-i_v_kletke+0.001)
                              then begin
                                    if(5/12-j_v_kletke-1+i_v_kletke>speed*timer1.Interval/d/1000)
                                     then begin
                                           j:=j+timer1.Interval*speed/d/1000;
                                          end;
                                    if(5/12-j_v_kletke-1+i_v_kletke<=speed*timer1.Interval/d/1000)
                                     then begin
                                           j:=jkletki-1+4/12;
                                           b:=2*pi;
                                          end;
                                   end
                             else
                              begin
                               R:=1/12;
                               f:=timer1.Interval*speed/1000/(R*d);
                               if(b-f>3*pi/2)
                                then begin
                                      b:=b-f;
                                      a:=(b-3*pi/2);
                                      i:=ikletki - sin(a)*R-1/120;
                                      j:=jkletki-1+4/12 + cos(a)*R;
                                     end
                               else
                                begin
                                 b:=3*pi/2;
                                 i:=ikletki+2/d;
                                 j:=jkletki-1+5/12;
                                 n:=tp;
                                 tp:=np;
                                 np:=0;
                                end;
                              end;
                            end;
                      if(np=1)
                       then begin
                             if(3/12-j_v_kletke>1-i_v_kletke+0.001)
                              then begin
                                    if(3/12-j_v_kletke-1+i_v_kletke>speed*timer1.Interval/d/1000)
                                     then begin
                                           j:=j+timer1.Interval*speed/d/1000;
                                          end;
                                    if(3/12-j_v_kletke-1+i_v_kletke<=speed*timer1.Interval/d/1000)
                                     then begin
                                           j:=jkletki-1+2/12;
                                           b:=2*pi;
                                          end;
                                   end
                             else
                              begin
                               R:=1/12;
                               f:=timer1.Interval*speed/1000/(d*R);
                               if(b-f>3*pi/2)
                                then begin
                                      b:=b-f;
                                      a:=(b-3*pi/2);
                                      i:=ikletki-sin(a)*R - 2/d;
                                      j:=jkletki-1 + 2/12 + cos(a)*R;
                                     end
                               else
                                begin
                                 b:=3*pi/2;
                                 i:=ikletki + 2/d;
                                 j:=jkletki-1 + 3/12;
                                 n:=tp;
                                 tp:=np;
                                 np:=0;
                                end;
                              end;
                            end;
                      if(np=-2)
                       then begin
                             if(b=0)
                              then begin
                                    b:=2*pi;
                                   end;
                             R:=1/12;
                             f:=timer1.Interval*speed/1000/(d*R);
                             if(b-f>3*pi/2)
                              then begin
                                    b:=b-f;
                                    a:=(b-3*pi/2);
                                    i:=ikletki - sin(a)*R-2/d;
                                    j:=jkletki-1 + cos(a)*R;
                                   end
                             else
                              begin
                               b:=3*pi/2;
                               i:=ikletki+2/d;
                               j:=jkletki-1 + 1/12;
                               n:=tp;
                               tp:=np;
                               np:=0;
                              end;
                            end;
                      if(np=3)
                       then begin
                             while((np<>-2) and (np<>1) and (np<>2))
                              do begin
                                  np:=random(2+2+1)-2;
                                 end;
                            end;
                     end;
               if(tp=-1)
                then begin
                      if(np=2)
                       then begin
                             if(11/12-j_v_kletke>i_v_kletke+0.001)
                              then begin
                                    if(11/12-j_v_kletke-i_v_kletke>speed*timer1.Interval/d/1000)
                                     then begin
                                           j:=j+timer1.Interval*speed/d/1000;
                                          end;
                                    if(11/12-j_v_kletke-i_v_kletke<=speed*timer1.Interval/d/1000)
                                     then begin
                                           j:=jkletki-1+4/12;
                                          end;
                                   end
                             else
                              begin
                               R:=7/12;
                               f:=timer1.Interval*speed/1000/(d*R);
                               if(b+f<pi/2)
                                then begin
                                      b:=b+f;
                                      a:=(pi/2-b);
                                      i:=ikletki-1+ sin(a)*R;
                                      j:=jkletki-1+4/12 + cos(a)*R;
                                     end
                               else
                                begin
                                 b:=pi/2;
                                 j:=jkletki-1+11/12;
                                 i:=ikletki-1-2/d;
                                 n:=tp;
                                 tp:=np;
                                 np:=0;
                                end;
                              end;
                            end;
                      if(np=-1)
                       then begin
                             if(9/12-j_v_kletke>i_v_kletke+0.001)
                              then begin
                                    if(9/12-j_v_kletke-i_v_kletke>speed*timer1.Interval/d/1000)
                                     then begin
                                           j:=j+timer1.Interval*speed/d/1000;
                                          end;
                                    if(9/12-j_v_kletke-i_v_kletke<=speed*timer1.Interval/d/1000)
                                     then begin
                                           j:=jkletki-1+2/12;
                                          end;
                                   end
                             else
                              begin
                               R:=7/12;
                               f:=timer1.Interval*speed/1000/(R*d);
                               if(b+f<pi/2)
                                then begin
                                      b:=b+f;
                                      a:=(pi/2-b);
                                      i:=ikletki-1+ sin(a)*R;
                                      j:=jkletki-1+2/12 + cos(a)*R;
                                     end
                               else
                                begin
                                 b:=pi/2;
                                 j:=jkletki-1+9/12;
                                 i:=ikletki-1-2/d;
                                 n:=tp;
                                 tp:=np;
                                 np:=0;
                                end;
                              end;
                            end;
                      if(np=-2)
                       then begin
                             R:=7/12;
                             f:=timer1.Interval*speed/1000/(R*d);
                             if(b+f<pi/2)
                              then begin
                                    b:=b+f;
                                    a:=(pi/2-b);
                                    i:=ikletki-1+ sin(a)*R;
                                    j:=jkletki-1 + cos(a)*R;
                                   end
                             else
                              begin
                               b:=pi/2;
                               j:=jkletki-1+7/12;
                               i:=ikletki-1-2/d;
                               n:=tp;
                               tp:=np;
                               np:=0;
                              end;
                            end;
                      if(np=3)
                       then begin
                             while((np<>2) and (np<>-2) and (np<>-1))
                              do begin
                                  np:=random(2+2+1)-2;
                                 end;
                            end;
                     end;
               if(tp=2)
                then begin
                      if(np=2)
                       then begin
                             if(j_v_kletke+speed*timer1.Interval/1000/d<1)
                              then begin
                                    j:=j+speed*timer1.Interval/1000/d;
                                   end
                             else
                              begin
                               j:=jkletki+2/d;
                               n:=tp;
                               tp:=np;
                               np:=0;
                              end;
                            end;
                      if(np=1)
                       then begin
                             if(j_v_kletke+speed*timer1.Interval/1000/d<1)
                              then begin
                                    j:=j+speed*timer1.Interval/1000/d;
                                   end
                             else
                              begin
                               j:=jkletki+2/d;
                               n:=tp;
                               tp:=np;
                               np:=0;
                              end;
                             if(j_v_kletke>=6/12)
                              then begin
                                    if(i_v_kletke+speed*timer1.Interval/d/3000<11/12)
                                     then begin
                                           i:=i+speed*timer1.Interval/d/3000;
                                          end
                                    else
                                     begin
                                      i:=ikletki-1+11/12;
                                     end;
                                   end;
                            end;
                      if(np=-1)
                       then begin
                             if(j_v_kletke+speed*timer1.Interval/1000/d<1)
                              then begin
                                    j:=j+speed*timer1.Interval/1000/d;
                                   end
                             else
                              begin
                               j:=jkletki+2/d;
                               n:=tp;
                               tp:=np;
                               np:=0;
                              end;
                             if(j_v_kletke>=6/12)
                              then begin
                                    if(i_v_kletke-speed*timer1.Interval/d/3000>7/12)
                                     then begin
                                           i:=i-speed*timer1.Interval/d/3000;
                                          end
                                    else
                                     begin
                                      i:=ikletki-1+7/12;
                                     end;
                                   end;
                            end;
                      if(np=3)
                       then begin
                             while((np<>2) and (np<>1) and (np<>-1))
                              do begin
                                  np:=random(2+2+1)-2;
                                 end;
                            end;

                     end;
              end;
        if(n=-1)
         then begin
               if(tp=2)
                then begin
                      if(np=-1)
                       then begin
                             if(5/12-1+i_v_kletke>1-j_v_kletke+0.001)
                              then begin
                                    if(5/12-1+i_v_kletke-1+j_v_kletke>speed*timer1.Interval/d/1000)
                                     then begin
                                           i:=i-timer1.Interval*speed/d/1000;
                                          end;
                                    if(5/12-1+i_v_kletke-1+j_v_kletke<=speed*timer1.Interval/d/1000)
                                     then begin
                                           i:=ikletki-1+8/12;
                                          end;
                                   end
                             else
                              begin
                               R:=1/12;
                               f:=timer1.Interval*speed/1000/(R*d);
                               if(b-f>0)
                                then begin
                                      b:=b-f;
                                      a:=(pi/2-b);
                                      i:=ikletki-1+8/12 - sin(a)*R;
                                      j:=jkletki - cos(a)*R-2/d;
                                     end
                               else
                                begin
                                 b:=0;
                                 i:=ikletki-1+7/12;
                                 j:=jkletki+2/d;
                                 n:=tp;
                                 tp:=np;
                                 np:=0;
                                end;
                              end;
                            end;
                      if(np=2)
                       then begin
                             if(i_v_kletke-9/12>1-j_v_kletke+0.001)
                              then begin
                                    if(i_v_kletke-9/12-1+j_v_kletke>speed*timer1.Interval/d/1000)
                                     then begin
                                           i:=i-timer1.Interval*speed/d/1000;
                                          end;
                                    if(i_v_kletke-9/12-1+j_v_kletke<=speed*timer1.Interval/d/1000)
                                     then begin
                                           i:=ikletki-1+10/12;
                                          end;
                                   end
                             else
                              begin
                               R:=1/12;
                               f:=timer1.Interval*speed/1000/(d*R);
                               if(b-f>0)
                                then begin
                                      b:=b-f;
                                      a:=(pi/2-b);
                                      i:=ikletki-1-sin(a)*R + 10/12;
                                      j:=jkletki-cos(a)*R-2/d;
                                     end
                               else
                                begin
                                 b:=0;
                                 i:=ikletki-1 + 9/12;
                                 j:=jkletki + 2/d;
                                 n:=tp;
                                 tp:=np;
                                 np:=0;
                                end;
                              end;
                            end;
                      if(np=1)
                       then begin
                             R:=1/12;
                             f:=timer1.Interval*speed/1000/(d*R);
                             if(b-f>0)
                              then begin
                                    b:=b-f;
                                    a:=(pi/2-b);
                                    i:=ikletki - sin(a)*R-2/d;
                                    j:=jkletki - cos(a)*R;
                                   end
                             else
                              begin
                               b:=0;
                               i:=ikletki-1 + 11/12;
                               j:=jkletki + 2/d;
                               n:=tp;
                               tp:=np;
                               np:=0;
                              end;
                            end;
                      if(np=3)
                       then begin
                             while((np<>-1) and (np<>1) and (np<>2))
                              do begin
                                  np:=random(2+2+1)-2;
                                 end;
                            end;
                     end;
               if(tp=-2)
                then begin
                      if(np=-1)
                       then begin
                             if(i_v_kletke>8/12+0.001)
                              then begin
                                    if(i_v_kletke-8/12>speed*timer1.Interval/d/1000)
                                     then begin
                                           i:=i-timer1.Interval*speed/d/1000;
                                          end;
                                    if(i_v_kletke-8/12<=speed*timer1.Interval/d/1000)
                                     then begin
                                           i:=ikletki-1+8/12;
                                          end;
                                   end
                             else
                              begin
                               R:=7/12;
                               f:=timer1.Interval*speed/1000/(d*R);
                               if(b+f<pi)
                                then begin
                                      b:=b+f;
                                      a:=(b-pi/2);
                                      i:=ikletki-1 + 8/12 - sin(a)*R;
                                      j:=jkletki-1 + cos(a)*R;
                                     end
                               else
                                begin
                                 b:=pi;
                                 j:=jkletki-1 - 2/d;
                                 i:=ikletki-1 + 1/12;
                                 n:=tp;
                                 tp:=np;
                                 np:=0;
                                end;
                              end;
                            end;
                      if(np=-2)
                       then begin
                             if(i_v_kletke>10/12+0.001)
                              then begin
                                    if(i_v_kletke-10/12>speed*timer1.Interval/d/1000)
                                     then begin
                                           i:=i-timer1.Interval*speed/d/1000;
                                          end;
                                    if(i_v_kletke-10/12<=speed*timer1.Interval/d/1000)
                                     then begin
                                           i:=ikletki-1+10/12;
                                          end;
                                   end
                             else
                              begin
                               R:=7/12;
                               f:=timer1.Interval*speed/1000/(R*d);
                               if(b+f<pi)
                                then begin
                                      b:=b+f;
                                      a:=(b-pi/2);
                                      i:=ikletki-1+ 10/12 - sin(a)*R;
                                      j:=jkletki-1 + cos(a)*R;
                                     end
                               else
                                begin
                                 b:=pi;
                                 j:=jkletki-1 - 2/d;
                                 i:=ikletki-1 + 3/12;
                                 n:=tp;
                                 tp:=np;
                                 np:=0;
                                end;
                              end;
                            end;
                      if(np=1)
                       then begin
                             R:=7/12;
                             f:=timer1.Interval*speed/1000/(R*d);
                             if(b+f<pi)
                              then begin
                                    b:=b+f;
                                    a:=(b-pi/2);
                                    i:=ikletki - sin(a)*R;
                                    j:=jkletki-1 + cos(a)*R;
                                   end
                             else
                              begin
                               b:=pi;
                               j:=jkletki-1 - 2/d;
                               i:=ikletki-1 + 5/12;
                               n:=tp;
                               tp:=np;
                               np:=0;
                              end;
                            end;
                      if(np=3)
                       then begin
                             while((np<>1) and (np<>-2) and (np<>-1))
                              do begin
                                  np:=random(2+2+1)-2;
                                 end;
                            end;
                     end;
               if(tp=-1)
                then begin
                      if(np=-1)
                       then begin
                             if(i_v_kletke-speed*timer1.Interval/1000/d>0.001)
                              then begin
                                    i:=i-speed*timer1.Interval/1000/d;
                                   end
                             else
                              begin
                               i:=ikletki-1-2/d;
                               n:=tp;
                               tp:=np;
                               np:=0;
                              end;
                            end;
                      if(np=2)
                       then begin
                             if(i_v_kletke-speed*timer1.Interval/1000/d>0.001)
                              then begin
                                    i:=i-speed*timer1.Interval/1000/d;
                                   end
                             else
                              begin
                               i:=ikletki-1-2/d;
                               n:=tp;
                               tp:=np;
                               np:=0;
                              end;
                             if(i_v_kletke<=6/12)
                              then begin
                                    if(j_v_kletke+speed*timer1.Interval/d/3000<11/12)
                                     then begin
                                           j:=j+speed*timer1.Interval/d/3000;
                                          end
                                    else
                                     begin
                                      j:=jkletki-1+11/12;
                                     end;
                                   end;
                            end;
                      if(np=-2)
                       then begin
                             if(i_v_kletke-speed*timer1.Interval/1000/d>0.001)
                              then begin
                                    i:=i-speed*timer1.Interval/1000/d;
                                   end
                             else
                              begin
                               i:=ikletki-1-2/d;
                               n:=tp;
                               tp:=np;
                               np:=0;
                              end;
                             if(i_v_kletke<=6/12)
                              then begin
                                    if(j_v_kletke-speed*timer1.Interval/d/3000>7/12)
                                     then begin
                                           j:=j-speed*timer1.Interval/d/3000;
                                          end
                                    else
                                     begin
                                      j:=jkletki-1+7/12;
                                     end;
                                   end;
                            end;
                      if(np=3)
                       then begin
                             while((np<>-2) and (np<>2) and (np<>-1))
                              do begin
                                  np:=random(2+2+1)-2;
                                 end;
                            end;
                     end;
              end;
        if(n=-2)
         then begin
               if(tp=-1)
                then begin
                      if(np=-2)
                       then begin
                             if(j_v_kletke>8/12+0.001)
                              then begin
                                    if(j_v_kletke-8/12>speed*timer1.Interval/d/1000)
                                     then begin
                                           j:=j-timer1.Interval*speed/d/1000;
                                          end;
                                    if(j_v_kletke-8/12<=speed*timer1.Interval/d/1000)
                                     then begin
                                           j:=jkletki-1+8/12;
                                          end;
                                   end
                             else
                              begin
                               R:=1/12;
                               f:=timer1.Interval*speed/1000/(R*d);
                               if(b-f>pi/2)
                                then begin
                                      b:=b-f;
                                      a:=(b-pi/2);
                                      i:=ikletki-1 + sin(a)*R;
                                      j:=jkletki-1 + 8/12 - cos(a)*R-2/d;
                                     end
                               else
                                begin
                                 b:=pi/2;
                                 j:=jkletki-1+7/12;
                                 i:=ikletki-1-2/d;
                                 n:=tp;
                                 tp:=np;
                                 np:=0;
                                end;
                              end;
                            end;
                      if(np=-1)
                       then begin
                             if(j_v_kletke>10/12-0.001)
                              then begin
                                    if(j_v_kletke-10/12>speed*timer1.Interval/d/1000)
                                     then begin
                                           j:=j-timer1.Interval*speed/d/1000;
                                          end;
                                    if(j_v_kletke-10/12<=speed*timer1.Interval/d/1000)
                                     then begin
                                           j:=jkletki-1+10/12-2/d;
                                          end;
                                   end
                             else
                              begin
                               R:=1/12;
                               f:=timer1.Interval*speed/1000/(d*R);
                               if(b-f>pi/2)
                                then begin
                                      b:=b-f;
                                      a:=(b-pi/2);
                                      i:=ikletki-1+sin(a)*R ;
                                      j:=jkletki-1+10/12-cos(a)*R+2/d;
                                     end
                               else
                                begin
                                 b:=pi/2;
                                 i:=ikletki-1 - 2/d;
                                 j:=jkletki-1 + 9/12;
                                 n:=tp;
                                 tp:=np;
                                 np:=0;
                                end;
                              end;
                            end;
                      if(np=2)
                       then begin
                             R:=1/12;
                             f:=timer1.Interval*speed/1000/(d*R);
                             if(b-f>pi/2)
                              then begin
                                    b:=b-f;
                                    a:=(b-pi/2);
                                    j:=jkletki - cos(a)*R-2/d;
                                    i:=ikletki-1 + sin(a)*R;
                                   end
                             else
                              begin
                               b:=pi/2;
                               i:=ikletki-1 -2/d;
                               j:=jkletki-1 + 11/12;
                               n:=tp;
                               tp:=np;
                               np:=0;
                              end;
                            end;
                      if(np=3)
                       then begin
                             while((np<>-1) and (np<>-2) and (np<>2))
                              do begin
                                  np:=random(2+2+1)-2;
                                 end;
                            end;
                     end;
               if(tp=1)
                then begin
                      if(np=-2)
                       then begin
                             if(j_v_kletke>8/12+0.001)
                              then begin
                                    if(j_v_kletke-8/12>speed*timer1.Interval/d/1000)
                                     then begin
                                           j:=j-timer1.Interval*speed/d/1000;
                                          end;
                                    if(j_v_kletke-8/12<=speed*timer1.Interval/d/1000)
                                     then begin
                                           j:=jkletki-1+8/12;
                                          end;
                                   end
                             else
                              begin
                               R:=7/12;
                               f:=timer1.Interval*speed/1000/(d*R);
                               if(b+f<pi*3/2)
                                then begin
                                      b:=b+f;
                                      a:=(pi*3/2-b);
                                      i:=ikletki - sin(a)*R-2/d;
                                      j:=jkletki-1 + 8/12 - cos(a)*R;
                                     end
                               else
                                begin
                                 b:=3*pi/2;
                                 j:=jkletki-1 + 1/12;
                                 i:=ikletki + 2/d;
                                 n:=tp;
                                 tp:=np;
                                 np:=0;
                                end;
                              end;
                            end;
                      if(np=1)
                       then begin
                             if(j_v_kletke>10/12+0.001)
                              then begin
                                    if(j_v_kletke-10/12>speed*timer1.Interval/d/1000)
                                     then begin
                                           j:=j-timer1.Interval*speed/d/1000;
                                          end;
                                    if(j_v_kletke-10/12<=speed*timer1.Interval/d/1000)
                                     then begin
                                           j:=jkletki-1+10/12;
                                          end;
                                   end
                             else
                              begin
                               R:=7/12;
                               f:=timer1.Interval*speed/1000/(R*d);
                               if(b+f<3*pi/2)
                                then begin
                                      b:=b+f;
                                      a:=(3*pi/2-b);
                                      i:=ikletki - sin(a)*R;
                                      j:=jkletki-1 + 10/12 - cos(a)*R;
                                     end
                               else
                                begin
                                 b:=3*pi/2;
                                 j:=jkletki-1 + 3/12;
                                 i:=ikletki+2/d;
                                 n:=tp;
                                 tp:=np;
                                 np:=0;
                                end;
                              end;
                            end;
                      if(np=2)
                       then begin
                             R:=7/12;
                             f:=timer1.Interval*speed/1000/(R*d);
                             if(b+f<3*pi/2)
                              then begin
                                    b:=b+f;
                                    a:=(3*pi/2-b);
                                    i:=ikletki - sin(a)*R;
                                    j:=jkletki - cos(a)*R;
                                   end
                             else
                              begin
                               b:=3*pi/2;
                               j:=jkletki-1 + 5/12;
                               i:=ikletki + 2/d;
                               n:=tp;
                               tp:=np;
                               np:=0;
                              end;
                            end;
                      if(np=3)
                       then begin
                             while((np<>1) and (np<>-2) and (np<>2))
                              do begin
                                  np:=random(2+2+1)-2;
                                 end;
                            end;
                     end;
               if(tp=-2)
                then begin
                      if(np=-2)
                       then begin
                             if(j_v_kletke-speed*timer1.Interval/1000/d>0.001)
                              then begin
                                    j:=j-speed*timer1.Interval/1000/d;
                                   end
                             else
                              begin
                               j:=jkletki-1-2/d;
                               n:=tp;
                               tp:=np;
                               np:=0;
                              end;
                            end;
                      if(np=1)
                       then begin
                             if(j_v_kletke-speed*timer1.Interval/1000/d>0.001)
                              then begin
                                    j:=j-speed*timer1.Interval/1000/d;
                                   end
                             else
                              begin
                               j:=jkletki-1-2/d;
                               n:=tp;
                               tp:=np;
                               np:=0;
                              end;
                             if(j_v_kletke<=6/12)
                              then begin
                                    if(i_v_kletke+speed*timer1.Interval/d/3000<5/12)
                                     then begin
                                           i:=i+speed*timer1.Interval/d/3000;
                                          end
                                    else
                                     begin
                                      i:=ikletki-1+5/12;
                                     end;
                                   end;
                            end;
                      if(np=-1)
                       then begin
                             if(j_v_kletke-speed*timer1.Interval/1000/d>0.001)
                              then begin
                                    j:=j-speed*timer1.Interval/1000/d;
                                   end
                             else
                              begin
                               j:=jkletki-1-2/d;
                               n:=tp;
                               tp:=np;
                               np:=0;
                              end;
                             if(j_v_kletke<=6/12)
                              then begin
                                    if(i_v_kletke-speed*timer1.Interval/d/3000>1/12)
                                     then begin
                                           i:=i-speed*timer1.Interval/d/3000;
                                          end
                                    else
                                     begin
                                      i:=ikletki-1+1/12;
                                     end;
                                   end;
                            end;
                      if(np=3)
                       then begin
                             while((np<>-2) and (np<>1) and (np<>-1))
                              do begin
                                  np:=random(2+2+1)-2;
                                 end;
                            end;
                     end;
              end;

       end;
end;

procedure auto.oprnextpov;
var
 k,ipoisk,jpoisk,zapret:integer;
 ikletki,jkletki:real;
begin
 ipoisk:=round(i * d) div d + 1;
 jpoisk:=round(j * d) div d + 1;
 if(ipoisk-1>i)
  then ipoisk:=ipoisk-1;
 if(jpoisk-1>j)
  then jpoisk:=jpoisk-1;
 if(ipoisk>sh)
  then begin
        ipoisk:=ipoisk-1;
       end;
 if(jpoisk>dl)
  then begin
        jpoisk:=jpoisk-1;
       end;
 ikletki:=ipoisk;
 jkletki:=jpoisk;
 k:=1;
 while((puti[k].I<>ipoisk) or (puti[k].j<>jpoisk))
  do begin
      k:=k+1;
     end;
 if(((puti[k].Vid=3) or (puti[k].Vid>20)) and (np=0) and (np<>3))
  then begin
            repeat
             if(tp=1)
              then begin
                    ipoisk:=ipoisk+1;
                   end;
             if(tp=-1)
              then begin
                    ipoisk:=ipoisk-1;
                   end;
             if(tp=2)
              then begin
                    jpoisk:=jpoisk+1;
                   end;
             if(tp=-2)
              then begin
                    jpoisk:=jpoisk-1;
                   end;
             k:=1;
             while(((puti[k].I<>ipoisk) or (puti[k].j<>jpoisk)) and ((ipoisk>0) and (jpoisk>0) and (ipoisk<=sh) and (jpoisk<=dl)))
              do begin
                  k:=k+1;
                 end;
             if((ipoisk<=0) or (jpoisk<=0) or (ipoisk>sh) or (jpoisk>dl))
              then np:=3;
            until((puti[k].vid=3) or(puti[k].Vid>20) or (np=3));
        if(np<>3)
         then begin
               if(puti[k].Vid=13)
                then begin
                      if(tp=-1)
                       then begin
                             np:=2;
                            end;
                      if(tp=-2)
                       then begin
                             np:=1;
                            end;
                     end;
               if(puti[k].Vid=14)
                then begin
                      if(tp=-1)
                       then begin
                             np:=-2;
                            end;
                      if(tp=2)
                       then begin
                             np:=1;
                            end;
                     end;
               if(puti[k].Vid=15)
                then begin
                      if(tp=1)
                       then begin
                             np:=2;
                            end;
                      if(tp=-2)
                       then begin
                             np:=-1;
                            end;
                     end;
               if(puti[k].Vid=16)
                then begin
                      if(tp=1)
                       then begin
                             np:=-2;
                            end;
                      if(tp=2)
                       then begin
                             np:=-1;
                            end;
                     end;
               if(puti[k].Vid=21)
                then begin
                      zapret:=-2;
                      repeat
                       np:=random(5)-2;
                      until((np<>zapret) and (np<>-1*tp) and (np<>0));
                     end;
               if(puti[k].Vid=22)
                then begin
                      zapret:=1;
                      repeat
                       np:=random(5)-2;
                      until((np<>zapret) and (np<>-1*tp) and (np<>0));
                     end;
               if(puti[k].Vid=23)
                then begin
                      zapret:=2;
                      repeat
                       np:=random(5)-2;
                      until((np<>zapret) and (np<>-1*tp) and (np<>0));
                     end;
               if(puti[k].Vid=24)
                then begin
                      zapret:=-1;
                      repeat
                       np:=random(5)-2;
                      until((np<>zapret) and (np<>-1*tp) and (np<>0));
                     end;
               if(puti[k].Vid=3)
                then begin
                      repeat
                       np:=random(5)-2;
                      until((np<>-1*tp) and (np<>0));
                     end;
              end;
       end;
end;

procedure auto.kolvo_vperedi;
 var
  ikletki,jkletki,ikletki1,jkletki1,k:integer;
begin
 vperedi:=0;
 ikletki:=round(i * d) div d + 1;
 jkletki:=round(j * d) div d + 1;
 if(ikletki>sh)
  then begin
        ikletki:=ikletki-1;
       end;
 if(jkletki>dl)
  then begin
        jkletki:=jkletki-1;
       end;
 k:=1;
 while((puti[k].I<>ikletki) or (puti[k].j<>jkletki))
  do begin
      k:=k+1;
     end;
 if((puti[k].Vid>20)or(puti[k].vid=3))
  then begin
        k:=1;
        while(cars[k].n<>0)
         do begin
             ikletki1:=round(cars[k].i * d) div d + 1;
             jkletki1:=round(cars[k].j * d) div d + 1;
             if(ikletki1>sh)
              then begin
                    ikletki1:=ikletki1-1;
                   end;
             if(jkletki1>dl)
              then begin
                    jkletki1:=jkletki1-1;
                   end;
             if((ikletki=ikletki1) and (jkletki=jkletki1) and (n=cars[k].n) and (np=cars[k].np) and (tp=cars[k].tp))
              then begin
                    if((n=1) and (i<cars[k].i))
                     then begin
                           vperedi:=vperedi+1;
                          end;
                    if((n=-1) and (i>cars[k].i))
                     then begin
                           vperedi:=vperedi+1;
                          end;
                    if((n=2) and (j<cars[k].j))
                     then begin
                           vperedi:=vperedi+1;
                          end;
                    if((n=-2) and (j>cars[k].j))
                     then begin
                           vperedi:=vperedi+1;
                          end;
                   end;
             k:=k+1;
            end;
       end;
end;

procedure auto.uslovie;
var
   ikletki,jkletki,k,l,ikletki1,jkletki1,summa:integer;
begin
 u:=true;
 ikletki:=round(i * d) div d + 1;
 jkletki:=round(j * d) div d + 1;
 if(ikletki>sh)
  then begin
        ikletki:=ikletki-1;
       end;
 if(jkletki>dl)
  then begin
        jkletki:=jkletki-1;
       end;
 k:=1;
 while((puti[k].I<>ikletki) or (puti[k].j<>jkletki))
  do begin
      k:=k+1;
     end;
 if( (n=1)and(i<ikletki-1+2/d) or (n=-1)and(i>ikletki-2/d) or (n=2)and(j<jkletki-1+2/d) or (n=-2)and(j>jkletki-2/d))
  then begin
        if(puti[k].Vid=21)
         then begin
               u:=false;
               if((puti[k].R=1) and (n=1) and (tp=1))
                then begin
                      u:=true;
                     end;
               if((puti[k].R=3) and (n=-2) and (tp=-1))
                then begin
                      u:=true;
                     end;
               if(puti[k].Time-a>d/speed*1000*1.3)
                then begin
                      if((puti[k].R=1) and (n=1) and ((tp=1) or (tp=2)))
                       then u:=true;
                      if((puti[k].R=1) and (n=-2) and (tp=-1))
                       then u:=true;
                      if((puti[k].R=2) and (n=1) and (tp=1))
                       then u:=true;
                      if((puti[k].R=2) and (n=-1) and ((tp=-1) or (tp=2)))
                       then u:=true;
                      if((puti[k].R=3) and (n=-2) and ((tp=1) or (tp=-1)))
                       then u:=true;
                     end;

              end;
        if(puti[k].Vid=22)
         then begin
               u:=false;
               if((puti[k].R=1) and (n=2) and (tp=2))
                then begin
                      u:=true;
                     end;
               if((puti[k].R=3) and (n=1) and (tp=-2))
                then begin
                      u:=true;
                     end;
               if(puti[k].Time-a>d/speed*1000*1.3)
                then begin
                      if((puti[k].R=1) and (n=2) and ((tp=-1) or (tp=2)))
                       then u:=true;
                      if((puti[k].R=1) and (n=1) and (tp=-2))
                       then u:=true;
                      if((puti[k].R=2) and (n=2) and (tp=2))
                       then u:=true;
                      if((puti[k].R=2) and (n=-2) and ((tp=-2) or (tp=-1)))
                       then u:=true;
                      if((puti[k].R=3) and (n=1) and ((tp=-2) or (tp=2)))
                       then u:=true;
                     end;

              end;
        if(puti[k].Vid=23)
         then begin
               u:=false;
               if((puti[k].R=1) and (n=-1) and (tp=-1))
                then begin
                      u:=true;
                     end;
               if((puti[k].R=3) and (n=2) and (tp=1))
                then begin
                      u:=true;
                     end;
               if(puti[k].Time-a>d/speed*1000*1.3)
                then begin
                      if((puti[k].R=1) and (n=-1) and ((tp=-1) or (tp=-2)))
                       then u:=true;
                      if((puti[k].R=1) and (n=2) and (tp=1))
                       then u:=true;
                      if((puti[k].R=2) and (n=-1) and (tp=-1))
                       then u:=true;
                      if((puti[k].R=2) and (n=1) and ((tp=-2) or (tp=1)))
                       then u:=true;
                      if((puti[k].R=3) and (n=2) and ((tp=-1) or (tp=1)))
                       then u:=true;
                     end;

              end;
        if(puti[k].Vid=24)
         then begin
               u:=false;
               if((puti[k].R=1) and (n=-2) and (tp=-2))
                then begin
                      u:=true;
                     end;
               if((puti[k].R=3) and (n=-1) and (tp=2))
                then begin
                      u:=true;
                     end;
               if(puti[k].Time-a>d/speed*1000*1.3)
                then begin
                      if((puti[k].R=1) and (n=-2) and ((tp=1) or (tp=-2)))
                       then u:=true;
                      if((puti[k].R=1) and (n=-1) and (tp=2))
                       then u:=true;
                      if((puti[k].R=2) and (n=-2) and (tp=-2))
                       then u:=true;
                      if((puti[k].R=2) and (n=2) and ((tp=2) or (tp=1)))
                       then u:=true;
                      if((puti[k].R=3) and (n=-1) and ((tp=-2) or (tp=2)))
                       then u:=true;
                     end;

              end;
        if(puti[k].Vid=3)
         then begin
               u:=false;
               if((puti[k].R=1) and (n=-1) and ((tp=-1) or (tp=2)) )
                then begin
                      u:=true;
                     end;
               if((puti[k].R=5) and (n=2) and ((tp=2) or (tp=1)) )
                then begin
                      u:=true;
                     end;
               if(puti[k].Time-a>d/speed*1000*1.3)
                then begin
                      if((puti[k].R=1) and (n=1) and ((tp=1) or (tp=-2)))
                       then u:=true;
                      if((puti[k].R=1) and (n=-1) and ((tp=-1) or (tp=2)) )
                       then u:=true;
                      if((puti[k].R=2) and (n=-1) and ((tp=-2) or (tp=2) or (tp=-1)) )
                       then u:=true;
                      if((puti[k].R=3) and (n=1) and ((tp=-2) or (tp=2) or (tp=1)))
                       then u:=true;
                      if((puti[k].R=4) and (n=2) and ((tp=2) or (tp=1)))
                       then u:=true;
                      if((puti[k].R=4) and (n=-2) and ((tp=-2) or (tp=-1)) )
                       then u:=true;
                      if((puti[k].R=5) and (n=2) and ((tp=1) or (tp=2) or (tp=-1)) )
                       then u:=true;
                      if((puti[k].R=6) and (n=-2) and ((tp=-1) or (tp=-2) or (tp=1)))
                       then u:=true;
                     end;

              end;
       end;
 if(dis<1/4)
  then begin
        u:=false;
       end;
 summa:=0;
 if((puti[k].Vid>20) or (puti[k].Vid=3))
  then begin
        ikletki1:=ikletki;
        jkletki1:=jkletki;
        if(tp=1)
         then ikletki1:=ikletki1+1;
        if(tp=-1)
         then ikletki1:=ikletki1-1;
        if(tp=2)
         then jkletki1:=jkletki1+1;
        if(tp=-2)
         then jkletki1:=jkletki1-1;
        k:=1;
        while((puti[k].I<>ikletki1) or (puti[k].j<>jkletki1))
         do begin
             k:=k+1;
            end;
        if(tp=1)
         then begin
               if(np=-2)
                then summa:=vperedi+puti[k].N10;
               if(np=1)
                then summa:=vperedi+puti[k].N11;
               if(np=2)
                then summa:=vperedi+puti[k].N12;
              end;
        if(tp=2)
         then begin
               if(np=-1)
                then summa:=vperedi+puti[k].N7;
               if(np=2)
                then summa:=vperedi+puti[k].N8;
               if(np=1)
                then summa:=vperedi+puti[k].N9;
              end;
        if(tp=-1)
         then begin
               if(np=-2)
                then summa:=vperedi+puti[k].N4;
               if(np=-1)
                then summa:=vperedi+puti[k].N5;
               if(np=2)
                then summa:=vperedi+puti[k].N6;
              end;
        if(tp=-2)
         then begin
               if(np=-1)
                then summa:=vperedi+puti[k].N1;
               if(np=-2)
                then summa:=vperedi+puti[k].N2;
               if(np=1)
                then summa:=vperedi+puti[k].N3;
              end;
       end;
 if(summa>2)
  then begin
        u:=false;
       end;

 ikletki:=round(i * d) div d + 1;
 jkletki:=round(j * d) div d + 1;
 if(ikletki>sh)
  then begin
        ikletki:=ikletki-1;
       end;
 if(jkletki>dl)
  then begin
        jkletki:=jkletki-1;
       end;
 k:=1;
 while((puti[k].I<>ikletki) or (puti[k].j<>jkletki))
  do begin
      k:=k+1;
     end;
 if not((n=1)and(i<ikletki-1+2/d) or (n=-1)and(i>ikletki-2/d) or (n=2)and(j<jkletki-1+2/d) or (n=-2)and(j>jkletki-2/d))
  then begin
        if((puti[k].vid>20) or(puti[k].vid=3))
         then u:=true;
       end;
end;

procedure auto.distance;
var
 k,k1,k2,vid1,vid2,ikletki,jkletki:integer;
 dis1:real;
begin
 dis:=1;
 k:=1;
 while(cars[k].n<>0)
  do begin
      if((cars[k].n=n) and (cars[k].tp=tp) and ((i>cars[k].i+0.01) or (i<cars[k].i-0.01) or (j>cars[k].j+0.01) or (j<cars[k].j-0.01)))
       then begin
             dis1:=sqrt( (i-cars[k].i)*(i-cars[k].i) + (j-cars[k].j)*(j-cars[k].j) );
             if( (n=1) and (i<cars[k].i) or (n=-1) and (i>cars[k].i) or (n=2) and (j<cars[k].j) or (n=-2) and (j>cars[k].j) )
              then if(dis1<dis)
                    then begin
                          ikletki:=round(i * d) div d + 1;
                          jkletki:=round(j * d) div d + 1;
                          if(ikletki>sh)
                           then begin
                                 ikletki:=ikletki-1;
                                end;
                          if(jkletki>dl)
                           then begin
                                 jkletki:=jkletki-1;
                                end;
                          k1:=1;
                          while((puti[k1].I<>ikletki) or (puti[k1].j<>jkletki))
                           do begin
                               k1:=k1+1;
                              end;
                          ikletki:=round(cars[k].i * d) div d + 1;
                          jkletki:=round(cars[k].j * d) div d + 1;
                          if(ikletki>sh)
                           then begin
                                 ikletki:=ikletki-1;
                                end;
                          if(jkletki>dl)
                           then begin
                                 jkletki:=jkletki-1;
                                end;
                          k2:=1;
                          while((puti[k2].I<>ikletki) or (puti[k2].j<>jkletki))
                           do begin
                               k2:=k2+1;
                              end;
                          if not((puti[k2].vid>10) and (puti[k2].vid<20) and ((puti[k1].vid>20) or (puti[k1].vid=3)))
                           then dis:=dis1;
                         end;
            end;
      k:=k+1;
     end;
end;

procedure TForm1.mapClick(Sender: TObject);
 var
  f:textfile;
  i,j,k,flag1,m_new,smin,smax,tempp,vmax,vmin:integer;
begin
 number:=50;
 if((edit1.Text<>'') and (edit2.Text<>'') and (edit3.Text<>'') and (edit4.Text<>'') and (edit5.Text<>'') and (edit6.Text<>'') and (edit7.Text<>''))
  then begin
        smin:=strtoint(edit1.Text);
        smax:=strtoint(edit2.Text);
        if(smax<smin)
         then begin
               tempp:=smin-smax;
               smin:=smax;
               smax:=smax+tempp;
              end;
        vmin:=strtoint(edit3.Text);
        vmax:=strtoint(edit4.Text);
        if(smax<smin)
         then begin
               tempp:=vmin-vmax;
               vmin:=vmax;
               vmax:=vmax+tempp;
              end;
        speed:=strtoint(edit5.Text);
        if(strtoint(edit6.text)<200)
         then number:=strtoint(edit6.Text);
        // Form1.BorderStyle:=bsDialog;
        for i:=1 to 2500
         do begin
             puti[i]:=doroga.Create;
            end;
        for i:=1 to number+1
         do begin
             cars[i]:=auto.Create;
            end;
        randomize;
        image1.Top:=0;
        image1.Left:=250;
        d:=50;
        assignFile(f,edit7.Text);
        reset(f);
        i:=1;
        j:=1;
        k:=1;

//////////////////////////////////////////////////////////////////////////////
///////////////////*********************************//////////////////////////
//////////////////////////////////////////////////////////////////////////////

        while not eof(f) do
         begin
          j:=1;
          while not eoln(f)
           do begin
               read(f,m_new);
               j:=j+1;
              end;
          readln(f);
          i:=i+1;
         end;
        dl:=j-1;
        sh:=i-1;
        closefile(f);

//////////////////////////////////////////////////////////////////////////////
///////////////////*********************************//////////////////////////
//////////////////////////////////////////////////////////////////////////////
        reset(f);
        i:=1;
        j:=1;
        k:=1;
        while not eof(f) do
         begin
          j:=1;
          while not eoln(f)
           do begin
               read(f,m_new);
               if(m_new<>0)
                then begin
                      puti[k].zapolnenie(m_new,i,j,smin,smax,vmin,vmax);
                      k:=k+1;
                     end;
               j:=j+1;
              end;
          readln(f);
          i:=i+1;
         end;
///////////////////////////////////////////////////////////////////////////////
///////////////////////////********************************////////////////////
///////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////
///////////////////////////********************************////////////////////
///////////////////////////////////////////////////////////////////////////////
        if (form1.Height div (sh))>=((form1.Width-250) div (dl))
         then begin
               image1.Width:=form1.Width-260 - (form1.Width-260) mod dl;
               d:=image1.Width div dl;
               image1.Height:=sh*d;
              end;
        if (form1.Height div (sh))<((form1.Width-250) div (dl))
         then begin
               image1.Height:=form1.Height-30 - (form1.Height-30) mod sh;
               d:=image1.Height div sh;
               image1.Width:=dl*d;
              end;

        k:=1;
        while(puti[k].I<>0)
         do begin
             puti[k].ris(Image1,d);
             k:=k+1;
            end;
        // grass;
        closefile(f);
        start.Visible:=true;
        map.Visible:=false;
        button1.Visible:=false;
        edit1.Visible:=false;
        edit2.Visible:=false;
        edit3.Visible:=false;
        edit4.Visible:=false;
        edit5.Visible:=false;
        edit6.Visible:=false;
        edit7.Visible:=false;
        label1.Visible:=false;
        label3.Visible:=false;
        label5.Visible:=false;
        label7.Visible:=false;
        label9.Visible:=false;
        label10.Visible:=false;
       end
 else showmessage('Некорректный ввод!');
end;

procedure TForm1.startClick(Sender: TObject);
var
 flag1,i:integer;
begin
 flag1:=0;
 if(start.Caption='Начать')
  then begin
        start.Caption:='Остановить';
        flag1:=1;
        i:=1;
        if(speed/1000/d*timer1.Interval>1/9)
         then speed:=round(1/9*1000/timer1.Interval*d);
        if(speed/1000/d*timer1.Interval<0.05)
         then speed:=round(0.05*1000/timer1.Interval*d);
        while(puti[i].I<>0)
         do begin
             puti[i].sbros(a);
             i:=i+1;
            end;
        a:=0;
        timer1.Interval:=50;
        timer1.Enabled:=true;
       end;
 if((start.Caption='Остановить') and (flag1=0))
  then begin
        start.Caption:='Начать';
        timer1.Enabled:=false;
       end;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
var
 k,q:integer;
begin
 k:=1;
 while(cars[k].n<>0)
  do begin
      cars[k].riscar(image1,0);
      k:=k+1;
     end;
 a:=a+timer1.Interval;
 k:=1;
 while(puti[k].I<>0)
  do begin
      puti[k].new_car(cars);
      puti[k].smenasveta(a);
      puti[k].ris(Image1,d);
      puti[k].kolvo_mashin(cars);
      k:=k+1;
     end;
 k:=1;
 while(cars[k].n<>0)
  do begin
      cars[k].oprnextpov;
      cars[k].distance;
      cars[k].kolvo_vperedi;
      q:=1;
      while(puti[q].I<>0)
       do begin
           puti[q].kolvo_mashin(cars);
           q:=q+1;
          end;
      cars[k].uslovie;
      if(cars[k].u=true)
       then begin
             cars[k].dvizenie(Timer1);
            end;
      k:=k+1;
     end;
 ochishenie;
 k:=1;
 while(cars[k].n<>0)
  do begin
      cars[k].riscar(image1,1);
      k:=k+1;
     end;   
end;

procedure TForm1.ochishenie;
var
 flag,k,i:integer;
begin
  flag:=0;
  while(flag=0)
   do begin
       flag:=1;
       k:=1;
       while(cars[k].n<>0)
        do begin
            if((cars[k].i>sh) or (cars[k].j>dl) or (cars[k].i<0) or (cars[k].j<0))
             then begin
                   flag:=0;
                   if(not ((cars[k+1].i>sh) or (cars[k+1].j>dl) or (cars[k+1].i<0) or (cars[k+1].j<0)))
                    then begin
                          i:=k;
                          cars[k].riscar(image1,0);
                          repeat
                           cars[i].i:=cars[i+1].i;
                           cars[i].j:=cars[i+1].j;
                           cars[i].b:=cars[i+1].b;
                           cars[i].n:=cars[i+1].n;
                           cars[i].tp:=cars[i+1].tp;
                           cars[i].np:=cars[i+1].np;
                           cars[i].vperedi:=cars[i+1].vperedi;
                           i:=i+1;
                          until(cars[i].n=0);
                         end;
                  end;
            k:=k+1;
           end;
      end;
end;

procedure TForm1.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
 if(((key>'9') or (key<'0')) and (key<>#8))
  then begin
        key:=#0;
       end;
end;

procedure TForm1.Edit2KeyPress(Sender: TObject; var Key: Char);
begin
 if(((key>'9') or (key<'0')) and (key<>#8))
  then begin
        key:=#0;
       end;
end;

procedure TForm1.Button1Click(Sender: TObject);
 var
  s:string;
begin
 openDialog1.Filter := 'Только текстовые файлы|*.txt';
 If(opendialog1.Execute)
  then S := opendialog1.filename;
 Edit7.Text:=openDialog1.FileName; 
end;

procedure TForm1.FormResize(Sender: TObject);
begin
 if(form1.Height<470)
  then form1.Height:=470;
 if(form1.Width<780)
  then form1.Width:=780;
 start.Top:=(form1.Height-start.Height) div 2;
 label1.Top:=(form1.Height-(7 * 48 + map.Height)) div 2;
 edit1.Top:=(form1.Height-(7 * 48 + map.Height)) div 2;
 label3.Top:=(form1.Height-(7 * 48 + map.Height)) div 2 + 48;
 edit2.Top:=(form1.Height-(7 * 48 + map.Height)) div 2 + 48;
 label5.Top:=(form1.Height-(7 * 48 + map.Height)) div 2 + 2 * 48;
 edit3.Top:=(form1.Height-(7 * 48 + map.Height)) div 2 + 2 * 48;
 label7.Top:=(form1.Height-(7 * 48 + map.Height)) div 2 + 3 * 48;
 edit4.Top:=(form1.Height-(7 * 48 + map.Height)) div 2 + 3 * 48;
 label9.Top:=(form1.Height-(7 * 48 + map.Height)) div 2 + 4 * 48;
 edit5.Top:=(form1.Height-(7 * 48 + map.Height)) div 2 + 4 * 48;
 label10.Top:=(form1.Height-(7 * 48 + map.Height)) div 2 + 5 * 48;
 edit6.Top:=(form1.Height-(7 * 48 + map.Height)) div 2 + 5 * 48;
 button1.Top:=(form1.Height-(7 * 48 + map.Height)) div 2 + 6 * 48;
 edit7.Top:=(form1.Height-(7 * 48 + map.Height)) div 2 + 6 * 48;
 map.Top:=(form1.Height-(7 * 48 + map.Height)) div 2 + 7 * 48;

 label1.Left:=(form1.Width - (616+edit1.Width)) div 2;
 edit1.Left:=(form1.Width - (616+edit1.Width)) div 2 + 616;
 label3.Left:=(form1.Width - (616+edit2.Width)) div 2;
 edit2.Left:=(form1.Width - (616+edit2.Width)) div 2 + 616;
 label5.Left:=(form1.Width - (616+edit3.Width)) div 2;
 edit3.Left:=(form1.Width - (616+edit3.Width)) div 2 + 616;
 label7.Left:=(form1.Width - (616+edit4.Width)) div 2;
 edit4.Left:=(form1.Width - (616+edit4.Width)) div 2 + 616;
 label9.Left:=(form1.Width - (616+edit5.Width)) div 2;
 edit5.Left:=(form1.Width - (616+edit5.Width)) div 2 + 616;
 label10.Left:=(form1.Width - (616+edit6.Width)) div 2;
 edit6.Left:=(form1.Width - (616+edit6.Width)) div 2 + 616;
 edit7.Left:=(form1.Width - (674+button1.Width)) div 2;
 button1.Left:=(form1.Width - (674+button1.Width)) div 2 + 674;
 map.Left:=(form1.Width - map.Width) div 2;
end;

procedure TForm1.grass;
var
 i,j,k:integer;
 flag1:boolean;
begin
 Image1.Canvas.Brush.Style:=bsSolid;
 Image1.Canvas.brush.Color:=clGreen;

 for i:=1 to sh
  do begin
      for j:=1 to dl
       do begin
           flag1:=false;
           k:=1;
           while(puti[k].Vid<>0)
            do begin
                if((puti[k].i=i) and (puti[k].j=j))
                 then begin
                       flag1:=true;
                      end;
                k:=k+1;
               end;
           if((flag1=false) and (Image1.Canvas.Pixels[round((i-0.5)*d),round((j-0.5)*d)]<>clGreen))
            then begin
                  Image1.Canvas.FloodFill(round((i-0.5)*d),round((j-0.5)*d),clGreen,fsborder);
                 end;
          end;
     end;
end;

procedure TForm1.Edit6KeyPress(Sender: TObject; var Key: Char);
begin
 if(((key>'9') or (key<'0')) and (key<>#8))
  then begin
        key:=#0;
       end;
end;

procedure TForm1.Edit5KeyPress(Sender: TObject; var Key: Char);
begin
 if(((key>'9') or (key<'0')) and (key<>#8))
  then begin
        key:=#0;
       end;
end;

end.
