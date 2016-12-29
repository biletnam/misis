unit QPostuplenie;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, RpCon, RpConDS, RpConBDE, RpBase, RpSystem,
  RpDefine, RpRave, DB, ComCtrls, DBTables, StdCtrls, DBCtrls, Mask;

type
  TQPostup = class(TForm)
    ButtonDo: TButton;
    Button2: TButton;
    QPostup_Table: TTable;
    Qpostup_TableQuery: TQuery;
    Data1: TDateTimePicker;
    Data2: TDateTimePicker;
    QPostup_TableDataSource1: TDataSource;
    Qpostup_TableDataSource2: TDataSource;
    RvProject1: TRvProject;
    RvSystem1: TRvSystem;
    RvQueryConnection1: TRvQueryConnection;
    DBGrid1: TDBGrid;
    Naimenovanie: TDBEdit;
    procedure Button2Click(Sender: TObject);
    procedure ButtonDoClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  QPostup: TQPostup;

implementation

{$R *.dfm}

procedure TQPostup.Button2Click(Sender: TObject);
begin
  QPostup_TableQuery.ParamByName('first_date').AsDate:=Data1.Date;
  QPostup_TableQuery.ParamByName('last_date').AsDate:=Data2.Date;
  QPostup_TableQuery.ParamByName('naimenovanie').AsString:=Naimenovanie.Text;
  RvProject1.Execute;
end;

procedure TQPostup.ButtonDoClick(Sender: TObject);
begin
try
      QPostup_TableQuery.Active:=false;
      QPostup_TableQuery.ParamByName('first_date').AsDate:=Data1.Date;
      QPostup_TableQuery.ParamByName('last_date').AsDate:=Data2.Date;
      QPostup_TableQuery.ParamByName('naimenovanie').AsString:=Naimenovanie.Text;
      QPostup_TableQuery.Active:=true;
   except
        on error: EDatabaseError do begin
           MessageDlg('При выполнении запроса произошла ошибка:'+#13+#13+
           error.Message ,mtError,[mbOK],0);
        end;
   end;
   QPostup_TableDataSource2.DataSet:=QPostup_TableQuery;
end;


end.
