program Project_pass;

uses
  Forms,
  Password in 'Password.pas' {PasswordForm};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TPasswordForm, PasswordForm);
  Application.Run;
end.
