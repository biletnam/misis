program Manager_Base;

uses
  Forms,
  paswd in 'paswd.pas' {Form2},
  adsbaz in 'adsbaz.pas' {Form3},
  usprint in 'usprint.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm2, Form2);
  Application.CreateForm(TForm3, Form3);
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
