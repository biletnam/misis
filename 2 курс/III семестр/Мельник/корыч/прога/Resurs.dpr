program Resurs;

uses
  Forms,
  Main in 'Main.pas' {Form1},
  Zapros in 'Zapros.pas' {Form2},
  Password in 'Password.pas' {Form3};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm3, Form3);
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.
