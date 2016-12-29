program Project1;

uses
  Forms,
  Unit1 in 'Unit1.pas' {Funt_Kg};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFunt_Kg, Funt_Kg);
  Application.Run;
end.
