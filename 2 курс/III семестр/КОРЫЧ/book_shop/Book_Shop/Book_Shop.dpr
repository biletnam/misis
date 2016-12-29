program Book_Shop;

uses
  Forms,
  Main in 'Main.pas' {Form_Main},
  Warhouses in 'Warhouses.pas' {Form_Warhouses},
  Presences in 'Presences.pas' {Form_Presences},
  Books in 'Books.pas' {Form_Books},
  Sales in 'Sales.pas' {Form_Sales},
  In_Warhouse in 'In_Warhouse.pas' {Form_In_Warhouse},
  In_Book in 'In_Book.pas' {Form_In_Book},
  In_Presence in 'In_Presence.pas' {Form_In_Presence},
  In_Sale in 'In_Sale.pas' {Form_In_Sale},
  SQL_Query in 'SQL_Query.pas' {Form_SQL_Query},
  QKnowledge in 'QKnowledge.pas' {Form_QKnowledge},
  QSale_Cost in 'QSale_Cost.pas' {Form_QSale_Cost},
  QAuthor in 'QAuthor.pas' {Form_QAuthor},
  QGain in 'QGain.pas' {Form_QGain};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TForm_Main, Form_Main);
  Application.CreateForm(TForm_Warhouses, Form_Warhouses);
  Application.CreateForm(TForm_Presences, Form_Presences);
  Application.CreateForm(TForm_Books, Form_Books);
  Application.CreateForm(TForm_Sales, Form_Sales);
  Application.CreateForm(TForm_In_Warhouse, Form_In_Warhouse);
  Application.CreateForm(TForm_In_Book, Form_In_Book);
  Application.CreateForm(TForm_In_Presence, Form_In_Presence);
  Application.CreateForm(TForm_In_Sale, Form_In_Sale);
  Application.CreateForm(TForm_SQL_Query, Form_SQL_Query);
  Application.CreateForm(TForm_QKnowledge, Form_QKnowledge);
  Application.CreateForm(TForm_QSale_Cost, Form_QSale_Cost);
  Application.CreateForm(TForm_QAuthor, Form_QAuthor);
  Application.CreateForm(TForm_QGain, Form_QGain);
  Application.Run;
end.
