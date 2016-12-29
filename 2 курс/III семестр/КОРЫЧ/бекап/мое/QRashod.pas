unit QRashod;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DBTables, DB, Grids, DBGrids, StdCtrls, ComCtrls, DBCtrls;

type
  TQRashodi = class(TForm)
    QRashodi_DataSource1: TDataSource;
    QRashodi_DataSource2: TDataSource;
    DBGrid1: TDBGrid;
    QRashodi_Table: TTable;
    QRashodi_Query: TQuery;
    ButtonDo: TButton;
    Vid: TDBLookupComboBox;
    Data1: TDateTimePicker;
    Data2: TDateTimePicker;
    procedure ButtonDoClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  QRashodi: TQRashodi;

implementation

{$R *.dfm}

procedure TQRashodi.ButtonDoClick(Sender: TObject);
begin
   try
      QRashodi_Query.Active:=false;
      QRashodi_Query.ParamByName('first_date').AsDate:=Data1.Date;
      QRashodi_Query.ParamByName('last_date').AsDate:=Data2.Date;
      QRashodi_Query.ParamByName('name').AsString:=Vid.Text;
      QRashodi_Query.Active:=true;
   except
        on error: EDatabaseError do begin
           MessageDlg('При выполнении запроса произошла ошибка:'+#13+#13+
           error.Message ,mtError,[mbOK],0);
        end;
   end;
end;

end.
