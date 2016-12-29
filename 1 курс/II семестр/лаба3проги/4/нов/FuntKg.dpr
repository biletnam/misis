program FuntKg;

uses
  Forms,
  UnitFuntKg in 'UnitFuntKg.pas' {Funt_Kg};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFunt_Kg, Funt_Kg);
  Application.Run;
end.
