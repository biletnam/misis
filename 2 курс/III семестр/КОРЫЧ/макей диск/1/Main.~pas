unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus,ShellAPI,Tabl_postuplenie,Tabl_vipuskII,Tabl_skladII,About11;

type
  TForm1 = class(TForm)
    MainMenu1: TMainMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    N8: TMenuItem;
    N9: TMenuItem;
    N10: TMenuItem;
    N11: TMenuItem;
    N12: TMenuItem;
    procedure N11Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure N7Click(Sender: TObject);
    procedure N8Click(Sender: TObject);
    procedure N12Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.N11Click(Sender: TObject);
begin
// О программе - Справка
   ShellExecute(Form1.Handle,nil,'spravka.doc',nil,nil,SW_RESTORE);
end;

procedure TForm1.N2Click(Sender: TObject);
begin
// Таблицы - Поступление
Tabl_postup.Show;
end;

procedure TForm1.N7Click(Sender: TObject);
begin
// Таблицы - Выпуск
Tabl_vipusk.Show;
end;

procedure TForm1.N8Click(Sender: TObject);
begin
// Словарь данных - Склады
Kod_sklad.Show;
end;

procedure TForm1.N12Click(Sender: TObject);
begin
// О программе - О программе
AboutForm.Show;
end;

end.
