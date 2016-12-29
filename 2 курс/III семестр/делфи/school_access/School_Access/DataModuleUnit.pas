unit DataModuleUnit;

interface

uses
  SysUtils, Classes, DB, ADODB;

type
  TDataModule1 = class(TDataModule)
    ADOConnection1: TADOConnection;
    StudentTable: TADOTable;
    StudentDataSource: TDataSource;
    StudentTableDSDesigner: TWideStringField;
    StudentTableDSDesigner2: TWideStringField;
    StudentTableDSDesigner3: TWideStringField;
    StudentTableDSDesigner4: TWideStringField;
    StudentTableDSDesigner5: TWideStringField;
    StudentTableKey1: TAutoIncField;
    PrepodDataSource: TDataSource;
    PrepodTable: TADOTable;
    PrepodTableKey1: TAutoIncField;
    PrepodTableDSDesigner: TWideStringField;
    PrepodTableDSDesigner2: TWideStringField;
    PrepodTableDSDesigner3: TWideStringField;
    PrepodTableDSDesigner4: TWideStringField;
    PrepodTableDSDesigner5: TWideStringField;
    UsersDataSource: TDataSource;
    PersonalTable: TADOTable;
    PersonalDataSource: TDataSource;
    PersonalTableKey1: TAutoIncField;
    PersonalTableDSDesigner: TWideStringField;
    PersonalTableDSDesigner2: TWideStringField;
    PersonalTableDSDesigner3: TWideStringField;
    PersonalTableDSDesigner4: TWideStringField;
    PersonalTableDSDesigner5: TWideStringField;
    UsersTable: TADOTable;
    UsersTableKey1: TAutoIncField;
    UsersTableDSDesigner: TWideStringField;
    UsersTableDSDesigner2: TWideStringField;
    UsersTableDSDesigner3: TBooleanField;
    procedure StudentTableAfterOpen(DataSet: TDataSet);
    procedure PrepodTableAfterOpen(DataSet: TDataSet);
    procedure PersonalTableAfterOpen(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DataModule1: TDataModule1;

implementation

uses Unit2, PrepodUnit, StudentUnit, Unit1, UserUnit;

{$R *.dfm}

procedure TDataModule1.StudentTableAfterOpen(DataSet: TDataSet);
begin
DataModule1.StudentTable.IndexFieldNames:='Фамилия';

end;

procedure TDataModule1.PrepodTableAfterOpen(DataSet: TDataSet);
begin
DataModule1.StudentTable.IndexFieldNames:='Фамилия';
end;

procedure TDataModule1.PersonalTableAfterOpen(DataSet: TDataSet);
begin
DataModule1.PersonalTable.Sort:='Фамилия';
end;

end.
