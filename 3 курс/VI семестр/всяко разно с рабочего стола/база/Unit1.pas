unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, DBCtrls, Grids, DBGrids, DB, DBTables, XPMan, StdCtrls,
  ComCtrls;

type
  TForm1 = class(TForm)
    DataSource: TDataSource;
    DBGrid: TDBGrid;
    DBNavigator: TDBNavigator;
    Table: TTable;
    XPManifest: TXPManifest;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Button1: TButton;
    GroupBox2: TGroupBox;
    Label2: TLabel;
    CodeComboBox: TComboBox;
    DateTimePicker: TDateTimePicker;
    Label3: TLabel;
    Label4: TLabel;
    Button2: TButton;
    Button3: TButton;
    Query: TQuery;
    DataSource2: TDataSource;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
    Table.TableName := 'UFO.DB';
    Table.Active := True;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  with Query do
    begin
      DataSource := DataSource;
      Close;
      SQL.Clear;
      SQL.Add('SELECT * FROM UFO.DB WHERE (Sound = true) AND (Light = true) AND (ViewTime BETWEEN "12:00:00"  AND  "18:00:00") ORDER BY Code');
      Open;
      if RecordCount<>0
        then
        begin
             DataSource2.DataSet:=Query ;
             DBGrid.DataSource := DataSource2;
        end
        else ShowMessage('В БД нет записей, удовлетворяющих'+#13+'условию запроса.');
    end;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  with Query do
    begin
      DataSource := DataSource;
      Close;
      SQL.Clear;
      SQL.Add('UPDATE UFO.DB SET ViewDate = :VDate WHERE Code = :UFOCode AND duration = (SELECT max(duration) FROM UFO.DB)');
      ParamByName('UFOCode').AsString := CodeComboBox.Text;
      ParamByName('VDate').AsDate := DateTimePicker.Date;
      ExecSQL;

    end;
    DBNavigator.BtnClick(nbRefresh);
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
    DBGrid.DataSource := DataSource;
end;

end.
