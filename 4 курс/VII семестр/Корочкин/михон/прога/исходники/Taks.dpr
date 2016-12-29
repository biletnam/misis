program Taks;

uses
  Forms,
  Main in 'Main.pas' {Form1},
  Logic in 'Logic.pas',
  Myclasses in 'Myclasses.pas',
  Input in 'Input.pas' {Form2};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.
