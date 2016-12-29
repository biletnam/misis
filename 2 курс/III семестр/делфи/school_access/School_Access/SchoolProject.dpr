program SchoolProject;

uses
  Forms,
  StudentUnit in 'StudentUnit.pas' {StudentForm},
  DataModuleUnit in 'DataModuleUnit.pas' {DataModule1: TDataModule},
  PrepodUnit in 'PrepodUnit.pas' {PrepodForm},
  UserUnit in 'UserUnit.pas' {UserForm},
  Unit1 in 'Unit1.pas' {PersonalForm},
  Unit2 in 'Unit2.pas' {UsersForm};

{$R *.res}

begin

  Application.Initialize;
  UserForm:=TUserForm.Create(Application);
  UserForm.Visible:=false;
  UserForm.ShowModal;
  UserForm.Hide;
  UserForm.Free;
  Application.CreateForm(TStudentForm, StudentForm);
  Application.CreateForm(TDataModule1, DataModule1);
  Application.CreateForm(TPrepodForm, PrepodForm);
  Application.CreateForm(TPersonalForm, PersonalForm);
  Application.CreateForm(TUsersForm, UsersForm);
  Application.Run;
end.
