unit SQL_Query;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Grids, DBGrids, Db, DBTables;

type
  TForm_SQL_Query = class(TForm)
    Query1: TQuery;
    DataSource1: TDataSource;
    Button_Execute: TButton;
    Button_Clear: TButton;
    Button_Close: TButton;
    GroupBox1: TGroupBox;
    Memo1: TMemo;
    GroupBox2: TGroupBox;
    DBGrid1: TDBGrid;
    Button_Save: TButton;
    Button_Load: TButton;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    procedure Button_ExecuteClick(Sender: TObject);
    procedure Button_ClearClick(Sender: TObject);
    procedure Button_CloseClick(Sender: TObject);
    procedure Button_LoadClick(Sender: TObject);
    procedure Button_SaveClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form_SQL_Query: TForm_SQL_Query;

implementation

{$R *.DFM}

procedure TForm_SQL_Query.Button_ExecuteClick(Sender: TObject);
begin
     //присваиваетс€ текст SQL-запроса
     Form_SQL_Query.Query1.SQL:=Form_SQL_Query.Memo1.Lines;
     try
        //закрываетс€ запрос
        Form_SQL_Query.Query1.Active:=false;
        //открываетс€ запрос
        Form_SQL_Query.Query1.Active:=true;
     except
        //в случае ошибки базы данных выводитс€ сообщение об ошибке
        on error: EDatabaseError do begin
           MessageDlg('ѕри выполнении запроса произошла ошибка:'+#13+#13+
           error.Message ,mtError,[mbOK],0);
        end;
     end;
end;

procedure TForm_SQL_Query.Button_ClearClick(Sender: TObject);
begin
     Form_SQL_Query.Memo1.Lines.Clear;
end;

procedure TForm_SQL_Query.Button_CloseClick(Sender: TObject);
begin
     close;
end;

procedure TForm_SQL_Query.Button_LoadClick(Sender: TObject);
begin
     if OpenDialog1.Execute then begin
         Memo1.Lines.LoadFromFile(OpenDialog1.FileName);
     end;
end;

procedure TForm_SQL_Query.Button_SaveClick(Sender: TObject);
begin
     if SaveDialog1.Execute then begin
         Memo1.Lines.SaveToFile(ChangeFileExt(SaveDialog1.FileName,'.sql'));
     end;
end;

end.
