unit Main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, ExtCtrls, StdCtrls;

type
  TForm_Main = class(TForm)
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
    N13: TMenuItem;
    SQL1: TMenuItem;
    Button_Close: TButton;
    Bevel1: TBevel;
    N14: TMenuItem;
    N15: TMenuItem;
    N16: TMenuItem;
    N17: TMenuItem;
    Label1: TLabel;
    procedure N2Click(Sender: TObject);
    procedure N4Click(Sender: TObject);
    procedure N5Click(Sender: TObject);
    procedure N6Click(Sender: TObject);
    procedure N7Click(Sender: TObject);
    procedure N9Click(Sender: TObject);
    procedure N11Click(Sender: TObject);
    procedure N10Click(Sender: TObject);
    procedure N12Click(Sender: TObject);
    procedure SQL1Click(Sender: TObject);
    procedure Button_CloseClick(Sender: TObject);
    procedure N14Click(Sender: TObject);
    procedure N15Click(Sender: TObject);
    procedure N16Click(Sender: TObject);
    procedure N17Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form_Main: TForm_Main;

implementation

uses Warhouses, Presences, Books, Sales, In_Warhouse, In_Book, In_Presence,
  In_Sale, SQL_Query, QKnowledge, QSale_Cost, QAuthor, QGain;

{$R *.DFM}

procedure TForm_Main.N2Click(Sender: TObject);
begin
     Close;
end;

procedure TForm_Main.N4Click(Sender: TObject);
begin
     Form_Warhouses.Show;
end;

procedure TForm_Main.N5Click(Sender: TObject);
begin
     Form_Presences.Show;
end;

procedure TForm_Main.N6Click(Sender: TObject);
begin
     Form_Books.Show;
end;

procedure TForm_Main.N7Click(Sender: TObject);
begin
     Form_Sales.Show;
end;

procedure TForm_Main.N9Click(Sender: TObject);
begin
     Form_In_Warhouse.Show;
end;

procedure TForm_Main.N11Click(Sender: TObject);
begin
     Form_In_Book.Show;
end;

procedure TForm_Main.N10Click(Sender: TObject);
begin
     Form_In_Presence.Show;
end;

procedure TForm_Main.N12Click(Sender: TObject);
begin
     Form_In_Sale.Show;
end;

procedure TForm_Main.SQL1Click(Sender: TObject);
begin
     Form_SQL_Query.Show;
end;

procedure TForm_Main.Button_CloseClick(Sender: TObject);
begin
     close;
end;

procedure TForm_Main.N14Click(Sender: TObject);
begin
     Form_QKnowledge.Show;
end;

procedure TForm_Main.N15Click(Sender: TObject);
begin
     Form_QSale_Cost.Show;
end;

procedure TForm_Main.N16Click(Sender: TObject);
begin
     Form_QAuthor.Show;
end;

procedure TForm_Main.N17Click(Sender: TObject);
begin
     Form_QGain.Show;
end;

end.
