unit paswd;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm2 = class(TForm)
    Button1: TButton;
    Edit1: TEdit;
    Label1: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

uses adsbaz, usprint;

{$R *.dfm}

procedure TForm2.Button1Click(Sender: TObject);
begin
 if Edit1.Text=''
 then
  begin
   Screen.Cursor:=crHourGlass;
   Sleep(400);
   Screen.Cursor:=crDefault;
   Form3.Show;
   Form2.Hide;
  end
 else
  begin
   MessageDlg('Неверный пароль!',mtError,[mbOK],0);
   Close;
  end;
end;

procedure TForm2.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 Action:=caFree;
end;

procedure TForm2.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
 if Key=#13 then Button1.Click;
end;

procedure TForm2.FormCreate(Sender: TObject);
begin
 // пароль как при входе в Win XP
 Edit1.Font.Name:='Wingdings';
 Edit1.PasswordChar:='l'; // символ "точка"
 //
 Application.Title:='База предприятий и менеджеров v0.99'; 
end;

end.
