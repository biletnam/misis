unit Books;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, DBCtrls, Grids, DBGrids, Db, DBTables;

type
  TForm_Books = class(TForm)
    Table_Books: TTable;
    DataSource_Books: TDataSource;
    DBGrid1: TDBGrid;
    DBNavigator1: TDBNavigator;
    Button_Close: TButton;
    Query_Delete: TQuery;
    procedure Button_CloseClick(Sender: TObject);
    procedure Table_BooksBeforeDelete(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form_Books: TForm_Books;

implementation

uses Presences, Sales;

{$R *.DFM}

procedure TForm_Books.Button_CloseClick(Sender: TObject);
begin
     Close;
end;

procedure TForm_Books.Table_BooksBeforeDelete(DataSet: TDataSet);
var
   id: string;
   
begin
     if MessageDlg('Текущая запись и все связанные с ней записи будут удалены.'
        +#13+'Продолжить?',
        mtConfirmation,[mbOK,mbCancel],0)=mrCancel then begin
        Abort;
     end;

     Query_Delete.Close;
     id:=Table_Books.FieldByName('id').AsString;

     Query_Delete.SQL.Clear;
     Query_Delete.SQL.Add('DELETE FROM presences');
     Query_Delete.SQL.Add('WHERE presences.id_book='+id);
     Query_Delete.ExecSQL;

     Query_Delete.SQL.Clear;
     Query_Delete.SQL.Add('DELETE FROM sales');
     Query_Delete.SQL.Add('WHERE sales.id_book='+id);
     Query_Delete.ExecSQL;

     Form_Presences.Table_Presences.Close;
     Form_Presences.Table_Presences.Open;
     Form_Sales.Table_Sales.Close;
     Form_Sales.Table_Sales.Open;
end;

end.
