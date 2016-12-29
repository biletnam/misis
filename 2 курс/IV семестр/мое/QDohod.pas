unit QDohod;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Tabl_Dohod, DBCtrls, Grids, DBGrids, StdCtrls, DBTables, DB,
  ComCtrls, RpBase, RpSystem, RpDefine, RpRave, RpCon, RpConDS, RpConBDE;

type
  TQDohodi = class(TForm)
    QDohod_Table: TTable;
    QDohod_TableDataSource1: TDataSource;
    QDohod_TableQuery: TQuery;
    QDohod_TableDataSource2: TDataSource;
    ButtonDo: TButton;
    DBGrid1: TDBGrid;
    Vid: TDBLookupComboBox;
    Data1: TDateTimePicker;
    Data2: TDateTimePicker;
    Button1: TButton;
    RvProject1: TRvProject;
    RvSystem1: TRvSystem;
    RvQueryConnection1: TRvQueryConnection;
    procedure ButtonDoClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  QDohodi: TQDohodi;

implementation

{$R *.dfm}

procedure TQDohodi.ButtonDoClick(Sender: TObject);
begin
   try
      QDohod_TableQuery.Active:=false;
      QDohod_TableQuery.ParamByName('first_date').AsDate:=Data1.Date;
      QDohod_TableQuery.ParamByName('last_date').AsDate:=Data2.Date;
      QDohod_TableQuery.ParamByName('name').AsString:=Vid.Text;
      QDohod_TableQuery.Active:=true;
   except
        on error: EDatabaseError do begin
           MessageDlg('При выполнении запроса произошла ошибка:'+#13+#13+
           error.Message ,mtError,[mbOK],0);
        end;
   end;
   QDohod_TableDataSource2.DataSet:=QDohod_TableQuery;
end;

procedure TQDohodi.Button1Click(Sender: TObject);
begin
  QDohod_TableQuery.ParamByName('first_date').AsDate:=Data1.Date;
  QDohod_TableQuery.ParamByName('last_date').AsDate:=Data2.Date;
  QDohod_TableQuery.ParamByName('name').AsString:=Vid.Text;
  RvProject1.Execute;
end;

end.
