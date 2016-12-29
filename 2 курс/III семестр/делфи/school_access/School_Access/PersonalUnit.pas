unit PersonalUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, DBCtrls, StdCtrls, Menus, ToolWin, ComCtrls, Grids,
  DBGrids,ComObj;

type
  TPersonalForm = class(TForm)
    DBGrid1: TDBGrid;
    ToolBar1: TToolBar;
    MainMenu1: TMainMenu;
    N1: TMenuItem;
    Excel1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    N8: TMenuItem;
    N9: TMenuItem;
    N10: TMenuItem;
    N11: TMenuItem;
    Label1: TLabel;
    FilterFamEdit: TEdit;
    DBNavigator1: TDBNavigator;
    procedure FilterFamEditKeyPress(Sender: TObject; var Key: Char);
    procedure N8Click(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure N6Click(Sender: TObject);
    procedure N5Click(Sender: TObject);
    procedure Excel1Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  PersonalForm: TPersonalForm;

implementation

uses DataModuleUnit, PrepodUnit, StudentUnit;

{$R *.dfm}

procedure TPersonalForm.FilterFamEditKeyPress(Sender: TObject;
  var Key: Char);
begin
If Length(FilterFamEdit.Text)>0 then
   DataModule1.PersonalTable.Filtered:=True
else DataModule1.PersonalTable.Filtered:=False;
DataModule1.PersonalTable.Filter:='Фамилия>'''+FilterFamEdit.Text+'''';
end;

procedure TPersonalForm.N8Click(Sender: TObject);
begin
DataModule1.PersonalTable.Sort:='Фамилия';
end;

procedure TPersonalForm.N3Click(Sender: TObject);
begin
Close;
end;

procedure TPersonalForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
StudentForm.Close;
end;

procedure TPersonalForm.N6Click(Sender: TObject);
begin
StudentForm.Show;
PersonalForm.Hide;
end;

procedure TPersonalForm.N5Click(Sender: TObject);
begin
PrepodForm.Show;
PersonalForm.Hide;
end;

procedure TPersonalForm.Excel1Click(Sender: TObject);
var
 XLApp,Sheet,Colum:Variant;
 index,i:Integer;
begin
 XLApp:= CreateOleObject('Excel.Application');
 XLApp.Visible:=true;
 XLApp.Workbooks.Add(-4167);
 XLApp.Workbooks[1].WorkSheets[1].Name:='Школа-Технический персонал';
 Colum:=XLApp.Workbooks[1].WorkSheets['Школа-Технический персонал'].Columns;
 Colum.Columns[1].ColumnWidth:=20;
 Colum.Columns[2].ColumnWidth:=20;
 Colum.Columns[3].ColumnWidth:=20;
 Colum.Columns[4].ColumnWidth:=20;
 Colum.Columns[5].ColumnWidth:=20;

 Colum:=XLApp.Workbooks[1].WorkSheets['Школа-Технический персонал'].Rows;
 Colum.Rows[2].Font.Bold:=true;
 Colum.Rows[1].Font.Bold:=true;
 Colum.Rows[1].Font.Color:=clBlack;
 Colum.Rows[1].Font.Size:=14;

 Sheet:=XLApp.Workbooks[1].WorkSheets['Школа-Технический персонал'];
 Sheet.Cells[1,2]:='Школа';
 Sheet.Cells[2,1]:='Фамилия';
 Sheet.Cells[2,2]:='Имя';
 Sheet.Cells[2,3]:='Должность';
 Sheet.Cells[2,4]:='Адрес';
 Sheet.Cells[2,5]:='Телефон';

 index:=3;
 DataModule1.PersonalTable.First;
for i:=0 to DataModule1.PersonalTable.RecordCount-1 do
 begin
   Sheet.Cells[index,1]:=DataModule1.PersonalTable.Fields.Fields[1].AsString;
   Sheet.Cells[index,2]:=DataModule1.PersonalTable.Fields.Fields[2].AsString;
   Sheet.Cells[index,3]:=DataModule1.PersonalTable.Fields.Fields[3].AsString;
   Sheet.Cells[index,4]:=DataModule1.PersonalTable.Fields.Fields[5].AsString;
   Sheet.Cells[index,5]:=DataModule1.PersonalTable.Fields.Fields[4].AsString;
   Inc(index);
   DataModule1.PersonalTable.Next;
 end;
 end;

procedure TPersonalForm.N2Click(Sender: TObject);
 var
s:integer;
i:integer;
begin
s:=0;
for i:=0 to DataModule1.PersonalTable.RecordCount-1 do
 s:=s+1;
ShowMessage('Название таблицы: '+Datamodule1.PersonalTable.TableName+#13+'Количество записей: '+IntToStr(s));
end;

end.
