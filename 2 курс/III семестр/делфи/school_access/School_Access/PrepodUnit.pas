unit PrepodUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, ToolWin, ComCtrls, Menus, StdCtrls, ExtCtrls,
  DBCtrls,ComObj;

type
  TPrepodForm = class(TForm)
    DBGrid1: TDBGrid;
    ToolBar1: TToolBar;
    MainMenu1: TMainMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    Label1: TLabel;
    FilterFamEdit: TEdit;
    Sort: TMenuItem;
    N5: TMenuItem;
    PrepodNavigator: TDBNavigator;
    ExelItem: TMenuItem;
    Cghfdrf1: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    N8: TMenuItem;
    N9: TMenuItem;
    N10: TMenuItem;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure N4Click(Sender: TObject);
    procedure FilterFamEditChange(Sender: TObject);
    procedure N5Click(Sender: TObject);
    procedure ExelItemClick(Sender: TObject);
    procedure N6Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure N7Click(Sender: TObject);
    procedure N8Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  PrepodForm: TPrepodForm;

implementation

uses DataModuleUnit, StudentUnit, UserUnit, Unit1;

{$R *.dfm}

procedure TPrepodForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
StudentForm.Close;
end;

procedure TPrepodForm.N4Click(Sender: TObject);
begin
PrepodForm.Hide;
StudentForm.Show;
end;

procedure TPrepodForm.FilterFamEditChange(Sender: TObject);
begin
If Length(FilterFamEdit.Text)>0 then
   DataModule1.PrepodTable.Filtered:=true
 else DataModule1.PrepodTable.Filtered:=false;
DataModule1.PrepodTable.Filter:='Фамилия>'''+FilterFamEdit.Text+'''';
end;

procedure TPrepodForm.N5Click(Sender: TObject);
begin
DataModule1.PrepodTable.IndexFieldNames:='Фамилия ASC';
end;

procedure TPrepodForm.ExelItemClick(Sender: TObject);
var
 XLApp,Sheet,Colum:Variant;
 index,i:Integer;
begin
 XLApp:= CreateOleObject('Excel.Application');
 XLApp.Visible:=true;
 XLApp.Workbooks.Add(-4167);
 XLApp.Workbooks[1].WorkSheets[1].Name:='Школа-Преподаватели';
 Colum:=XLApp.Workbooks[1].WorkSheets['Школа-Преподаватели'].Columns;
 Colum.Columns[1].ColumnWidth:=20;
 Colum.Columns[2].ColumnWidth:=20;
 Colum.Columns[3].ColumnWidth:=20;
 Colum.Columns[4].ColumnWidth:=20;
 Colum.Columns[5].ColumnWidth:=20;

 Colum:=XLApp.Workbooks[1].WorkSheets['Школа-Преподаватели'].Rows;
 Colum.Rows[2].Font.Bold:=true;
 Colum.Rows[1].Font.Bold:=true;
 Colum.Rows[1].Font.Color:=clBlack;
 Colum.Rows[1].Font.Size:=14;

 Sheet:=XLApp.Workbooks[1].WorkSheets['Школа-Преподаватели'];
 Sheet.Cells[1,2]:='Школа';
 Sheet.Cells[2,1]:='Фамилия';
 Sheet.Cells[2,2]:='Имя';
 Sheet.Cells[2,3]:='Должность';
 Sheet.Cells[2,4]:='Адрес';
 Sheet.Cells[2,5]:='Телефон';

 index:=3;
 DataModule1.PrepodTable.First;
 for i:=0 to DataModule1.PrepodTable.RecordCount-1 do
  begin
   Sheet.Cells[index,1]:=DataModule1.PrepodTable.Fields.Fields[1].AsString;
   Sheet.Cells[index,2]:=DataModule1.PrepodTable.Fields.Fields[2].AsString;
   Sheet.Cells[index,3]:=DataModule1.PrepodTable.Fields.Fields[3].AsString;
   Sheet.Cells[index,4]:=DataModule1.PrepodTable.Fields.Fields[5].AsString;
   Sheet.Cells[index,5]:=DataModule1.PrepodTable.Fields.Fields[4].AsString;
   Inc(index);
   DataModule1.PrepodTable.Next;
  end;
 end;

procedure TPrepodForm.N6Click(Sender: TObject);
begin
MessageDlg('Школа'#10#13'© 2006 Игорь Филиппов'#10#13'Версия 1.001',
mtInformation,[mbok],0);
end;

procedure TPrepodForm.N2Click(Sender: TObject);
begin
Close;
end;

procedure TPrepodForm.N7Click(Sender: TObject);
var
s:integer;
i:integer;
begin
s:=0;
for i:=0 to DataModule1.PrepodTable.RecordCount-1 do
 s:=s+1;
ShowMessage('Название таблицы: '+Datamodule1.PrepodTable.TableName+#13+'Количество записей: '+IntToStr(s));
end;



procedure TPrepodForm.N8Click(Sender: TObject);
begin
PersonalForm.Show;
PrepodForm.hide;
end;

procedure TPrepodForm.FormCreate(Sender: TObject);
begin
if login='admin' then N9.Visible:=true
  else n9.Visible:=false;
   if Dostup=false then begin
DBGrid1.Enabled:=false;
PrepodNavigator.VisibleButtons:=[nbFirst,nbNext,nbPrior,nbLast,nbRefresh];
DbGrid1.Font.Style:=[fsBold];
end;
end;

end.
