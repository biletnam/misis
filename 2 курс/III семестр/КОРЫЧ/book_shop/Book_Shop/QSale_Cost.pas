unit QSale_Cost;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, DBCtrls, DBTables, Db, Grids, DBGrids;

type
  TForm_QSale_Cost = class(TForm)
    DBGrid1: TDBGrid;
    Query1: TQuery;
    DataSource1: TDataSource;
    Table_Books1: TTable;
    DataSource_Books1: TDataSource;
    DBLookupComboBox1: TDBLookupComboBox;
    Button_Execute: TButton;
    Button_Close: TButton;
    Label1: TLabel;
    procedure Button_CloseClick(Sender: TObject);
    procedure Button_ExecuteClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form_QSale_Cost: TForm_QSale_Cost;

implementation

{$R *.DFM}

procedure TForm_QSale_Cost.Button_CloseClick(Sender: TObject);
begin
     close;
end;

procedure TForm_QSale_Cost.Button_ExecuteClick(Sender: TObject);
begin
     try
          Query1.Active:=false;
          Query1.Params[0].Value:=DBLookUpComboBox1.KeyValue;
          Query1.Active:=true;
     except
        on error: EDatabaseError do begin
           MessageDlg('При выполнении запроса произошла ошибка:'+#13+#13+
           error.Message ,mtError,[mbOK],0);
        end;
     end;
end;

end.
