unit mainform;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, RxGIF, ExtDlgs;

type
  TForm1 = class(TForm)
    Image1: TImage;
    OpenDialog1: TOpenDialog;
    Edit1: TEdit;
    Button1: TButton;
    Label1: TLabel;
    Edit2: TEdit;
    Button2: TButton;
    Label3: TLabel;
    Button3: TButton;
    label2: TLabel;
    OpenPictureDialog1: TOpenPictureDialog;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    function Sign(f:extended):integer;    
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
begin
  if OpenPictureDialog1.Execute then
  begin
    Edit1.Text:=OpenPictureDialog1.FileName;
    Image1.Picture.LoadFromFile(Edit1.Text);
    Label2.Caption:='';
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  OpenDialog1.InitialDir:=ExtractFilePath(Application.ExeName);
  OpenPictureDialog1.InitialDir:=ExtractFilePath(Application.ExeName);  
end;

procedure TForm1.Button3Click(Sender: TObject);
var f:textfile;
    x:array[1..100,1..100] of extended;
    y:array[1..100,1..100] of extended;
    z:extended;
    s1,s2:string;
    j,k:integer;
begin
  if (Edit1.Text<>'') and (Edit2.Text<>'') and (fileexists(Edit1.Text)) and (fileexists(Edit2.Text)) then
  begin
    Image1.Picture.LoadFromFile(Edit1.Text);
    Label2.Caption:='';
    // Прочитаем Y
    assignfile(f,Edit2.Text);
    reset(f);
    readln(f,s1);
    readln(f,s2);
    for j:=1 to 100 do
      for k:=1 to 100 do read(f,y[j,k]);
    closefile(f);

    // Сформируем X
    for j:=1 to 100 do
    begin
      for k:=1 to 100 do
      begin
        if Image1.Canvas.Pixels[j,k]=0 then x[j,k]:=10000 else x[j,k]:=1;
        if Image1.Canvas.Pixels[j,k]=-1 then x[j,k]:=0;
      end;
    end;

    // Проанализируем
    z:=0;
    for j:=1 to 100 do
    begin
      for k:=1 to 100 do
      begin
        z:=z+x[j,k]*y[j,k];
      end;
    end;
    if Sign(z)=-1 then Label2.Caption:=s1 else
      if Sign(z)=1 then Label2.Caption:=s2 else
        Label2.Caption:='Образ не распознан!';


  end else ShowMessage('Укажите все данные для распознавания!');
end;

procedure TForm1.Edit1Change(Sender: TObject);
begin
  if fileexists(Edit1.Text) then
    Image1.Picture.LoadFromFile(Edit1.Text);
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  if OpenDialog1.Execute then
  begin
    Edit2.Text:=OpenDialog1.FileName;
    Label2.Caption:='';
  end;
end;

function TForm1.Sign(f: extended): integer;
begin
  if f>0 then result:=1 else
    if f<0 then result:=-1 else result:=0;
end;

end.
