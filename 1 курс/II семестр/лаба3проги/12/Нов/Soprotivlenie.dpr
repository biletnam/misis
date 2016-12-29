program Soprotivlenie;

uses
  Forms,
  UnitSoprotivlenie in 'UnitSoprotivlenie.pas' {FormSoprotivlenie};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFormSoprotivlenie, FormSoprotivlenie);
  Application.Run;
end.
