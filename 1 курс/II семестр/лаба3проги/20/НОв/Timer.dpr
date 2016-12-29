program Timer;

uses
  Forms,
  UnitTimer in 'UnitTimer.pas' {FormTimer};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFormTimer, FormTimer);
  Application.Run;
end.
