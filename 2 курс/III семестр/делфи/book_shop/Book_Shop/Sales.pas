unit Sales;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, DBCtrls, Grids, DBGrids, Db, DBTables;

type
  TForm_Sales = class(TForm)
    Table_Sales: TTable;
    DataSource_Sales: TDataSource;
    DBGrid1: TDBGrid;
    DBNavigator1: TDBNavigator;
    Button_Close: TButton;
    procedure Button_CloseClick(Sender: TObject);
    procedure Table_SalesBeforeDelete(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form_Sales: TForm_Sales;

implementation

{$R *.DFM}

procedure TForm_Sales.Button_CloseClick(Sender: TObject);
begin
     Close;
end;

procedure TForm_Sales.Table_SalesBeforeDelete(DataSet: TDataSet);
begin
     if MessageDlg('Текущая запись и все связанные с ней записи будут удалены.'
        +#13+'Продолжить?',
        mtConfirmation,[mbOK,mbCancel],0)=mrCancel then begin
        Abort;
     end;
end;

end.
