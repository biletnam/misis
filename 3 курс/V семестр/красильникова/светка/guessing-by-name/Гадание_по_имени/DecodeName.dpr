program DecodeName;

uses
  Forms,
  Unit1 in 'Unit1.pas' {Form1},
  AboutUnit2 in 'AboutUnit2.pas' {Form2};

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'Программа гадания по нумерологии';
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
