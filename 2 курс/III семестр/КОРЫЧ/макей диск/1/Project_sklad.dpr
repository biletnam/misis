program Project_sklad;

uses
  Forms,
  Tabl_skladII in 'Tabl_skladII.pas' {Kod_sklad};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TKod_sklad, Kod_sklad);
  Application.Run;
end.
