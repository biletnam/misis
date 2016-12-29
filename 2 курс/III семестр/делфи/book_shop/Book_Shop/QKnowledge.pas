unit QKnowledge;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Grids, DBGrids, Db, DBTables, DBCtrls;

type
  TForm_QKnowledge = class(TForm)
    Query1: TQuery;
    DataSource1: TDataSource;
    DBGrid1: TDBGrid;
    Button_Close: TButton;
    Button_Execute: TButton;
    DBLookupComboBox1: TDBLookupComboBox;
    Table_Books1: TTable;
    DataSource_Books1: TDataSource;
    Label1: TLabel;
    procedure Button_CloseClick(Sender: TObject);
    procedure Button_ExecuteClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form_QKnowledge: TForm_QKnowledge;

implementation

{$R *.DFM}

procedure TForm_QKnowledge.Button_CloseClick(Sender: TObject);
begin
     close;
end;

procedure TForm_QKnowledge.Button_ExecuteClick(Sender: TObject);
begin
     try
          //закрываетс€ запрос
          Query1.Active:=false;
          //устанавливаетс€ параметр "ќбласть знаний"
          Query1.ParamByName('know').AsString:=DBLookUpComboBox1.Text;
          //открываетс€ запрос
          Query1.Active:=true;
     except
        //в случае ошибки базы данных выводитс€ сообщение об ошибке
        on error: EDatabaseError do begin
           MessageDlg('ѕри выполнении запроса произошла ошибка:'+#13+#13+
           error.Message ,mtError,[mbOK],0);
        end;
     end;
end;

end.
