program Project_About;

uses
  Forms,
  About11 in 'About11.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TAboutForm, AboutForm);
  Application.Run;
end.
