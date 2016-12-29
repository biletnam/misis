unit QGain;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Grids, DBGrids, Db, DBTables, DBCtrls, ComCtrls;

type
  TForm_QGain = class(TForm)
    Query1: TQuery;
    DataSource1: TDataSource;
    DBGrid1: TDBGrid;
    Button_Close: TButton;
    Button_Execute: TButton;
    DateTimePicker_Start: TDateTimePicker;
    DateTimePicker_Last: TDateTimePicker;
    Label1: TLabel;
    Label2: TLabel;
    procedure Button_CloseClick(Sender: TObject);
    procedure Button_ExecuteClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form_QGain: TForm_QGain;

implementation

{$R *.DFM}

procedure TForm_QGain.Button_CloseClick(Sender: TObject);
begin
     close;
end;

procedure TForm_QGain.Button_ExecuteClick(Sender: TObject);
begin
     try
          Query1.Active:=false;
          Query1.ParamByName('first_date').AsDate:=DateTimePicker_Start.Date;
          Query1.ParamByName('last_date').AsDate:=DateTimePicker_Last.Date;
          Query1.Active:=true;
     except
        on error: EDatabaseError do begin
           MessageDlg('При выполнении запроса произошла ошибка:'+#13+#13+
           error.Message ,mtError,[mbOK],0);
        end;
     end;
end;

end.
