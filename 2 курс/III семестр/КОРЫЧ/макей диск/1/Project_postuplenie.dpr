program Project_postuplenie;

uses
  Forms,
  Tabl_postuplenie in 'Tabl_postuplenie.pas' {Tabl_postup};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TTabl_postup, Tabl_postup);
  Application.Run;
end.
