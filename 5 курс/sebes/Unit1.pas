unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,SQLite3, SQLiteTable3, globals;

type
  TForm1 = class(TForm)
    Edit1: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Edit2: TEdit;
    Edit3: TEdit;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
   DB : TSQLiteDatabase;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var name, price, norm: string;
query: AnsiString;
begin
  //Добавить
  name := Edit1.Text;
  price := Edit2.Text;
  norm := Edit3.Text;

  query := 'INSERT INTO works(product_id, name, price, norm) VALUES("'+CurrentProductId+'", "'+name+'","'+price+'","'+norm+'")';
  query := AnsiToUtf8(query);
 // ShowMessage(query);
  DB.ExecSQL(query);
  Form1.Close;
  NeedLoadProducts := true;
  NeedLoadWorks := true;
end;

procedure TForm1.Button2Click(Sender: TObject);
var name, price, norm: string;
query: AnsiString;
begin
  //Сохранить
  name := Edit1.Text;
  price := Edit2.Text;
  norm := Edit3.Text;

  query := 'UPDATE works SET name="'+name+'", price="'+price+'", norm="'+norm+'" WHERE id='+CurrentWorkId;
  query := AnsiToUtf8(query);
 // ShowMessage(query);
  DB.ExecSQL(query);
  Form1.Close;
  NeedLoadProducts := true;
  NeedLoadWorks := true;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
//Удалить
  DB.ExecSQL('DELETE FROM works WHERE id='+CurrentWorkId);
  NeedLoadProducts := true;
  NeedLoadWorks := true;
  Form1.Close;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  DB := TSQLiteDatabase.Create('base.sqlite');
end;

end.
