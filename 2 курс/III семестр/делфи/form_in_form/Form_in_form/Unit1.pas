unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    Button1: TButton;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses unit2;

procedure TForm1.Button1Click(Sender: TObject);
begin
 if Panel1.Width<>Form2.Width
 then
  begin
   Form2:=TForm2.CreateParented(Panel1.Handle);
   Panel1.Width:=Form2.Width;
   Panel1.Height:=Form2.Height;
   Form2.WindowState:=wsMaximized;
   Form2.Show;
 end
 else ShowMessage('Form was created already!');
end;

procedure TForm1.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
 if Panel1.Width=Form2.Width
 then Form2.Free;
 Application.Terminate;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
 Form2.BorderStyle:=bsNone;
 if Panel1.Width=Form2.Width
 then
  begin
   Form2.Free;
   Panel1.Width:=150;
   Panel1.Height:=150;
   Panel1.Caption:='Nothing to observe now!';
  end;
end;

end.
