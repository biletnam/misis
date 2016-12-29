unit StudentUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ADODB, Grids, DBGrids, Menus, ToolWin, ComCtrls, StdCtrls,
  ExtCtrls, DBCtrls,ComObj;

type
  TStudentForm = class(TForm)
    DBGrid1: TDBGrid;
    MainMenu1: TMainMenu;
    FileItem: TMenuItem;
    ExitItem: TMenuItem;
    CategoryItem: TMenuItem;
    SortItem: TMenuItem;
    ByFamItem: TMenuItem;
    ByClassItem: TMenuItem;
    ToolBar1: TToolBar;
    Label1: TLabel;
    FilterFamEdit: TEdit;
    StudentNavigator: TDBNavigator;
    HelpItem: TMenuItem;
    ProgrammInfo: TMenuItem;
    CategoryPrepod: TMenuItem;
    ExelItem: TMenuItem;
    TableInfoItem: TMenuItem;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    ToolButton1: TToolButton;
    procedure ByFamItemClick(Sender: TObject);
    procedure ByClassItemClick(Sender: TObject);
    procedure ExitItemClick(Sender: TObject);
    procedure FilterFamEditChange(Sender: TObject);
    procedure ProgrammInfoClick(Sender: TObject);
    procedure CategoryPrepodClick(Sender: TObject);
    procedure HelpMeItemClick(Sender: TObject);
    procedure ExelItemClick(Sender: TObject);
    procedure TableInfoItemClick(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  StudentForm: TStudentForm;

implementation

uses DataModuleUnit, PrepodUnit, UserUnit, Unit1, Unit2;

{$R *.dfm}

procedure TStudentForm.ByFamItemClick(Sender: TObject);
begin
DataModule1.StudentTable.Sort:='Фамилия';
end;

procedure TStudentForm.ByClassItemClick(Sender: TObject);
begin
DataModule1.StudentTable.Sort:='Класс';
end;

procedure TStudentForm.ExitItemClick(Sender: TObject);
begin
Close;
end;

procedure TStudentForm.FilterFamEditChange(Sender: TObject);
begin
If Length(FilterFamEdit.Text)>0 then
   DataModule1.StudentTable.Filtered:=True
else DataModule1.StudentTable.Filtered:=False;
DataModule1.StudentTable.Filter:='Фамилия>'''+FilterFamEdit.Text+'''';
end;

procedure TStudentForm.ProgrammInfoClick(Sender: TObject);
begin
MessageDlg('Школа'#10#13'© 2006 Игорь Филиппов'#10#13'Версия 1.0.1.1',
mtInformation,[mbok],0);
end;

procedure TStudentForm.CategoryPrepodClick(Sender: TObject);
begin
StudentForm.Hide;
PrepodForm.Show;
end;

procedure TStudentForm.HelpMeItemClick(Sender: TObject);
begin
//winhelp(StudentForm.Handle,'ШКОЛАH.hlp',HELP_CONTEXT,0);
end;


procedure TStudentForm.ExelItemClick(Sender: TObject);
var
 XLApp,Sheet,Colum:Variant;
 index,i:Integer;
begin
 XLApp:= CreateOleObject('Excel.Application');
 XLApp.Visible:=true;
 XLApp.Workbooks.Add(-4167);
 XLApp.Workbooks[1].WorkSheets[1].Name:='Школа-Ученики';
 Colum:=XLApp.Workbooks[1].WorkSheets['Школа-Ученики'].Columns;
 Colum.Columns[1].ColumnWidth:=20;
 Colum.Columns[2].ColumnWidth:=20;
 Colum.Columns[3].ColumnWidth:=20;
 Colum.Columns[4].ColumnWidth:=20;
 Colum.Columns[5].ColumnWidth:=20;

 Colum:=XLApp.Workbooks[1].WorkSheets['Школа-Ученики'].Rows;
 Colum.Rows[2].Font.Bold:=true;
 Colum.Rows[1].Font.Bold:=true;
 Colum.Rows[1].Font.Color:=clBlack;
 Colum.Rows[1].Font.Size:=14;

 Sheet:=XLApp.Workbooks[1].WorkSheets['Школа-Ученики'];
 Sheet.Cells[1,2]:='Школа';
 Sheet.Cells[2,1]:='Фамилия';
 Sheet.Cells[2,2]:='Имя';
 Sheet.Cells[2,3]:='Класс';
 Sheet.Cells[2,4]:='Адрес';
 Sheet.Cells[2,5]:='Телефон';

 index:=3;
 DataModule1.StudentTable.First;
for i:=0 to DataModule1.StudentTable.RecordCount-1 do
 begin
   Sheet.Cells[index,1]:=DataModule1.StudentTable.Fields.Fields[1].AsString;
   Sheet.Cells[index,2]:=DataModule1.StudentTable.Fields.Fields[2].AsString;
   Sheet.Cells[index,3]:=DataModule1.StudentTable.Fields.Fields[3].AsString;
   Sheet.Cells[index,4]:=DataModule1.StudentTable.Fields.Fields[5].AsString;
   Sheet.Cells[index,5]:=DataModule1.StudentTable.Fields.Fields[4].AsString;
   Inc(index);
   DataModule1.StudentTable.Next;
 end;
 end;
procedure TStudentForm.TableInfoItemClick(Sender: TObject);
var
s:integer;
i:integer;
begin
s:=0;
for i:=0 to DataModule1.StudentTable.RecordCount-1 do
 s:=s+1;
ShowMessage('Название таблицы: '+Datamodule1.StudentTable.TableName+#13+'Количество записей: '+IntToStr(s));
end;

procedure TStudentForm.N1Click(Sender: TObject);
begin
PersonalForm.Show;

end;

procedure TStudentForm.N2Click(Sender: TObject);
begin
UsersForm.ShowModal;
end;

procedure TStudentForm.FormActivate(Sender: TObject);
begin
If login='admin' then N2.Visible:=true
  else n2.Visible:=false;
end;

procedure TStudentForm.FormCreate(Sender: TObject);
begin
if Dostup=false then begin
DBGrid1.Enabled:=false;
StudentNavigator.VisibleButtons:=[nbFirst,nbNext,nbPrior,nbLast,nbRefresh];
DbGrid1.Font.Style:=[fsBold];
end;
end;
end.
