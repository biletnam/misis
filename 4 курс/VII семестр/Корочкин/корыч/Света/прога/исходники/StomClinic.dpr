program StomClinic;
uses
  Forms,
  Myclasses in 'Myclasses.pas',
  LogicClasses in 'LogicClasses.pas',
  Stomatolog in 'Stomatolog.pas',
  Main in 'Main.pas' {Form1};

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
