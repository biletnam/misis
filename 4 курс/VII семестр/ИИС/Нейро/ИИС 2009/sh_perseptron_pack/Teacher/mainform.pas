unit mainform;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Spin, FileCtrl, Mask, ToolEdit;

type
  TForm1 = class(TForm)
    SpinEdit1: TSpinEdit;
    Edit2: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Button1: TButton;
    Edit3: TEdit;
    Edit4: TEdit;
    Label4: TLabel;
    Label5: TLabel;
    Edit1: TEdit;
    Button2: TButton;
    OpenDialog1: TOpenDialog;
    procedure Button1Click(Sender: TObject);
    function Sign(f:extended):integer;
    procedure FormCreate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.Button1Click(Sender: TObject);
var f:textfile;
    x:array[1..100,1..100] of extended;
    y:array[1..100,1..100] of extended;
    r:array[1..10000] of integer;
    E,z:extended;
    passes,rn,t,p,i,j,k:integer;

    ts:string;

procedure GetImage(fn:string);
var Img:TBitmap;
    j,k:integer;
begin
  Img:=TBitmap.Create;
  Img.LoadFromFile(Edit1.Text+IntToStr(i)+'.bmp');
  for j:=1 to 100 do
  begin
    for k:=1 to 100 do
    begin
      if Img.Canvas.Pixels[j,k]=0 then x[j,k]:=10000 else x[j,k]:=1;
      if Img.Canvas.Pixels[j,k]=-1 then x[j,k]:=0;
    end;
  end;
  Img.Destroy;
end;

function Analyse():extended;
var j,k:integer;
      z:extended;
begin
  z:=0;
  for j:=1 to 100 do
  begin
    for k:=1 to 100 do
    begin
      z:=z+x[j,k]*y[j,k];
    end;
  end;
  result:=z;
end;

begin
  if (Edit1.Text='') or (Edit2.Text='') or (Edit3.Text='') then
  begin
    Showmessage('Укажите все данные!');
    exit;
  end;
  // Устанавливаем параметры обучения
  E:=StrToFloat(Edit2.Text);
  passes:=SpinEdit1.Value;
  if Edit1.Text[length(Edit1.Text)]<>'\' then Edit1.Text:=Edit1.Text+'\';

  // Читаем условия для обучения
  assignfile(f,Edit1.Text+'rules.txt');
  reset(f);
  rn:=0;
  while not eof(f) do
  begin
    inc(rn);
    readln(f,t);
    r[rn]:=t;
  end;
  closefile(f);

  // Зануляем настроечные данные
  for j:=1 to 100 do
  for k:=1 to 100 do y[j,k]:=0;
  for p:=1 to passes do
    for i:=1 to rn do
    begin
      GetImage(Edit1.Text+InttoStr(i)+'.bmp');
      z:=Analyse();
      while Sign(z)<>r[i] do
      begin
        for j:=1 to 100 do
        begin
          for k:=1 to 100 do
          begin
            y[j,k]:=y[j,k]+r[i]*E*x[j,k];
          end;
        end;
        z:=Analyse();
      end;

    end;
  ts:='';
  for i:=1 to rn do
  begin
    GetImage(Edit1.Text+InttoStr(i)+'.bmp');
    z:=Analyse();
    if Sign(z)<>r[i] then ts:=ts+IntToStr(i)+'.bmp, '
  end;
  ShowMessage('Обучение закончено!'#13'Ошибки: '+ts);
  // Сохраняем данные обучения
  assignfile(f,Edit1.Text+'\perseptron.dat');
  rewrite(f);
  writeln(f,Edit3.Text);
  writeln(f,Edit4.Text);
  for j:=1 to 100 do
  begin
    for k:=1 to 100 do
    begin
      ts:=Format('%.8f ',[y[j,k]]);
      ts[pos(',',ts)]:='.';
      write(f,ts);
    end;
    writeln(f);
  end;
  closefile(f);
end;

function TForm1.Sign(f: extended): integer;
begin
  if f>0 then result:=1 else
    if f<0 then result:=-1 else result:=0;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  OpenDialog1.InitialDir:=ExtractFilePath(Application.Exename);
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  if OpenDialog1.Execute then
    Edit1.Text:=ExtractFilePath(OpenDialog1.FileName)
end;

end.
