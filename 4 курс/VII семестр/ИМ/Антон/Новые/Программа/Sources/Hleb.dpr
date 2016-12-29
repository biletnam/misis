program Hleb;

uses
  Forms,
  Main in 'Main.pas' {Form1},
  Myclasses in 'Myclasses.pas',
  Logic in 'Logic.pas',
  InputForm in 'InputForm.pas' {Form2},
  Stat in 'Stat.pas' {Form3};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm2, Form2);
  Application.CreateForm(TForm3, Form3);
  Application.Run;
end.
